extends Node

class_name SwordAbilityController

@export var sword_ability_scene: PackedScene

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func spawn_sword_ability() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player	
	if sword_ability_scene == null || player == null: return
	
	var sword_ability: Node2D = sword_ability_scene.instantiate() as Node2D
	player.get_parent().add_child(sword_ability)
	sword_ability.global_position = player.global_position
	

func _on_timer_timeout() -> void:
	spawn_sword_ability()
