extends SceneTree

const MENU_SCENE := preload("res://menus/menu.tscn")

var failures: PackedStringArray = []


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var menu := MENU_SCENE.instantiate() as Control
	root.add_child(menu)
	current_scene = menu
	menu.set_process(false)

	menu.call("_request_start")
	menu.call("_enter_game_when_ready")
	var start_label := menu.get_node("CenterContainer/VBoxContainer/StartLabel") as Label
	_expect(start_label.text == "게임 준비 중...", "early start input shows loading feedback")

	var deadline := Time.get_ticks_msec() + 10000
	while menu.get("_game_scene") == null and Time.get_ticks_msec() < deadline:
		menu.call("_poll_game_scene_load")
		await process_frame
	_expect(menu.get("_game_scene") is PackedScene, "game scene finishes loading in the background")

	if menu.get("_game_scene") != null:
		menu.call("_enter_game_when_ready")
		await process_frame
		await process_frame
		_expect(current_scene != null and current_scene.name == "World", "loaded game scene becomes current")
	if current_scene != null:
		current_scene.queue_free()
		current_scene = null
		await process_frame

	if failures.is_empty():
		print("menu loading smoke test: PASS")
		quit()
		return
	for failure in failures:
		push_error("menu loading smoke test: %s" % failure)
	quit(1)


func _expect(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
