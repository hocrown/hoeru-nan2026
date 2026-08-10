# 회루 (回樓) — NAN 2026 제출 빌드

지워진 역사 속 무림의 인물들을 '기억'으로 되살려 군단을 이끄는 수묵 미감의 소환 군단 서바이버.
**군단이 싸우고, 당신은 단 10초 동안 전설이 된다.**

**플레이**: index.html을 브라우저로 열거나 → GitHub Pages 링크 (아래)
- 웹 플레이: (배포 후 링크 기입)
- 플레이 영상: (YouTube 링크 기입)

조작 — 이동: WASD/방향키 · 경공(회피): Space · **공명(빙의 버스트): E** · 음소거: M
선택: 1/2/3 또는 클릭 · 모바일: 드래그 스틱 + 우하단 경공/공명 버튼 (데스크톱 검수용 강제: URL 뒤 `#touch`)

기술: 순수 HTML5 Canvas **단일 파일** (외부 라이브러리 0).
- 스프라이트 13종: AI 생성 (자체 sprite-gen 파이프라인 + OpenAI Codex image_gen — 상세: AI_USAGE_ADDENDUM.md). 파일 없으면 절차 생성 폴백으로 완전 동작.
- 사운드: WebAudio 절차 합성 SFX 13종 (외부 파일 0) + 선택적 BGM (`assets/bgm*.mp3`, SUNO 생성 시 기재).
설계 문서 전체는 docs/design/, AI 활용 내역은 submission_ai_tech.pdf + AI_USAGE_ADDENDUM.md 참조.
