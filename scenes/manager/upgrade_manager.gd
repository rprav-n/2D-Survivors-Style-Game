extends Node

class_name UpgradeManager

@export var experience_manager: ExperienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades: Dictionary = {}

func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)


func apply_upgrade(upgrade: AbilityUpgrade) -> void:
	var has_upgrade: bool = current_upgrades.has(upgrade.id)
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1


func _on_level_up(_current_level: int) -> void:
	var choosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		pass
	var upgrade_screen: UpgradeScreen = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen)
	upgrade_screen.set_ability_upgrades([choosen_upgrade])
	
