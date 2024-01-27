extends Node

class_name ArenaTimeManager

signal arena_difficulty_increased(arena_difficulty)

@export var end_screen_scene: PackedScene
@onready var timer: Timer = $Timer

const DIFFICULTY_INTERVAL: int = 5
var arena_difficulty: int = 0


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _process(_delta: float) -> void:
	var next_time_target: float = timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
	

func _on_timer_timeout() -> void:
	if end_screen_scene == null:
		return
	
	var end_screen: EndScreen = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen)
	end_screen.play_jingle()
