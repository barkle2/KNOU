from pathlib import Path
from zipfile import ZipFile
from lxml import etree
from docx import Document
import math

p=Path('[6-2]데이터과학을 위한 수학/중간대체과제_풀이.docx')
ns={'w':'http://schemas.openxmlformats.org/wordprocessingml/2006/main',
    'm':'http://schemas.openxmlformats.org/officeDocument/2006/math'}
with ZipFile(p) as z:
    assert z.testzip() is None
    assert len(z.namelist()) == len(set(z.namelist()))
    root=etree.fromstring(z.read('word/document.xml'))
    assert len(root.xpath('//m:oMath',namespaces=ns)) == 37
    breaks=root.xpath('//w:br',namespaces=ns)
    assert sum(b.get('{'+ns['w']+'}type')=='page' for b in breaks) == 4
    for fraction in root.xpath('//m:f',namespaces=ns):
        assert fraction.find('{'+ns['m']+'}num') is not None
        assert fraction.find('{'+ns['m']+'}den') is not None
    for name in z.namelist():
        if name.endswith('.xml'):
            etree.fromstring(z.read(name))
d=Document(p)
headings=[v.text for v in d.paragraphs if v.style.name.startswith('Heading')]
assert len([h for h in headings if '번 소문항' in h]) == 10  # 2(3) spans two pages.
assert len(d.inline_shapes) == 2
print('DOCX archive/XML passed; 37 native equations; all 9 subquestions; 2 region diagrams.')
print('File size:',p.stat().st_size)

def L(w,b):
    return 0.5*(math.log1p(math.exp(-w-b))+math.log1p(math.exp(-w+b)))+0.25*(w*w+b*b)
eps=1e-6
w=2/3
dw=(L(w+eps,0)-L(w-eps,0))/(2*eps)
expected=w/2-1/(1+math.exp(w))
assert abs(dw-expected)<1e-8
assert L(w+0.001,0)<L(w,0)
assert abs(1-math.exp(-1)-0.6321205588285577)<1e-12
print('Finite-difference gradient, descent direction and probability checks passed.')
