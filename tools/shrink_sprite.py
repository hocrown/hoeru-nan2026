#!/usr/bin/env python3
"""1024px급 RGBA 생성물 → 스펙 크기의 선명한 도트 스프라이트로 축소.

방식: 알파 bbox 크롭 → 타깃 격자 블록별 지배색 투표(kCentroid 계열) + 알파 다수결.
실행: <sprite-gen venv python> shrink_sprite.py <in.png> <out.png> <W> <H> [--flip]
"""
import sys

import numpy as np
from PIL import Image


def shrink(src: str, dst: str, tw: int, th: int, flip: bool = False) -> None:
    im = Image.open(src).convert("RGBA")
    a = np.asarray(im)
    ys, xs = np.nonzero(a[..., 3] > 10)
    if xs.size == 0:
        raise SystemExit(f"{src}: 알파 없음")
    crop = a[ys.min() : ys.max() + 1, xs.min() : xs.max() + 1]
    if flip:
        crop = crop[:, ::-1]
    h, w = crop.shape[:2]
    out = np.zeros((th, tw, 4), dtype=np.uint8)
    for ty in range(th):
        for tx in range(tw):
            y0, y1 = h * ty // th, max(h * (ty + 1) // th, h * ty // th + 1)
            x0, x1 = w * tx // tw, max(w * (tx + 1) // tw, w * tx // tw + 1)
            block = crop[y0:y1, x0:x1].reshape(-1, 4)
            opaque = block[block[:, 3] > 10]
            if opaque.size == 0 or len(opaque) / len(block) < 0.35:
                continue
            q = (opaque[:, :3] // 24).astype(np.int32)  # 24단계 양자화로 투표
            key = q[:, 0] * 10000 + q[:, 1] * 100 + q[:, 2]
            vals, counts = np.unique(key, return_counts=True)
            winner = vals[counts.argmax()]
            members = opaque[key == winner]
            out[ty, tx, :3] = members[:, :3].mean(axis=0)
            out[ty, tx, 3] = 255
    Image.fromarray(out, "RGBA").save(dst)
    print(f"{dst}: {tw}x{th} ok")


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if a != "--flip"]
    shrink(args[0], args[1], int(args[2]), int(args[3]), "--flip" in sys.argv)
