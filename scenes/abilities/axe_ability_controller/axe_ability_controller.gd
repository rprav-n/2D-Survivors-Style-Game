extends Node

class_name AxeAbilityController

@export var axe_ability_scene: PackedScene
@onready var timer: Timer = $Timer

var base_damage: float = 10
var additional_damage_percent: float = 1.0

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)


func _on_timeout() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player	
	var foreground: Node = get_tree().get_first_node_in_group("foreground_layer") as Node
	
	if axe_ability_scene == null or player == null or foreground == null:
		return
		
	var axe_ability: AxeAbility = axe_ability_scene.instantiate() as AxeAbility
	foreground.add_child(axe_ability)
	axe_ability.hitbox_component.damage = base_damage * additional_damage_percent
	axe_ability.global_position = player.global_position


func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + current_upgrades["axe_damage"]["quantity"] * 0.10
	
