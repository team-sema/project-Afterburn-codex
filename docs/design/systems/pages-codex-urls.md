# Feature: Codex Pages URL

## 목적

문서 홈·스펙·칸반 링크를 `project-Afterburn-codex` GitHub Pages로 가리킨다.

## 동작 조건

- Pages가 `main` / `/docs`로 배포된 경우 링크가 유효하다.

## 표시 정보

| 링크 | URL |
|------|-----|
| 문서 홈 | https://team-sema.github.io/project-Afterburn-codex/ |
| 스펙 | https://team-sema.github.io/project-Afterburn-codex/spec/ |
| 칸반 | https://team-sema.github.io/project-Afterburn-codex/board/ |
| 저장소 | https://github.com/team-sema/project-Afterburn-codex |

## 예외 조건

- (없음. 제출 MD는 `remove-submission-docs`에서 삭제.)

## 영향받는 시스템

- `README.md`, `docs/board/README.md`, `docs/index.html`만. 게임 코드 변경 없음.

## Acceptance Criteria

- [x] README 문서 홈·스펙·칸반 URL이 `project-Afterburn-codex` Pages다
- [x] 칸반 README Pages URL이 같다
- [x] 문서 홈 저장소 카드가 `github.com/team-sema/project-Afterburn-codex`다

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | 제출 MD 유지 예외 삭제 (`remove-submission-docs`) |
| 2026-08-19 | Codex Pages URL로 교체 |
