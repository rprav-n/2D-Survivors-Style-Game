extends CanvasLayer

class_name MainMenu

@onready var play_button: Button = %PlayButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_options_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
