#!/usr/bin/env bash
# NAN2026: prototype-6 에셋 13종 생산.
#  1) 적 3종 — 30.JinMuYeong T1 아틀라스 idle 프레임 재활용 (÷2 NEAREST + 좌우 반전)
#  2) 신규 10종 — codex 생성(마젠타 키 → 투명) 후 스펙 크기로 지배색 축소
# 실행: WSL Ubuntu에서 bash build_assets.sh [gen|shrink|reuse|all]
set -u
MAIN="/mnt/d/12.개인프로젝트/30.JinMuYeong/repo"
SG="$MAIN/tools/asset_pipeline/sprite-gen"
PY="$SG/.venv/bin/python"
FEST="/mnt/d/12.개인프로젝트/31.진무영-NHN FEST"
RAW="$FEST/tools/raw_static"
OUT="$FEST/prototype-6/assets"
TOOLS="$FEST/tools"
mkdir -p "$RAW" "$OUT"

PREFIX="tiny pixel art game sprite, transparent-ready, facing right, east-asian ink-wash silhouette style, dark ink tones, single accent color, crisp readable silhouette, no outline glow, no text, flat solid magenta #FF00FF background filling the whole canvas"

gen_one() {
  local name="$1" prompt="$2"
  "$PY" "$SG/scripts/generate_sprite_image.py" --provider codex \
    --prompt "$PREFIX. Subject: $prompt" \
    --out "$RAW/$name.png" --transparent \
    > "$RAW/$name.log" 2>&1 && echo "GEN_OK $name" || echo "GEN_FAIL $name"
}

do_gen() {
  local i=0
  gen_one player "young robed reader-protagonist, navy robe #33404e, topknot hair, standing" &
  gen_one player_res "female wuxia swordswoman, flowing navy robe, straight jian sword with blue #3d6b8f blade, faint blue aura" &
  gen_one seo "female wuxia swordswoman, flowing robe, straight jian sword, blue accent, calm stance" &
  gen_one wolf "small spirit wolf, dark blue-grey #4a5a66, running pose, low body" &
  wait
  gen_one crane "spirit crane with spread wings, grey-blue #7a8a94, flying" &
  gen_one turtle "small stone spirit turtle, moss-dark shell #5d6155, walking" &
  gen_one relic2 "single floating straight sword pointing up, vertical composition, dark steel blue #3a4a58" &
  gen_one mini "mad swordsman in tattered robe, oversized blade, deep black ink, menacing hunch" &
  wait
  gen_one boss "corrupted noble hero, massive dark robe #17131a, looming tall silhouette, faint red eyes" &
  gen_one gem "tiny round spirit bead, ink-gold #a6802a, simple orb with small glint" &
  wait
}

do_shrink() {
  set -- "player 30 46" "player_res 30 46" "seo 26 42" "wolf 26 20" "crane 28 20" \
         "turtle 24 22" "relic2 10 26" "mini 52 56" "boss 64 68" "gem 10 10"
  for spec in "$@"; do
    read -r n w h <<< "$spec"
    if [ -f "$RAW/$n.png" ]; then
      "$PY" "$TOOLS/shrink_sprite.py" "$RAW/$n.png" "$OUT/$n.png" "$w" "$h" || echo "SHRINK_FAIL $n"
    else
      echo "SKIP $n (raw 없음)"
    fi
  done
}

do_reuse() {
  # T1 아틀라스는 왼쪽을 보므로 --flip (스펙: 오른쪽) / 프레임은 논리해상도의 2배 → 절반 크기로
  "$PY" "$TOOLS/shrink_sprite.py" "$MAIN/assets/enemies/japgwi/frames/idle/frame-0.png" "$OUT/grunt.png" 24 22 --flip
  "$PY" "$TOOLS/shrink_sprite.py" "$MAIN/assets/enemies/wongwi/frames/idle/frame-0.png" "$OUT/wraith.png" 24 28 --flip
  "$PY" "$TOOLS/shrink_sprite.py" "$MAIN/assets/enemies/dolgwi/frames/idle/frame-0.png" "$OUT/ram.png" 42 30 --flip
  echo "REUSE_DONE"
}

case "${1:-all}" in
  gen) do_gen ;;
  shrink) do_shrink ;;
  reuse) do_reuse ;;
  all) do_reuse; do_gen; do_shrink ;;
esac
echo "BUILD_ASSETS_DONE"
