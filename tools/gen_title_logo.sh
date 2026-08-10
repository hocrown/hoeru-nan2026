#!/usr/bin/env bash
# 타이틀 로고 「回樓」 붓글씨 후보 3종 (세로 구성, 마젠타 키 → 투명)
# 실행: WSL Ubuntu에서 bash gen_title_logo.sh
set -u
SG="/mnt/d/12.개인프로젝트/30.JinMuYeong/repo/tools/asset_pipeline/sprite-gen"
PY="$SG/.venv/bin/python"
FEST="/mnt/d/12.개인프로젝트/31.진무영-NHN FEST"
RAW="$FEST/tools/raw_ui"
mkdir -p "$RAW"

BASE="East asian brush calligraphy artwork of exactly the two Chinese characters 回樓, written VERTICALLY — 回 on top, 樓 below. Accurate stroke structure of each character, bold expressive ink brush strokes, dry-brush texture at stroke ends, subtle ink bleed, deep charcoal-black ink. Flat solid magenta #FF00FF background filling the whole canvas. No other text, no seal, no decorations, portrait composition."

gen_one() {
  local name="$1" extra="$2"
  "$PY" "$SG/scripts/generate_sprite_image.py" --provider codex \
    --prompt "$BASE $extra" \
    --out "$RAW/$name.png" --transparent \
    > "$RAW/$name.log" 2>&1 && echo "GEN_OK $name" || echo "GEN_FAIL $name"
}

gen_one title_logo_a "Style: powerful kaishu regular script, thick confident strokes." &
gen_one title_logo_b "Style: semi-cursive xingshu, flowing energetic strokes with visible brush speed." &
gen_one title_logo_c "Style: weathered ancient stele inscription feel, rough edges, heavy ink pooling." &
wait
echo "LOGO_DONE"
