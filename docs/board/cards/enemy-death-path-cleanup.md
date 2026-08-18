# 적 사망 경로 정리

## 현황

`Enemy`와 `DestroyedComponent`가 모두 `no_health`에서 `queue_free`를 호출한다. `StatsComponent`는 HP가 이미 0 이하인 상태에서도 다시 대입될 때마다 `no_health`를 방출할 수 있고, Bomb은 기본 FX 연결을 직접 해제한다.

## 목표

사망 신호를 생존→사망 전환에서 한 번만 방출하고, 적의 점수 → 기본 FX → 최종 free를 `Enemy`가 소유한다. 플레이어의 기존 자동 파괴 동작은 유지한다.

## AC

- [x] 중복 치명 입력에도 `no_health`·점수·기본 FX는 한 번만 발생
- [x] 적 최종 `queue_free` 소유자는 `Enemy`
- [x] Bomb은 signal disconnect 없이 전용 FX만 생성
- [x] 임사 체험은 첫 치명타를 보류하고 1초 뒤 한 번만 사망
- [x] 화면 밖 despawn은 처치 보상을 발생시키지 않음

## 구현

- 2026-08-19 feature/enemy-death-path-cleanup
- 2026-08-19 feature/enemy-death-path-cleanup → main (검증 대기)
