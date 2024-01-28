extends CanvasLayer

class_name OptionsMenu

signal back_pressed

@onready var window_button: Button = %WindowButton
@onready var sfx_slider: HSlider = %SfxSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var back_button: Button = %BackButton


func _ready() -> void:
	window_button.pressed.connect(_on_window_button_pressed)
	sfx_slider.value_changed.connect(_on_audio_slider_changed.bind("sfx"))
	music_slider.value_changed.connect(_on_audio_slider_changed.bind("music"))
	back_button.pressed.connect(_on_back_button_pressed)
	update_display()


func update_display() -> void:
	window_button.text = "Windowed"
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	
	sfx_slider.value = get_bus_volume_percent("sfx")
	music_slider.value = get_bus_volume_percent("music")


func get_bus_volume_percent(bus_name: String) -> float:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var vol_db = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(vol_db)


func set_bus_volume_percent(bus_name: String, percent: float) -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var vol_db = linear_to_db(percent)
	AudioServer.set_bus_volume_db(bus_index, vol_db)


func _on_window_button_pressed() -> void:
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()


func _on_audio_slider_changed(value: float, bus_name: String) -> void:
	set_bus_volume_percent(bus_name, value)


func _on_back_button_pressed() -> void:
	back_pressed.emit()
