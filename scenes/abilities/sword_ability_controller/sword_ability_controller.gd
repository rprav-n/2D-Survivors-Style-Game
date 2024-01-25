extends Node

class_name SwordAbilityController

@export var sword_ability_scene: PackedScene

@onready var timer: Timer = $Timer

const MAX_RANGE: int = 150
var damage: int = 5
var base_wait_time: float

func _ready() -> void:
	base_wait_time = timer.wait_time
	timer.timeout.connect(_on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)


func spawn_sword_ability() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player	
	if sword_ability_scene == null || player == null: return
	
	var enemies: Array[Node] = get_tree().get_nodes_in_group("enemy") as Array[Node]
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2) 
	)
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func (a: Node2D, b: Node2D):
		var a_distance: float = a.global_position.distance_squared_to(player.global_position)
		var b_distance: float = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	var enemy: Node2D = enemies[0] as Node2D
	var sword_ability: SwordAbility = sword_ability_scene.instantiate() as SwordAbility
	player.get_parent().add_child(sword_ability)
	sword_ability.hitbox_component.damage = damage
	sword_ability.global_position = enemy.global_position
	sword_ability.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction: Vector2 = enemy.global_position - sword_ability.global_position
	sword_ability.rotation = enemy_direction.angle()


func _on_timer_timeout() -> void:
	spawn_sword_ability()


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction: float = current_upgrades["sword_rate"]["quantity"] * 0.1
	timer.wait_time = base_wait_time * (1 - percent_reduction)
	timer.start()
	
	print(timer.wait_time)
