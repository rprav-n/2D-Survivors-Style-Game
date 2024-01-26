extends Node

class_name EnemyManager

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: ArenaTimeManager

const SPAWN_RADIUS: int = 375
var base_spawn_time: float = 0
var enemy_table: WeightedTable = WeightedTable.new()

@onready var timer: Timer = $Timer


func _ready() -> void:
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(_on_arena_difficulty_increased)


func get_spawn_position() -> Vector2:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return Vector2.ZERO

	var random_direction: Vector2 = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position: Vector2 = player.global_position + (random_direction * SPAWN_RADIUS)

	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var query_paramerters: PhysicsRayQueryParameters2D = 	PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
		var result: Dictionary = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramerters)
	
		if result.is_empty():
			return spawn_position
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))

	return spawn_position


func _on_timer_timeout() -> void:
	timer.start()
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	
	var enemy_scene: PackedScene = enemy_table.pick_item()
	
	var enemy: Node2D = enemy_scene.instantiate() as Node2D
	var entities_layer: Node = get_tree().get_first_node_in_group("entities_layer") as Node
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()


func _on_arena_difficulty_increased(arena_difficulty: int) -> void:
	var time_off: float = (0.1 / 12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
