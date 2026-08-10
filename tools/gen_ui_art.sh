#!/usr/bin/env bash
# 타이틀 키 아트(후보 2) + 호명 카드 프레임 + 패널 — 일러스트 에셋 (도트화 없음)
# 실행: WSL Ubuntu에서 bash gen_ui_art.sh
set -u
SG="/mnt/d/12.개인프로젝트/30.JinMuYeong/repo/tools/asset_pipeline/sprite-gen"
PY="$SG/.venv/bin/python"
FEST="/mnt/d/12.개인프로젝트/31.진무영-NHN FEST"
RAW="$FEST/tools/raw_ui"
mkdir -p "$RAW"

TITLE="Korean ink-wash sumi-e painting, game title key art, wide landscape. An ancient multi-story pavilion emerging from mist on the right side, deep charcoal ink strokes on aged hanji paper texture (warm ivory #f2ede3). Foreground lower-left: small silhouette of a young woman swordswoman in a white robe with a water-blue #3d6b8f sash holding a slender jian, facing the pavilion. Faint ghostly ink shadows dissolving in the mist. Large empty negative space in the upper-center for title typography. Muted palette: ink black, ash grey, warm ivory, one water-blue accent, a single small red seal stamp. Atmospheric, melancholic, elegant. No text, no letters, no watermark."

CARD="Korean ink-wash style game UI card frame, portrait. Aged hanji paper card (warm ivory #f2ede3) with irregular hand-brushed ink border strokes, subtle paper fiber texture, a faint water stain near one corner, one small red seal stamp in the bottom-right corner, large empty center for text. Minimal, elegant, muted ink tones. No text, no letters, no watermark."

PANEL="Korean ink-wash style game UI panel background, wide landscape. Aged hanji paper sheet (warm ivory #f2ede3) with a hand-brushed ink rectangular border, subtle fiber texture and faint ink mist at the edges, large empty center. Minimal, elegant. No text, no letters, no watermark."

gen_one() {
  local name="$1" prompt="$2"
  "$PY" "$SG/scripts/generate_sprite_image.py" --provider codex \
    --prompt "$prompt" \
    --out "$RAW/$name.png" \
    > "$RAW/$name.log" 2>&1 && echo "GEN_OK $name" || echo "GEN_FAIL $name"
}

gen_one title_bg_c1 "$TITLE" &
gen_one title_bg_c2 "$TITLE Variation: pavilion slightly left of center-right, stronger mist, swordswoman closer to center." &
gen_one card "$CARD" &
gen_one panel "$PANEL" &
wait
echo "UI_ART_DONE"
