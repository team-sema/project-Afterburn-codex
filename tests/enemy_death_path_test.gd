extends SceneTree

var failures := PackedStringArray()


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	await _test_enemy_death_is_single_shot()
	await _test_offscreen_style_free_has_no_rewards()
	await _test_destroyed_component_auto_path()

	if failures.is_empty():
		print("enemy_death_path_test: PASS")
		quit(0)
		return
	for failure in failures:
		push_error("enemy_death_path_test: %s" % failure)
	print("enemy_death_path_test: FAIL (%d)" % failures.size())
	quit(1)


func _test_enemy_death_is_single_shot() -> void:
	var world := _make_world("SingleDeathWorld")
	var enemy := _spawn_enemy(world)
	var stats := enemy.stats_component
	var game_stats := enemy.score_component.game_stats
	var score_amount: int = enemy.score_component.adjust_amount
	var experience_drop := enemy.get_node("ExperienceDropComponent") as ExperienceDropComponent
	experience_drop.drop_chance = 1.0
	game_stats.score = 0
	var death_state := {"count": 0}
	stats.no_health.connect(func() -> void:
		death_state["count"] = int(death_state["count"]) + 1
	)

	stats.health = 0
	stats.health = 0
	stats.health = -1

	_expect(int(death_state["count"]) == 1, "no_health emits once for repeated lethal assignments")
	_expect(game_stats.score == score_amount, "score is awarded exactly once")
	_expect(_count_named_children(world, "ExplosionEffect") == 1, "default death FX spawns once")
	await process_frame
	await process_frame
	_expect(not is_instance_valid(enemy), "Enemy owns final removal")
	_expect(_count_experience_orbs(world) == 1, "XP orb spawns once")

	world.queue_free()
	await process_frame


func _test_offscreen_style_free_has_no_rewards() -> void:
	var world := _make_world("DespawnWorld")
	var enemy := _spawn_enemy(world)
	var game_stats := enemy.score_component.game_stats
	var baseline_score: int = game_stats.score
	enemy.queue_free()
	await process_frame

	_expect(game_stats.score == baseline_score, "direct despawn awards no score")
	_expect(_count_named_children(world, "ExplosionEffect") == 0, "direct despawn spawns no FX")
	_expect(_count_experience_orbs(world) == 0, "direct despawn drops no XP")

	world.queue_free()
	await process_frame


func _test_destroyed_component_auto_path() -> void:
	var world := _make_world("AutoDestroyWorld")
	var actor := Node2D.new()
	actor.name = "AutoDestroyedActor"
	var stats := StatsComponent.new()
	stats.name = "StatsComponent"
	var spawner := SpawnerComponent.new()
	spawner.name = "SpawnerComponent"
	spawner.scene = load("res://effects/explosion_effect.tscn") as PackedScene
	var destroyed := DestroyedComponent.new()
	destroyed.name = "DestroyedComponent"
	destroyed.actor = actor
	destroyed.stats_component = stats
	destroyed.destroy_effect_spawner_component = spawner
	actor.add_child(stats)
	actor.add_child(spawner)
	actor.add_child(destroyed)
	world.add_child(actor)

	stats.health = 0
	_expect(_count_named_children(world, "ExplosionEffect") == 1, "automatic destroy path keeps FX")
	await process_frame
	_expect(not is_instance_valid(actor), "automatic destroy path still frees non-Enemy actors")

	world.queue_free()
	await process_frame


func _make_world(world_name: String) -> Node2D:
	var world := Node2D.new()
	world.name = world_name
	world.add_to_group("gameplay_world")
	root.add_child(world)
	return world


func _spawn_enemy(world: Node2D) -> Enemy:
	var enemy := (load("res://enemies/enemy.tscn") as PackedScene).instantiate() as Enemy
	enemy.augment_registry = EnemyAugmentRegistry.new()
	world.add_child(enemy)
	return enemy


func _count_named_children(parent: Node, child_name: String) -> int:
	var count := 0
	for child in parent.get_children():
		if child.name == child_name or child.name.begins_with(child_name):
			count += 1
	return count


func _count_experience_orbs(parent: Node) -> int:
	var count := 0
	for child in parent.get_children():
		if child is ExperienceOrb:
			count += 1
	return count


func _expect(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
