extends Control

const GAME_SCENE_PATH := "res://world.tscn"

@onready var start_label: Label = $CenterContainer/VBoxContainer/StartLabel

var _game_scene: PackedScene
var _start_requested := false
var _transition_started := false


func _ready() -> void:
	var error := ResourceLoader.load_threaded_request(GAME_SCENE_PATH)
	if error != OK:
		push_error("Failed to begin loading the game scene: %s" % error_string(error))
		start_label.text = "게임 로딩 실패"


func _process(_delta: float) -> void:
	_poll_game_scene_load()
	if Input.is_action_just_pressed("ui_accept"):
		_request_start()
	if _start_requested:
		_enter_game_when_ready()


func _request_start() -> void:
	_start_requested = true
	start_label.text = "게임 준비 중..."


func _poll_game_scene_load() -> void:
	if _game_scene != null:
		return
	var progress: Array = []
	var status := ResourceLoader.load_threaded_get_status(GAME_SCENE_PATH, progress)
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if _start_requested and not progress.is_empty():
				start_label.text = "게임 준비 중... %d%%" % roundi(progress[0] * 100.0)
		ResourceLoader.THREAD_LOAD_LOADED:
			_game_scene = ResourceLoader.load_threaded_get(GAME_SCENE_PATH) as PackedScene
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Failed to load the game scene.")
			start_label.text = "게임 로딩 실패"
			set_process(false)


func _enter_game_when_ready() -> void:
	if _game_scene == null:
		return
	if _transition_started:
		return
	_transition_started = true
	start_label.text = "게임 시작 중..."
	await get_tree().process_frame
	get_tree().change_scene_to_packed(_game_scene)
