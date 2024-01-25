extends Node

class_name ArenaTimeManager

@export var end_screen_scene: PackedScene
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
	

func _on_timer_timeout() -> void:
	if end_screen_scene == null:
		return
	
	var end_screen: EndScreen = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen)
