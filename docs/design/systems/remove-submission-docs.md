# Feature: 기존 제출 문서 삭제

## 목적

공모전 원본 제출 MD를 저장소에서 제거한다. 새 기능별 Codex 활용 기록은 별도로 작성한다.

## 동작 조건

- 과거 공모전 원본 제출 MD와 이미지는 `docs/submission/`에 두지 않는다.
- 새 기능별 Codex 활용 기록은 `docs/submission/codex-usage/`에 둘 수 있다.

## 예외 조건

- 과거 feature 설계·칸반 카드(`submission-*`, `contest-submission-docs`)는 이력으로 남긴다.
- Codex 활용 기록 작성은 후속 `codex-usage-push` feature가 담당한다.

## 영향받는 시스템

- `docs/submission/` 삭제.
- 해당 경로를 가리키던 설계 문서 참고 한 줄만 정리.

## Acceptance Criteria

- [x] 과거 공모전 원본 제출 MD·이미지가 없다
- [x] 문서 홈·README는 제출 MD를 링크하지 않는다
- [x] 기능별 Codex 활용 기록 경로는 기존 제출물과 분리된다

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | `docs/submission/codex-usage/` 기능별 기록 예외 명시 |
| 2026-08-19 | 기존 제출 MD·스크린샷 삭제 |
