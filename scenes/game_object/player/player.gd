extends CharacterBody2D

class_name Player


@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_area: Area2D = $CollisionArea
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var health_bar: ProgressBar = $HealthBar
@onready var abilities: Node = $Abilities
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node2D = $Visuals
@onready var velocity_component: VelocityComponent = $VelocityComponent

var number_colliding_bodies: int = 0
var base_speed: float = 0

func  _ready() -> void:
	update_health_display()
	collision_area.body_entered.connect(_on_body_entered)
	collision_area.body_exited.connect(_on_body_exited)
	damage_interval_timer.timeout.connect(_on_damage_interval_timer_timeout)
	health_component.health_changed.connect(_on_health_changed)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	base_speed = velocity_component.max_speed


func _process(_delta: float) -> void:
	var movement_vector: Vector2 = get_movement_vector()
	velocity_component.accelerate_in_direction(movement_vector)
	velocity_component.move(self)

	
	if movement_vector.x != 0 or movement_vector.y != 0:
		visuals.scale.x = -1 if movement_vector.x < 0 else 1
		animation_player.play("walk")
	else:
		animation_player.play("RESET")


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
	GameEvents.emit_player_damage()
	update_health_display()
	

func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade is Ability:
		var ability: Ability = upgrade as Ability
		abilities.add_child(ability.ability_controller_scene.instantiate())
	elif upgrade.id == "player_speed":
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["player_speed"]["quantity"] * 0.1)
