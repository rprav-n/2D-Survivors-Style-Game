extends Node

class_name EnemyManager

@export var basic_enemy_scene: PackedScene

const SPAWN_RADIUS: int = 375

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy: Node2D = basic_enemy_scene.instantiate() as Node2D
	var entities_layer: Node = get_tree().get_first_node_in_group("entities_layer") as Node
	entities_layer.add_child(enemy)
	enemy.global_position = spawn_position
