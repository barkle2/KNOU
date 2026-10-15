import os
import time
from pathlib import Path
import nbformat
from nbclient import NotebookClient

root = next(Path('.').rglob('hyperparameter_experiments.ipynb')).parent.resolve()
p = root / '다구치방법론.ipynb'
nb = nbformat.read(p, as_version=4)
os.chdir(root)
client = NotebookClient(nb, timeout=None, kernel_name='python3', resources={'metadata': {'path': str(root)}})
started = time.perf_counter()
try:
    with client.setup_kernel():
        for index, cell in enumerate(nb.cells):
            if cell.cell_type != 'code':
                continue
            print(f'CELL {index}: {cell.source.splitlines()[0][:100]}', flush=True)
            client.execute_cell(cell, index)
            nbformat.write(nb, p)
            for output in cell.get('outputs', []):
                if output.output_type == 'stream':
                    print(output.text, end='', flush=True)
            print(f'CELL {index} saved; elapsed {time.perf_counter() - started:.0f}s', flush=True)
finally:
    nbformat.write(nb, p)
print('ALL EXPERIMENTS COMPLETED', flush=True)
