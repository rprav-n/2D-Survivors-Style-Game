extends CharacterBody2D

class_name WizardEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent

var is_moving: bool = false

func _process(_delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
		
	velocity_component.move(self)
	
	move_and_slide()
	if velocity.x != 0:
		visuals.scale.x = -1 if velocity.x < 0 else 1 


func set_is_moving(moving: bool) -> void:
	is_moving = moving
