extends CanvasLayer

class_name EndScreen


@onready var tile_label: Label = %TileLabel
@onready var description_label: Label = %DescriptionLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	get_tree().paused = true
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func set_defeat() -> void:
	tile_label.text = "Defeat"
	description_label.text = "You lost!"


func _on_restart_button_pressed() ->  void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
