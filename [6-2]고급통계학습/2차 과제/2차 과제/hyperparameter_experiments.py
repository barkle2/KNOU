# %% Imports and settings
from pathlib import Path
import csv
import gc
import time

import numpy as np
import pandas as pd
import tensorflow as tf
from tensorflow.keras import Sequential
from tensorflow.keras.datasets import reuters
from tensorflow.keras.layers import Input, Embedding, SimpleRNN, LSTM, Dropout, Dense
from tensorflow.keras.optimizers import Adam, RMSprop, SGD
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.utils import to_categorical

SEED = 123
EPOCHS = 20
RESULTS_PATH = Path('hyperparameter_test_results.csv')

BASE = dict(
    max_len=100, layers=1, units=50, optimizer='Adam',
    num_words=1000, embedding_dim=100, learning_rate=0.001,
    batch_size=100, dropout=0.0,
)
CANDIDATES = {
    'max_len': [50, 100, 200, 300, 500, 800],
    'layers': [1, 2, 3, 5, 7, 10],
    'units': [16, 32, 50, 100, 160, 256],
    'optimizer': ['Adam', 'RMSprop', 'SGD', 'MomentumSGD'],
    'num_words': [500, 1000, 3000, 5000, 10000],
    'embedding_dim': [32, 64, 100, 128, 256],
    'learning_rate': [0.0001, 0.0005, 0.001, 0.005, 0.01, 0.05],
    'batch_size': [16, 32, 64, 100, 128, 256],
    'dropout': [0.0, 0.2, 0.4],
}

# %% Experiment definitions and model construction
def make_experiments():
    experiments = []
    for model_type in ['RNN', 'LSTM']:
        baseline = {**BASE, 'units': 50 if model_type == 'RNN' else 100}
        experiments.append((model_type, f'{model_type}__baseline', 'baseline', baseline))
        for parameter, values in CANDIDATES.items():
            for value in values:
                if value == baseline[parameter]:
                    continue  # The baseline already covers this setting.
                config = {**baseline, parameter: value}
                name = f'{model_type}__{parameter}_{value}'
                experiments.append((model_type, name, parameter, config))
    return experiments


def make_optimizer(config):
    lr = config['learning_rate']
    return {
        'Adam': lambda: Adam(learning_rate=lr),
        'RMSprop': lambda: RMSprop(learning_rate=lr),
        'SGD': lambda: SGD(learning_rate=lr),
        'MomentumSGD': lambda: SGD(learning_rate=lr, momentum=0.9),
    }[config['optimizer']]()


def build_model(model_type, config):
    recurrent_layer = SimpleRNN if model_type == 'RNN' else LSTM
    model = Sequential([
        Input(shape=(config['max_len'],), dtype='int32'),
        Embedding(config['num_words'], config['embedding_dim']),
    ])
    for layer_index in range(config['layers']):
        model.add(recurrent_layer(
            config['units'], activation='tanh',
            return_sequences=layer_index < config['layers'] - 1,
        ))
    if config['dropout'] > 0:
        model.add(Dropout(config['dropout']))
    model.add(Dense(46, activation='softmax'))
    model.compile(
        optimizer=make_optimizer(config),
        loss='categorical_crossentropy', metrics=['accuracy'],
    )
    return model


def load_experiment_data(config):
    # The same seed preserves sample membership and order across vocabulary sizes.
    (x_train, y_train), (x_test, y_test) = reuters.load_data(
        num_words=config['num_words'], test_split=0.2, seed=SEED,
    )
    x_train = pad_sequences(x_train, maxlen=config['max_len'],
                            padding='pre', truncating='pre')
    x_test = pad_sequences(x_test, maxlen=config['max_len'],
                           padding='pre', truncating='pre')
    return (x_train, to_categorical(y_train, num_classes=46),
            x_test, to_categorical(y_test, num_classes=46))


EXPERIMENTS = make_experiments()
assert len(EXPERIMENTS) == 78
assert len({name for _, name, _, _ in EXPERIMENTS}) == 78
for model_type, _, parameter, config in EXPERIMENTS:
    baseline = {**BASE, 'units': 50 if model_type == 'RNN' else 100}
    changed = [key for key in BASE if config[key] != baseline[key]]
    assert changed == ([] if parameter == 'baseline' else [parameter])
print(f'Experiments: {len(EXPERIMENTS)} (RNN 39 + LSTM 39)')
print(f'Results file: {RESULTS_PATH.resolve()}')

# %% Train each configuration and print test results
results = []
print(f"{'No.':>5}  {'Model name':<34} {'Test loss':>11} {'Test accuracy':>14} {'Seconds':>10}")
print('-' * 84)

# A new run replaces the previous CSV. Each completed experiment is saved immediately.
with RESULTS_PATH.open('w', newline='', encoding='utf-8-sig') as result_file:
    writer = None
    for number, (model_type, name, parameter, config) in enumerate(EXPERIMENTS, 1):
        tf.keras.backend.clear_session()
        gc.collect()
        tf.keras.utils.set_random_seed(SEED)
        started = time.perf_counter()
        model = None
        row = dict(model_type=model_type, model_name=name,
                   changed_parameter=parameter, **config)
        try:
            x_train, y_train, x_test, y_test = load_experiment_data(config)
            model = build_model(model_type, config)
            # Preserve the supplied baseline: 20 epochs, final-epoch weights,
            # last 10% of training data for validation, and no early stopping.
            model.fit(
                x_train, y_train, batch_size=config['batch_size'],
                epochs=EPOCHS, validation_split=0.10, shuffle=True, verbose=0,
            )
            scores = model.evaluate(x_test, y_test, verbose=0, return_dict=True)
            loss, accuracy = float(scores['loss']), float(scores['accuracy'])
            finite = np.isfinite(loss) and np.isfinite(accuracy)
            row.update(test_loss=loss, test_accuracy=accuracy,
                       status='ok' if finite else 'non_finite', error='')
        except (tf.errors.OpError, ValueError) as exc:
            row.update(test_loss=np.nan, test_accuracy=np.nan,
                       status='failed', error=str(exc).replace('\n', ' ')[:500])
        row['seconds'] = time.perf_counter() - started
        results.append(row)
        if writer is None:
            writer = csv.DictWriter(result_file, fieldnames=list(row))
            writer.writeheader()
        writer.writerow(row)
        result_file.flush()
        print(f"{number:>2}/78  {name:<34} {row['test_loss']:>11.4f} "
              f"{row['test_accuracy']:>13.2%} {row['seconds']:>10.1f}", flush=True)
        if row['status'] != 'ok':
            print(f"       Status: {row['status']} {row['error']}", flush=True)
        del model

# %% Final table in experiment order; compare against each model's baseline
results_df = pd.DataFrame(results)
baseline_accuracy = results_df.loc[
    results_df['changed_parameter'].eq('baseline')
].set_index('model_type')['test_accuracy']
results_df['difference_pp'] = 100 * (
    results_df['test_accuracy'] - results_df['model_type'].map(baseline_accuracy)
)
columns = ['model_name', 'test_loss', 'test_accuracy', 'difference_pp', 'seconds', 'status']
print('\nTest results (difference_pp = percentage points relative to baseline)')
print(results_df[columns].to_string(index=False, formatters={
    'test_loss': '{:.4f}'.format,
    'test_accuracy': '{:.2%}'.format,
    'difference_pp': '{:+.2f}'.format,
    'seconds': '{:.1f}'.format,
}))
