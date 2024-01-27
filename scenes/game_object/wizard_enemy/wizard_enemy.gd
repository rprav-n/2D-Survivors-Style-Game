extends CharacterBody2D

class_name WizardEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hit_random_audio_player_component: AudioStreamPlayer2D = $HitRandomAudioPlayerComponent
@onready var hurtbox_component: Area2D = $HurtboxComponent


var is_moving: bool = false

func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)

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


func _on_hit() -> void:
	hit_random_audio_player_component.play_random()
