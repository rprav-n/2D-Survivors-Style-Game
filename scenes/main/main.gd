extends Node

class_name Main

@export var end_screen_scene: PackedScene
@export var bg_color: Color
@onready var player: Player = %Player


func _ready() -> void:
	RenderingServer.set_default_clear_color(bg_color)
	player.health_component.died.connect(_on_player_died)


func _on_player_died() -> void:
	if end_screen_scene == null:
		return
	
	var end_screen: EndScreen = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen)
	end_screen.set_defeat()
