extends CharacterBody2D

class_name BasicEnemy

const MAX_SPEED: int = 75


func _process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	

func get_direction_to_player() -> Vector2:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if !is_instance_valid(player): return Vector2.ZERO
	return (player.global_position - global_position).normalized()
