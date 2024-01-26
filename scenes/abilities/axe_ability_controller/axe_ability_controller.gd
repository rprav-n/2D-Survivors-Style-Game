extends Node

class_name AxeAbilityController

@export var axe_ability_scene: PackedScene
@onready var timer: Timer = $Timer

var damage: int = 100

func _ready() -> void:
	timer.timeout.connect(_on_timeout)


func _on_timeout() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player	
	var foreground: Node = get_tree().get_first_node_in_group("foreground_layer") as Node
	
	if axe_ability_scene == null or player == null or foreground == null:
		return
		
	var axe_ability: AxeAbility = axe_ability_scene.instantiate() as AxeAbility
	foreground.add_child(axe_ability)
	axe_ability.hitbox_component.damage = damage
	axe_ability.global_position = player.global_position
