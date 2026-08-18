# Push 시 Codex 활용 기록

## 목적

각 feature를 main에 반영할 때 공모 제출용 Codex 활용 근거를 함께 축적한다.

## 동작 조건

- `/push`는 `docs/submission/codex-usage/<slug>.md`를 생성하거나 갱신한다.
- 기록은 대화, 시스템 스펙, 실제 diff, 테스트 결과에서 확인된 사실만 사용한다.
- 기록 파일은 해당 feature 커밋에 포함한다.

## 표시 정보

- Codex를 사용한 곳
- 구현한 기능
- 해결한 문제
- 사람이 직접 결정한 부분
- 요청·스펙부터 구현·검증까지의 활용 과정

## 예외 조건

- 확인할 수 없는 사람의 결정이나 테스트 결과는 추측하지 않고 `확인 필요`로 표시한다.
- 같은 slug의 기존 기록은 중복 생성하지 않고 갱신한다.

## 영향받는 시스템

- `.agents/skills/afterburn-push/SKILL.md`
- `.cursor/skills/push/SKILL.md`
- `docs/submission/codex-usage/`

## Acceptance Criteria

- [x] Codex와 Cursor의 `/push` 절차가 동일한 다섯 항목을 요구한다.
- [x] 활용 기록이 없으면 push를 중단한다.
- [x] 사람의 결정과 Codex 실행을 구분하고 근거 없는 내용을 만들지 않는다.
- [x] `/push` 성공 응답에 활용 기록 경로를 보고한다.

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | 기능별 Codex 활용 기록을 `/push` 필수 게이트로 추가 |
