extends CharacterBody2D

class_name BasicEnemy

const MAX_SPEED: int = 50

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals


func _process(_delta: float) -> void:
	var direction: Vector2 = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()
	if direction.x != 0:
		visuals.scale.x = -1 if direction.x < 0 else 1 
	

func get_direction_to_player() -> Vector2:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if !is_instance_valid(player): return Vector2.ZERO
	return (player.global_position - global_position).normalized()
