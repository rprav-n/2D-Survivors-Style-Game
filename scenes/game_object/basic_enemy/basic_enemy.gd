extends CharacterBody2D

class_name BasicEnemy

const MAX_SPEED: int = 50

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func _process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	

func get_direction_to_player() -> Vector2:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if !is_instance_valid(player): return Vector2.ZERO
	return (player.global_position - global_position).normalized()


func _on_area_entered(_other_area2d: Area2D) -> void:
	queue_free()
