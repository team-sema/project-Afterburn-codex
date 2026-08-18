# 적 사망 경로 정리 — Codex 활용 기록

## Codex를 어디에 사용했나요?

Project Afterburn의 적 사망 신호 연결, 점수·XP·파괴 FX·특수 사망·최종 삭제 경로를 분석하고 안전한 최소 리팩토링을 설계·구현·검증하는 데 사용했다.

## 어떤 기능을 구현했나요?

`StatsComponent.no_health`를 생존→사망 전환에서 한 번만 방출하도록 바꾸고, 적의 점수·기본 FX·최종 `queue_free`를 `Enemy`가 소유하도록 통일했다. 플레이어의 기존 자동 파괴는 유지했으며 Bomb은 signal 연결 해제 대신 다음 기본 FX 억제 API를 사용하도록 변경했다.

## 어떤 문제를 해결했나요?

중복 치명 입력으로 점수·XP·FX가 반복될 수 있고 `Enemy`와 `DestroyedComponent`가 모두 최종 삭제를 요청하던 책임 중복을 해결했다. Bomb이 다른 컴포넌트의 내부 signal 연결 방식에 의존하던 결합도 제거했다.

## 사람이 직접 결정한 부분은 무엇인가요?

사람은 남은 백로그 중 적 사망 경로를 우선 검토하도록 했고, 새 DeathCoordinator 같은 대형 계층 대신 사망 신호 단발화와 최종 free 소유권만 정리하는 최소 변경안을 선택해 구현하도록 결정했다.

## 활용 과정

1. Codex가 `no_health`의 모든 연결과 일반 적·Bomb·임사 체험·Tanker·offscreen despawn 경로를 추적했다.
2. 중복 free보다 반복 `no_health` 방출과 signal 연결 순서 의존이 핵심 위험임을 확인했다.
3. 사람과 합의한 최소 구조를 시스템 스펙과 Task에 먼저 기록했다.
4. 공용 `DestroyedComponent`의 플레이어 호환을 유지하면서 적 씬만 명시적 파괴 경로로 전환했다.
5. 일반·중복·despawn 신규 테스트와 Bomb·임사·Tanker·편대·XP·접촉 회귀 테스트를 Godot 4.7 headless로 실행해 모두 통과시켰다.
