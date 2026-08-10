#!/usr/bin/env python3
"""assets/ 13종을 한지색 배경에 4배 확대로 배열한 QA 콘택트 시트 생성."""
import sys
from pathlib import Path

from PIL import Image, ImageDraw

SRC = Path(sys.argv[1])
OUT = sys.argv[2]
NAMES = ["player", "player_res", "seo", "wolf", "crane", "turtle", "relic2",
         "grunt", "wraith", "ram", "mini", "boss", "gem"]
SCALE, CELL_W, CELL_H, COLS = 4, 300, 320, 5
rows = (len(NAMES) + COLS - 1) // COLS
sheet = Image.new("RGB", (COLS * CELL_W, rows * CELL_H), (242, 237, 227))
draw = ImageDraw.Draw(sheet)
for i, n in enumerate(NAMES):
    cx = (i % COLS) * CELL_W + CELL_W // 2
    cy = (i // COLS) * CELL_H + CELL_H // 2 - 20
    p = SRC / f"{n}.png"
    if p.exists():
        im = Image.open(p).convert("RGBA")
        up = im.resize((im.width * SCALE, im.height * SCALE), Image.NEAREST)
        sheet.paste(up, (cx - up.width // 2, cy - up.height // 2), up)
        label = f"{n} {im.width}x{im.height}"
    else:
        label = f"{n} (없음)"
    draw.text((cx - 60, (i // COLS) * CELL_H + CELL_H - 40), label, fill=(60, 55, 50))
sheet.save(OUT)
print(f"sheet: {OUT}")
