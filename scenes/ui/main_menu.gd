extends CanvasLayer

class_name MainMenu

var options_menu_scene: PackedScene = preload("res://scenes/ui/options_menu.tscn")


@onready var play_button: Button = %PlayButton
@onready var upgrades_button: Button = %UpgradesButton
@onready var options_button: Button = %OptionsButton
@onready var quit_button: Button = %QuitButton



func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	upgrades_button.pressed.connect(_on_upgrades_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	

func _on_play_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_upgrades_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")


func _on_options_pressed() -> void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_menu: OptionsMenu = options_menu_scene.instantiate() as OptionsMenu
	add_child(options_menu)
	options_menu.back_pressed.connect(_on_options_closed.bind(options_menu))


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_closed(options_menu: OptionsMenu) -> void:
	options_menu.queue_free()
