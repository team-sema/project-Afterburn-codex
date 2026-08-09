class_name MasterVolumeControl
extends HBoxContainer

const SETTINGS_PATH := "user://settings.cfg"
const SETTINGS_SECTION := "audio"
const SETTINGS_KEY := "master_volume"
const MASTER_BUS := &"Master"

@onready var volume_slider: HSlider = %VolumeSlider
@onready var save_timer: Timer = %SaveTimer

var _master_bus_index := -1
var _save_pending := false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	_master_bus_index = AudioServer.get_bus_index(MASTER_BUS)
	if _master_bus_index < 0:
		push_error("Master audio bus is missing.")
		volume_slider.editable = false
		return

	var initial_volume := _load_volume()
	volume_slider.set_value_no_signal(initial_volume)
	_apply_volume(initial_volume)
	volume_slider.value_changed.connect(_on_volume_changed)
	save_timer.timeout.connect(_save_pending_volume)


func _exit_tree() -> void:
	if _save_pending:
		_save_pending_volume()


func _on_volume_changed(value: float) -> void:
	_apply_volume(value)
	_save_pending = true
	save_timer.start()


func _apply_volume(value: float) -> void:
	var muted := is_zero_approx(value)
	AudioServer.set_bus_mute(_master_bus_index, muted)
	if not muted:
		AudioServer.set_bus_volume_db(_master_bus_index, linear_to_db(value))


func _load_volume() -> float:
	var config := ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		return clampf(config.get_value(SETTINGS_SECTION, SETTINGS_KEY, 1.0), 0.0, 1.0)
	if AudioServer.is_bus_mute(_master_bus_index):
		return 0.0
	return clampf(db_to_linear(AudioServer.get_bus_volume_db(_master_bus_index)), 0.0, 1.0)


func _save_volume(value: float) -> void:
	var config := ConfigFile.new()
	config.load(SETTINGS_PATH)
	config.set_value(SETTINGS_SECTION, SETTINGS_KEY, clampf(value, 0.0, 1.0))
	var error := config.save(SETTINGS_PATH)
	if error != OK:
		push_warning("Failed to save master volume: %s" % error_string(error))


func _save_pending_volume() -> void:
	if not _save_pending:
		return
	_save_pending = false
	_save_volume(volume_slider.value)
