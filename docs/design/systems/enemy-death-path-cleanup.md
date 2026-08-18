# 적 사망 경로 정리

## 목적

적 사망 보상과 파괴 연출이 중복되지 않도록 신호와 최종 삭제 책임을 명확히 한다.

## 동작 조건

1. `StatsComponent.no_health`는 HP가 양수에서 0 이하로 바뀌고 `health_changed` 소비자가 HP를 복구하지 않았을 때 한 번만 방출한다.
2. 적은 `Enemy._on_no_health()` 한 곳에서 중복 진입을 막고 점수, 기본 FX, 최종 `queue_free`를 처리한다.
3. XP 드롭과 사망 반격 같은 선택 기능은 `no_health` 소비자로 유지한다.
4. 플레이어는 `DestroyedComponent`의 기존 자동 FX+free 경로를 유지한다.

## 특수 사망

- 임사 체험: `health_changed`에서 HP를 1로 복구하므로 첫 치명타는 `no_health`를 방출하지 않는다. 타이머 종료 후 1→0 전환에서 한 번 사망한다.
- Bomb 자폭: 전용 확대 FX와 범위 피해 후 다음 기본 FX를 억제하고 일반 `no_health` 보상·free 경로를 사용한다.
- 화면 밖 despawn: 직접 `queue_free`하며 점수·XP·파괴 FX가 없다.

## 예외 조건

- 새 DeathCoordinator 계층은 만들지 않는다.
- 사망하지 않은 접촉 적의 동작은 변경하지 않는다.
- Player Ship 사망 흐름은 변경하지 않는다.

## 영향받는 시스템

- `components/stats_component.gd`
- `components/destroyed_component.gd`
- `components/bomb_proximity_fuse_component.gd`
- `enemies/enemy.gd`, `enemies/enemy.tscn`
- 적 사망 회귀 테스트

## Acceptance Criteria

- [x] 반복 `health = 0`에도 `no_health`, 점수, 기본 FX가 한 번이다.
- [x] 일반 적의 최종 free는 `Enemy`만 호출한다.
- [x] 플레이어의 `DestroyedComponent` 자동 파괴는 유지된다.
- [x] Bomb은 기본 FX 없이 전용 FX만 사용하며 점수·XP는 일반 경로를 탄다.
- [x] 임사 체험과 Tanker 실드/본체 테스트가 유지된다.
- [x] offscreen despawn은 처치 보상을 만들지 않는다.

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | 사망 신호 단발화·적 free 단일 소유 설계 |
