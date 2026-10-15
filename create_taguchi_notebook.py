import json
from pathlib import Path

root = next(Path('.').rglob('hyperparameter_experiments.ipynb')).parent
original = json.loads((root / '2차 과제.ipynb').read_text(encoding='utf-8'))
helper = next(''.join(c['source']) for c in original['cells'] if 'def make_optimizer' in ''.join(c['source']))
helper = helper[:helper.index('def run_parameter_experiments')]

def md(s):
    return dict(cell_type='markdown', metadata={}, source=s.splitlines(keepends=True))

def code(s):
    return dict(cell_type='code', metadata={}, source=s.splitlines(keepends=True), execution_count=None, outputs=[])

setup = '''import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
import logging
logging.getLogger('tensorflow').setLevel(logging.ERROR)
import warnings
warnings.filterwarnings('ignore', message=r'dtype\\(\\): align should be passed as Python or NumPy boolean.*')
import gc
import json
import time
import hashlib
from pathlib import Path
from itertools import combinations
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf
from IPython.display import display
from tensorflow.keras import Sequential
from tensorflow.keras.datasets import reuters
from tensorflow.keras.layers import Input, Embedding, SimpleRNN, LSTM, Dropout, Dense
from tensorflow.keras.optimizers import Adam, RMSprop, SGD
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.utils import to_categorical
tf.get_logger().setLevel(logging.ERROR)
SEED = 123
OUTPUT = Path('taguchi_results')
OUTPUT.mkdir(exist_ok=True)
LEVELS = {
    'max_len': [100, 200], 'layers': [1, 2], 'units': [50, 100],
    'optimizer': ['Adam', 'RMSprop'], 'num_words': [1000, 5000],
    'embedding_dim': [32, 100], 'learning_rate': [0.0001, 0.001],
    'batch_size': [32, 100], 'dropout': [0.0, 0.2], 'epochs': [20, 40],
}
# L16の2水準直交表から10列を選びます。
ARRAY = np.array([[1 + ((row & col).bit_count() % 2)
                   for col in range(1, 11)] for row in range(16)])
for a, b in combinations(range(10), 2):
    assert all(np.sum((ARRAY[:, a] == x) & (ARRAY[:, b] == y)) == 4
               for x in [1, 2] for y in [1, 2])
design = pd.DataFrame([
    {'run': i + 1, **{key: values[level - 1]
      for (key, values), level in zip(LEVELS.items(), levels)}}
    for i, levels in enumerate(ARRAY)
])
display(design)
design.to_csv(OUTPUT / 'design_L16.csv', index=False, encoding='utf-8-sig')
'''.replace('# L16の2水準直交表から10列を選びます。', '# L16 2수준 직교배열에서 10개 열을 사용하며, 모든 열 쌍의 균형을 확인합니다.')
runner = '''RESULTS = {}

class Progress(tf.keras.callbacks.Callback):
    def on_epoch_end(self, epoch, logs=None):
        if (epoch + 1) % 5 == 0:
            print(f"  epoch {epoch + 1}: 검증 정확도={logs['val_accuracy']:.2%}", flush=True)


def run_one(family, run_id, config, phase='L16'):
    # 같은 설정이 완료되어 있으면 디스크 결과를 재사용합니다.
    fingerprint = {'version': 1, 'family': family, 'seed': SEED, **config}
    digest = hashlib.sha256(json.dumps(fingerprint, sort_keys=True).encode()).hexdigest()[:16]
    checkpoint = OUTPUT / f'{family}_{digest}.json'
    model_name = f'{family}__{phase}_{run_id}'
    if checkpoint.exists():
        saved = json.loads(checkpoint.read_text(encoding='utf-8'))
        row, history_data = saved['row'], saved['history']
        row = {**row, 'model_name': model_name, 'run': run_id, 'phase': phase}
        print(f'{model_name}: 완료 결과 재사용', flush=True)
    else:
        tf.keras.backend.clear_session()
        gc.collect()
        tf.keras.utils.set_random_seed(SEED)
        print(f'{model_name} 학습 시작: {config}', flush=True)
        started = time.perf_counter()
        x_train, y_train, x_test, y_test = load_experiment_data(config)
        model = build_model(family, config)
        history = model.fit(x_train, y_train, validation_split=0.10,
                            epochs=config['epochs'], batch_size=config['batch_size'],
                            shuffle=True, verbose=0, callbacks=[Progress()])
        history_data = {key: [float(v) for v in values] for key, values in history.history.items()}
        test = model.evaluate(x_test, y_test, verbose=0, return_dict=True)
        row = dict(model_type=family, model_name=model_name, run=run_id, phase=phase,
                   **config, train_accuracy=history_data['accuracy'][-1],
                   val_accuracy=history_data['val_accuracy'][-1],
                   val_loss=history_data['val_loss'][-1],
                   test_accuracy=float(test['accuracy']), test_loss=float(test['loss']),
                   seconds=time.perf_counter() - started)
        assert all(np.isfinite(row[key]) for key in ['val_accuracy', 'val_loss', 'test_accuracy', 'test_loss'])
        checkpoint.write_text(json.dumps({'row': row, 'history': history_data}, ensure_ascii=False, indent=2), encoding='utf-8')
        del model
        tf.keras.backend.clear_session()
        gc.collect()
    RESULTS[model_name] = row
    pd.DataFrame(RESULTS.values()).to_csv(OUTPUT / 'results.csv', index=False, encoding='utf-8-sig')
    print(f"{model_name}: 검증={row['val_accuracy']:.2%}, 테스트={row['test_accuracy']:.2%}, "
          f"손실={row['test_loss']:.4f}, 시간={row['seconds']:.1f}초", flush=True)
    fig, ax = plt.subplots(figsize=(8, 5))
    epochs = range(1, len(history_data['accuracy']) + 1)
    ax.plot(epochs, history_data['accuracy'], 'b--', label=f'{model_name}-train')
    ax.plot(epochs, history_data['val_accuracy'], 'b-', label=f'{model_name}-valid')
    ax.set(xlabel='Epoch', ylabel='Accuracy', ylim=(0, 1), title=f'{model_name}: Accuracy trace plot')
    ax.legend(loc='lower right')
    fig.tight_layout()
    fig.savefig(OUTPUT / f'{model_name}_accuracy.png', dpi=120)
    plt.show()
    plt.close(fig)
    return row


def run_design(family, number):
    record = design.iloc[number - 1].to_dict()
    config = {key: record[key] for key in LEVELS}
    return run_one(family, f'{number:02d}', config)
'''
analysis = '''screen = pd.DataFrame([r for r in RESULTS.values() if r['phase'] == 'L16'])
assert len(screen) == 32
display(screen[['model_name', 'val_accuracy', 'val_loss', 'test_accuracy', 'test_loss', 'seconds']])
SUGGESTED = {}
effects = []
for family in ['RNN', 'LSTM']:
    subset = screen[screen.model_type == family]
    config = {}
    for key, values in LEVELS.items():
        means = [float(subset.loc[subset[key] == value, 'val_accuracy'].mean()) for value in values]
        selected = int(np.argmax(means))
        config[key] = values[selected]
        effects.append(dict(model_type=family, parameter=key,
                            level_1=values[0], mean_val_1=means[0],
                            level_2=values[1], mean_val_2=means[1],
                            selected=values[selected], difference_pp=100 * (means[1] - means[0])))
    SUGGESTED[family] = config
effects_df = pd.DataFrame(effects)
display(effects_df)
effects_df.to_csv(OUTPUT / 'level_effects.csv', index=False, encoding='utf-8-sig')
(OUTPUT / 'suggested_configs.json').write_text(json.dumps(SUGGESTED, indent=2), encoding='utf-8')
print('검증 정확도 평균으로 선택한 확인 실험 설정:')
print(json.dumps(SUGGESTED, indent=2))
'''
summary = '''final = pd.DataFrame(RESULTS.values())
display(final[['model_name', 'val_accuracy', 'val_loss', 'test_accuracy', 'test_loss', 'seconds']])
lines = ['# 다구치 L16 실험 결과', '',
         '설정 선택은 마지막 epoch의 검증 정확도로 수행했습니다. 테스트 결과는 참고 평가값입니다.', '',
         '| 모델명 | 검증 정확도 | 테스트 정확도 | 테스트 손실 | 시간(초) |',
         '|---|---:|---:|---:|---:|']
for row in RESULTS.values():
    lines.append(f"| {row['model_name']} | {row['val_accuracy']:.2%} | {row['test_accuracy']:.2%} | {row['test_loss']:.4f} | {row['seconds']:.1f} |")
lines += ['', '## 모델별 검증 성능 비교', '']
for family in ['RNN', 'LSTM']:
    subset = final[(final.model_type == family) & (final.phase == 'L16')]
    best = subset.sort_values(['val_accuracy', 'val_loss'], ascending=[False, True]).iloc[0]
    confirm = final[(final.model_type == family) & (final.phase == 'confirmation')].iloc[0]
    lines.append(f"- {family}: L16 중 검증 최고는 {best['model_name']} (검증 {best['val_accuracy']:.2%}, 테스트 {best['test_accuracy']:.2%}). 수준 평균 조합의 확인 실험은 검증 {confirm['val_accuracy']:.2%}, 테스트 {confirm['test_accuracy']:.2%}.")
lines += ['', '수준 평균으로 예측한 조합이 실제 최고 조합과 일치한다고 보장하지 않습니다. 단일 시드 실행이며 모든 상호작용을 분리할 수 없습니다. 이미 살펴본 테스트 데이터이므로 독립적인 최종 평가로 해석하지 않습니다.']
(OUTPUT / '다구치_실험결과.md').write_text('\\n'.join(lines) + '\\n', encoding='utf-8')
'''
cells = [md('''# 다구치 방법론: L16 하이퍼파라미터 조합 실험
10개 파라미터를 각각 2수준으로 설정하고 L16 직교배열로 RNN·LSTM을 각각 16회 학습합니다.
공통 설정과 함수를 먼저 실행한 뒤 각 실험 셀을 독립 실행할 수 있습니다. 전체 실행 시 32개 조합과 모델별 확인 실험 1개씩을 수행합니다.
각 실험은 마지막 epoch의 검증 정확도로 비교합니다. 학습 72%·검증 8%·테스트 20%이며 시드는 123입니다.
수준별 평균 검증 정확도로 유망한 조합을 선택해 확인 실험을 합니다. 반복 시드 실험을 하지 않으므로 S/N비에 의한 강건성 분석은 수행하지 않습니다.
L16은 주효과 중심의 탐색이며 상호작용이 주효과에 섞일 수 있습니다. 전역 최적값을 보장하지 않습니다.
완료된 결과는 `taguchi_results`에 저장되어 커널을 재시작해도 재사용할 수 있습니다. 중단한 모델은 처음부터 다시 학습합니다.
각 셀의 테스트 결과는 참고용이며 조합 선택에는 사용하지 않습니다. 기존에 테스트 결과를 살펴봤으므로 독립적인 최종 평가로 해석하지 않습니다.
설계 근거: https://www.york.ac.uk/depts/maths/tables/orthogonal.htm
'''), md('## 공통 설정과 L16 조합표'), code(setup), md('## 공통 함수'), code(helper + '\n' + runner)]
for family in ['RNN', 'LSTM']:
    for i in range(1,17):
        cells.extend([md(f'## {family} — 조합 {i:02d}'), code(f"result_{family.lower()}_{i:02d} = run_design('{family}', {i})\n")])
cells.extend([md('## 수준별 평균 검증 정확도 및 확인 실험 조합 선정'), code(analysis)])
for family in ['RNN','LSTM']:
    cells.extend([md(f'## {family} — 수준 평균으로 선정한 조합의 확인 실험'), code(f"confirmation_{family.lower()} = run_one('{family}', 'best_levels', SUGGESTED['{family}'], phase='confirmation')\n")])
cells.extend([md('## 전체 결과 표 및 Markdown 저장'), code(summary)])
nb = dict(cells=cells, metadata={'kernelspec': {'display_name':'Python 3', 'language':'python','name':'python3'}, 'language_info': {'name':'python'}}, nbformat=4, nbformat_minor=5)
out=root/'다구치방법론.ipynb'
out.write_text(json.dumps(nb,ensure_ascii=False,indent=1)+'\n',encoding='utf-8')
import ast
for c in cells:
    if c['cell_type']=='code': ast.parse(''.join(c['source']))
print('Created notebook with 32 L16 runs and 2 confirmation cells; syntax verified.')
