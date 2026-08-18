# Task: 적 사망 경로 정리

## 목적

공용 HP 신호의 중복 방출을 막고 적 파괴의 최종 책임을 단일화한다.

## 수정 예상 파일

- `components/stats_component.gd`
- `components/destroyed_component.gd`
- `components/bomb_proximity_fuse_component.gd`
- `enemies/enemy.gd`, `enemies/enemy.tscn`
- `tests/enemy_death_path_test.gd`
- 관련 설계·현황 스펙·칸반 문서

## 수정 금지 파일

- 플레이어 사망 동작과 게임 오버 흐름
- 점수·XP 수치와 드롭 확률
- 적 이동·공격·스폰 밸런스

## 완료 조건

- [x] `no_health` 생존→사망 전환 1회 보장
- [x] 적의 기본 FX·점수·최종 free를 `Enemy`로 통일
- [x] 플레이어 자동 파괴 호환 유지
- [x] Bomb signal disconnect 제거
- [x] 일반·중복·despawn 사망 회귀 테스트 추가
- [x] 기존 Bomb·임사·Tanker 테스트 통과

## 검증

- `enemy_death_path_test.gd`: PASS
- `bomb_proximity_fuse_smoke_test.gd`: OK
- `enemy_near_death_experience_smoke_test.gd`: PASS
- `tanker_enemy_smoke_test.gd`: PASS
- `weapon_pickup_physics_test.gd`: PASS
- `drone_diagonal_formation_smoke_test.gd`: PASS
- `interceptor_enemy_smoke_test.gd`: PASS
- `enemy_contact_survival_smoke_test.gd`: PASS
- Godot 4.7 headless editor parse: exit 0

---

## 변경 이력

| 날짜 | 변경 |
|------|------|
| 2026-08-19 | Task 작성 |
