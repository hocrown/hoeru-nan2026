# 에셋 교체 사양 — assets/ 폴더

게임은 `assets/<이름>.png`가 존재하면 자동으로 사용하고, 없으면 코드 절차 생성 도형으로 폴백한다.
**일부만 넣어도 되고, 잘못된 파일이 있어도 게임은 깨지지 않는다.** 파일을 넣은 뒤 새로고침만 하면 적용.

## 공통 규칙
- PNG, **투명 배경 필수** (배경 있으면 사각형 티가 남)
- 정면 기준 **오른쪽을 바라보는** 방향으로 제작 (왼쪽 이동 시 코드가 자동 좌우 반전)
- 파일의 픽셀 크기가 곧 게임 내 표시 크기 (스케일 1:1, 픽셀 선명 렌더) — 아래 권장 크기 준수
- 스타일: 먹빛 실루엣 + 단색 포인트 1색 (게임 배경이 한지색 #f2ede3 이므로 어두운 톤이어야 판독됨)

## 파일 목록
| 파일명 | 대상 | 권장 크기(px) | 포인트 색 |
|---|---|---|---|
| player.png | 도윤 (본체) | 30×46 | 먹남색 #33404e |
| player_res.png | 공명 상태 (유서린 빙의) | 30×46 | 남색 #20242c + 청 #3d6b8f 검 |
| seo.png | 유서린 (소환수) | 26×42 | 남색 + 청 검 |
| wolf.png | 백랑 | 26×20 | #4a5a66 |
| crane.png | 백학 | 28×20 | #7a8a94 |
| turtle.png | 석귀 | 24×22 | #5d6155 |
| relic2.png | 명검 류월 (자율 검) | 10×26 | #3a4a58 |
| grunt.png | 잡귀 | 24×24 | 먹 #1c1a17 |
| wraith.png | 원귀 | 22×26 | #3a3630, 눈 2점 한지색 |
| ram.png | 돌귀 (엘리트) | 38×32 | #2a2723 |
| mini.png | 미니보스 광검수 | 52×56 | 심흑 + 검 |
| boss.png | 보스 타락한 대협 | 64×68 | 심흑 #17131a |
| gem.png | 원기 (경험치) | 10×10 | 금 #a6802a |

## 생성 경로 (택1)
1. **이미지 생성 모델** (Codex/나노바나나 등): 아래 프롬프트 시드 사용 후 배경 제거 → 위 크기로 축소
2. **sprite-gen 파이프라인**: 프로토타입 검증 겸 (repo_starter_kit의 T1-01 절차)
3. 직접 도트 (Aseprite)

### 프롬프트 시드 (공통 접두)
```
tiny pixel art game sprite, <N>x<M> pixels, transparent background, facing right,
east-asian ink-wash silhouette style, dark ink tones on transparency, single accent color,
crisp 1px readable silhouette, no outline glow, no background
```
- player: `young robed reader-protagonist, navy robe, topknot hair` (accent #33404e)
- player_res / seo: `female wuxia swordswoman, flowing robe, straight jian sword, blue accent`
- grunt: `collapsed human-shaped ink shadow wraith, hunched crawling`
- wraith: `floating torso ghost, long sleeves, two pale dot eyes`
- ram: `heavy four-legged stone-armored charging beast`
- mini: `mad swordsman in tattered robe, oversized blade`
- boss: `corrupted noble hero, massive dark robe, looming`

## 주의 (대회 규정)
- AI 생성 에셋 사용 시 → AI 활용 기술 문서의 '외부 에셋' 표에 **생성 도구·방식 기재 필수** (링크 전달 시 최종 PDF에 반영해 드림)
- 타인 저작 에셋(무료 에셋 팩 등) 사용 시 → 출처·라이선스 기재 필수. 라이선스 불명확한 이미지는 쓰지 말 것
