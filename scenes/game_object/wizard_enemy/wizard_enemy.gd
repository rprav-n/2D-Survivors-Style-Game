extends CharacterBody2D

class_name WizardEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent


func _process(_delta: float) -> void:
	
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	move_and_slide()
	if velocity.x != 0:
		visuals.scale.x = -1 if velocity.x < 0 else 1 
	

