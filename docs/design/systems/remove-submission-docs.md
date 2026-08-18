# Feature: 기존 제출 문서 삭제

## 목적

공모전 원본 제출 MD를 저장소에서 제거한다. Codex용 제출 문서는 별도로 작성한다.

## 동작 조건

- `docs/submission/` 아래 파일은 없다.

## 예외 조건

- 과거 feature 설계·칸반 카드(`submission-*`, `contest-submission-docs`)는 이력으로 남긴다.
- Codex 제출 문서 작성은 이 feature 범위 밖이다.

## 영향받는 시스템

- `docs/submission/` 삭제.
- 해당 경로를 가리키던 설계 문서 참고 한 줄만 정리.

## Acceptance Criteria

- [x] `docs/submission/` 트랙 파일이 없다
- [x] 문서 홈·README는 제출 MD를 링크하지 않는다
- [ ] Codex용 제출 문서는 아직 없다 (후속)

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | 기존 제출 MD·스크린샷 삭제 |
