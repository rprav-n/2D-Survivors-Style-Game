extends Node

class_name EnemyManager

@export var basic_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

const SPAWN_RADIUS: int = 375
var base_spawn_time: float = 0
@onready var timer: Timer = $Timer

func _ready() -> void:
	base_spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(_on_arena_difficulty_increased)


func _on_timer_timeout() -> void:
	timer.start()
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy: Node2D = basic_enemy_scene.instantiate() as Node2D
	var entities_layer: Node = get_tree().get_first_node_in_group("entities_layer") as Node
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position


func _on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off: float = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7 )
	timer.wait_time = base_spawn_time - time_off
