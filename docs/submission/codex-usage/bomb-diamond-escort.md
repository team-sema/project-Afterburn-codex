# Bomb 드론 다이아몬드 호위 — Codex 활용 기록

## Codex를 어디에 사용했나요?

Bomb Encounter의 기존 Tanker 호위를 Drone 다이아몬드 편대로 교체하고, 관련 리소스·스폰 풀·현황 스펙·Task·스모크 테스트를 함께 갱신하는 데 사용했다.

## 어떤 기능을 구현했나요?

Threat 2+의 Bomb Encounter를 `bomb_drone_diamond`으로 교체했다. 5슬롯 다이아몬드 중앙에 Bomb를 두고 상·좌·우·하에 Drone 4기를 배치했으며, 편대가 플레이어를 향해 40px/s로 접근하도록 구성했다. 기존 근접 기폭, 폭발 범위 내 적 처치, 고속 신관 증강은 유지했다.

## 어떤 문제를 해결했나요?

Bomb가 방어적인 Tanker와 함께 등장해 의도한 전투 인상과 맞지 않고, 접근 속도 22px/s가 너무 느리게 느껴지는 문제를 해결했다. Encounter id와 구성 변경으로 생길 수 있는 스폰 풀·테스트·문서 불일치도 함께 정리했다.

## 사람이 직접 결정한 부분은 무엇인가요?

사람은 Bomb를 Tanker 대신 여러 Drone이 둘러싼 다이아몬드 중앙에 배치하고, 느린 접근 속도를 높이도록 결정했다. Codex는 기존 5슬롯 레이아웃을 재사용해 Drone 4기와 중앙 Bomb으로 구체화하고 속도를 40px/s로 조정했다.

## 활용 과정

1. 기존 `tanker_bomb_vertical` 구성과 Bomb 기폭·증강·스폰 테스트를 추적했다.
2. `bomb_drone_diamond` 프리셋과 전용 접근 시퀀스를 만들고 MainEncounterPool의 Threat 2 항목을 교체했다.
3. 사용자 피드백에 따라 접근 속도를 22px/s에서 40px/s로 높였다.
4. 현황 스펙, 시스템 문서, Task와 칸반 카드를 새 Encounter 구성에 맞췄다.
5. Godot 4.7 프로젝트 파싱과 enemy threat spawn, encounter spawner, enemy augment policy, bomb proximity fuse 스모크 테스트가 모두 통과함을 확인했다. 테스트 종료 시 기존 RID/ObjectDB 정리 경고는 별도로 발생했다.
