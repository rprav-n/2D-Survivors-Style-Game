extends Node

class_name UpgradeManager

@export var experience_manager: ExperienceManager
@export var upgrade_pool: Array[AbilityUpgrade]

var current_upgrades: Dictionary = {}

func _ready() -> void:
	experience_manager.level_up.connect(_on_level_up)


func _on_level_up(_current_level: int) -> void:
	var choosen_upgrade: AbilityUpgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		pass
	
	var has_upgrade: bool = current_upgrades.has(choosen_upgrade.id)
	if !has_upgrade:
		current_upgrades[choosen_upgrade.id] = {
			"resource": choosen_upgrade,
			"quantity": 1
		}
	else:
		current_upgrades[choosen_upgrade.id]["quantity"] += 1
	
