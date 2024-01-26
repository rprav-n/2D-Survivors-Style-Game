extends CharacterBody2D

class_name Player

const MAX_SPEED: int = 150
const ACCELERATION_SMOOTHING: int = 25
var number_colliding_bodies: int = 0

@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_area: Area2D = $CollisionArea
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_bar: ProgressBar = $HealthBar
@onready var abilities: Node = $Abilities


func  _ready() -> void:
	update_health_display()
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.body_exited.connect(_on_body_exited)
	damage_interval_timer.timeout.connect(_on_damage_interval_timer_timeout)
	health_component.health_changed.connect(_on_health_changed)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)


func _process(delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	var target_velocity: Vector2 = movement_vector * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func update_health_display() -> void:
	health_bar.value = health_component.get_health_precent()


func check_deal_damage() -> void:
	if number_colliding_bodies == 0 or !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func _on_body_entered(_other_body: Node2D) -> void:
	number_colliding_bodies += 1
	check_deal_damage()


func _on_body_exited(_other_body: Node2D) -> void:
	number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout() -> void:
	check_deal_damage()


func _on_health_changed() -> void:
	update_health_display()
	

func _on_ability_upgrade_added(upgrade: AbilityUpgrade, _current_upgrades: Dictionary) -> void:
	if not upgrade is Ability:
		return
	
	var ability: Ability = upgrade as Ability
	abilities.add_child(ability.ability_controller_scene.instantiate())
