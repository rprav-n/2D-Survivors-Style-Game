extends Node

class_name ArenaTimeManager

@export var victory_screen_scene: PackedScene
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
	

func _on_timer_timeout() -> void:
	if victory_screen_scene == null:
		return
	
	var victory_screen: VictoryScreen = victory_screen_scene.instantiate() as VictoryScreen
	add_child(victory_screen)
