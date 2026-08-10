# AI 활용 부록 — 2026-08-10 최종 스프린트 (submission_ai_tech.pdf 갱신용 원고)

> 규정 대응: AI 생성 에셋의 생성 도구·방식 기재 (외부 에셋 표). PDF 재생성 시 본 문서를 반영할 것.

## 1. 멀티 에이전트 제작 체계 (본 스프린트)

| 역할 | 모델/도구 | 담당 |
|---|---|---|
| PM·기획·에셋 | Claude Fable 5 (Claude Code) | 오케스트레이션, 에셋 파이프라인 실행·QA, 제출물 |
| 코딩 워커 | Claude Opus 5 (Paseo 오케스트레이션) | index.html 게임필·오디오·타이틀 폴리시 (커밋 이력으로 증빙) |
| 이미지 생성 백엔드 | OpenAI Codex CLI `image_gen` (GPT 이미지 도구) | 스프라이트 원화 10종 생성 |
| 외부 비평 | GPT-5.6 Sol (Codex CLI) | 본 프로젝트 컨셉 문서 비평 (docs/design 개정에 반영) |

## 2. 이미지 에셋 명세 (전량 AI 생성 + 자체 결정론 후처리)

- **적 3종 (grunt/wraith/ram)**: 본 프로젝트의 자체 에셋 파이프라인(aldegad/sprite-gen 기반, Apache-2.0)으로 사전 제작한
  적 스프라이트 아틀라스(잡귀·원귀·돌귀 — codex image_gen 생성 → 결정론 픽셀 언페이크 추출)의 idle 프레임을
  재활용: NEAREST 축소 + 좌우 반전 + 지배색 블록 축소(tools/shrink_sprite.py).
- **신규 10종 (player/player_res/seo/wolf/crane/turtle/relic2/mini/boss/gem)**: codex image_gen으로
  마젠타 크로마 배경 생성 → sprite-gen `--transparent` 크로마 제거 → 지배색 블록 축소로 스펙 크기(10×10~64×68) 도트화.
- 프롬프트 시드·크기 규격: assets/ASSET_SPEC.md. 생성·후처리 스크립트: tools/build_assets.sh, tools/shrink_sprite.py (저장소 포함 — 재현 가능).
- 타인 저작 에셋: **없음** (전량 AI 생성 + 자체 후처리. sprite-gen 도구는 Apache-2.0, 저장소 THIRD_PARTY 고지 참조).

## 3. 사운드

- SFX 13종: WebAudio 절차 합성 (외부 파일·샘플 0 — 코드 생성).
- BGM: SUNO AI로 생성 (프롬프트 설계: Claude / 생성 실행: 팀원 계정). 파일: assets/bgm.mp3, assets/bgm_boss.mp3.
  ※ 최종 제출 시 실제 포함 여부에 따라 본 항목 유지/삭제.

## 4. AI 활용의 구조적 증빙

- git 커밋 이력: 베이스라인 → 에셋 → 게임필 커밋이 역할별로 분리 (PM/워커 각자 커밋).
- 기획 문서(docs/design/)는 별도 저장소에서 AI 협업으로 발전 중 (외부 모델 교차 비평 포함) — 발췌 동봉본.
- 에셋 재현성: 동일 스크립트 재실행으로 동일 파이프라인 재현 가능 (생성 모델 특성상 이미지는 확률적).
