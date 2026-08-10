#!/usr/bin/env bash
# 유서린 캐릭터 시트 기반 스프라이트 세트: 기본 / 절정(_2) / 화경(_3) / 공격 포즈(_atk)
# 실행: WSL Ubuntu에서 bash gen_seo_set.sh
set -u
SG="/mnt/d/12.개인프로젝트/30.JinMuYeong/repo/tools/asset_pipeline/sprite-gen"
PY="$SG/.venv/bin/python"
FEST="/mnt/d/12.개인프로젝트/31.진무영-NHN FEST"
RAW="$FEST/tools/raw_static"
OUT="$FEST/prototype-6/assets"
TOOLS="$FEST/tools"
mkdir -p "$RAW" "$OUT"

PREFIX="tiny pixel art game sprite, facing right, east-asian ink-wash wuxia style, crisp readable silhouette, no text, flat solid magenta #FF00FF background filling the whole canvas"
SEO="young female wuxia swordswoman, elegant WHITE robe with water-blue #3d6b8f sash, long black hair tied with a blue ribbon, slender straight jian sword, graceful"

gen_one() {
  local name="$1" prompt="$2"
  "$PY" "$SG/scripts/generate_sprite_image.py" --provider codex \
    --prompt "$PREFIX. Subject: $prompt" \
    --out "$RAW/$name.png" --transparent \
    > "$RAW/$name.log" 2>&1 && echo "GEN_OK $name" || echo "GEN_FAIL $name"
}

gen_one seo "$SEO, calm flowing stance, sword held low at her side — clearly feminine, bright white robe dominant" &
gen_one seo_2 "$SEO, dynamic ready stance, sword trailing a water-like blue energy ribbon, robe and sash fluttering" &
gen_one seo_3 "$SEO, luminous pale-blue aura and water ripple motif, faintly glowing white-blue blade, hair flowing upward, transcendent" &
gen_one seo_atk "$SEO, mid-swing diagonal slash pose, blade sweeping in a wide arc to the right, robe and hair swept by the motion" &
wait

"$PY" "$TOOLS/shrink_sprite.py" "$RAW/seo.png"     "$OUT/seo.png"     26 42 || echo "SHRINK_FAIL seo"
"$PY" "$TOOLS/shrink_sprite.py" "$RAW/seo_2.png"   "$OUT/seo_2.png"   28 44 || echo "SHRINK_FAIL seo_2"
"$PY" "$TOOLS/shrink_sprite.py" "$RAW/seo_3.png"   "$OUT/seo_3.png"   30 46 || echo "SHRINK_FAIL seo_3"
"$PY" "$TOOLS/shrink_sprite.py" "$RAW/seo_atk.png" "$OUT/seo_atk.png" 34 42 || echo "SHRINK_FAIL seo_atk"
echo "SEO_SET_DONE"
