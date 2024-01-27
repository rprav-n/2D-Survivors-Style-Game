extends CharacterBody2D

class_name BasicEnemy

const MAX_SPEED: int = 50

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hurtbox_component: Area2D = $HurtboxComponent
@onready var hit_random_audio_player_component: RandomAudioStreamPlayer2D = $HitRandomAudioPlayerComponent


func _ready() -> void:
	hurtbox_component.hit.connect(_on_hit)

func _process(_delta: float) -> void:
	
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	move_and_slide()
	if velocity.x != 0:
		visuals.scale.x = -1 if velocity.x < 0 else 1 
	

func _on_hit() -> void:
	hit_random_audio_player_component.play_random()
