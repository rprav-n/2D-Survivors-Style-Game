extends Node

class_name SwordAbilityController

@export var sword_ability_scene: PackedScene

@onready var timer: Timer = $Timer

const MAX_RANGE: int = 150

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func get_nearest_enemy_position(player_position: Vector2) -> Vector2:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy") as Array[Node]
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player_position) < pow(MAX_RANGE, 2) 
	)
	if enemies.size() == 0:
		return Vector2.ZERO
	
	enemies.sort_custom(func (a: Node2D, b: Node2D):
		var a_distance: float = a.global_position.distance_squared_to(player_position)
		var b_distance: float = b.global_position.distance_squared_to(player_position)
		return a_distance < b_distance
	)
	
	return enemies[0].global_position


func spawn_sword_ability() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player	
	if sword_ability_scene == null || player == null: return
	
	var sword_ability: Node2D = sword_ability_scene.instantiate() as Node2D
	player.get_parent().add_child(sword_ability)
	sword_ability.global_position = get_nearest_enemy_position(player.global_position)
	

func _on_timer_timeout() -> void:
	spawn_sword_ability()
