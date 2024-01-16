extends CharacterBody2D

class_name Player

const MAX_SPEED: int = 200

func  _ready() -> void:
	pass


func _process(_delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	
	velocity = movement_vector * MAX_SPEED
	move_and_slide()

func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
