from pathlib import Path
from PIL import Image, ImageOps
import pymupdf
import zipfile
import xml.etree.ElementTree as ET

root = next(Path('D:/Workspace/KNOU').rglob('Attention Is All You Need/.build')).parent
script = root / '발표 스크립트.md'
text = script.read_text(encoding='utf-8')
text = text.replace('예상 시간: 약 8분 55초(설명·장면 전환 속도에 따라 달라짐)', '예상 시간: 본문 약 8분 15초 + 도식 설명·장면 전환 여유 약 40초 = 전체 약 8분 55초(실제 말하는 속도에 따라 달라짐)')
text = text.replace(' EN-FR은 본문과 표의 수치 불일치가 있어 사용하지 않음.', '')
script.write_text(text, encoding='utf-8')

images = sorted((root / '미리보기').glob('슬라이드*.png'))
assert len(images) == 11
pdf = pymupdf.open()
for source in images:
    page = pdf.new_page(width=960, height=540)
    page.insert_image(page.rect, filename=str(source))
pdf_path = root / 'Attention Is All You Need_발표자료.pdf'
pdf.save(pdf_path, deflate=True)
pdf.close()
pdf = pymupdf.open(pdf_path)
for i, source in enumerate(images):
    from PIL import ImageChops
    pix = pdf[i].get_pixmap(matrix=pymupdf.Matrix(2, 2))
    rendered = Image.frombytes('RGB', [pix.width, pix.height], pix.samples)
    original = Image.open(source).convert('RGB')
    assert ImageChops.difference(original, rendered).getbbox() is None, i

thumb_w, thumb_h = 640, 360
sheet = Image.new('RGB', (thumb_w * 3, thumb_h * 4), '#e7eceb')
for i, source in enumerate(images):
    im = Image.open(source).convert('RGB').resize((thumb_w, thumb_h), Image.Resampling.LANCZOS)
    sheet.paste(im, ((i % 3) * thumb_w, (i // 3) * thumb_h))
sheet.save(root / '전체_미리보기.png')

pptx = root / 'Attention Is All You Need_발표자료.pptx'
with zipfile.ZipFile(pptx) as z:
    slides = [n for n in z.namelist() if n.startswith('ppt/slides/slide') and n.endswith('.xml')]
    notes = [n for n in z.namelist() if n.startswith('ppt/notesSlides/notesSlide') and n.endswith('.xml')]
    assert len(slides) == len(notes) == 11
print(f'Complete: {len(images)} slides, {len(pdf)} PDF pages, 11 speaker notes; PDF render matches all PNGs.')
print(root)
