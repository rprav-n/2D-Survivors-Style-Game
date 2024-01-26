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
	
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var filtered_upgrades: Array[AbilityUpgrade] = upgrade_pool.duplicate()
	var choosen_upgrades: Array[AbilityUpgrade] = []
	for i in 2:
		var choosen_upgrade: AbilityUpgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		choosen_upgrades.append(choosen_upgrade)
		filtered_upgrades = filtered_upgrades.filter(func(upgrade: AbilityUpgrade): return choosen_upgrade.id != upgrade.id)
	
	return choosen_upgrades


func _on_level_up(_current_level: int) -> void:
	var upgrade_screen: UpgradeScreen = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen)
	var upgrades: Array[AbilityUpgrade] =  pick_upgrades()
	upgrade_screen.set_ability_upgrades(upgrades)
	upgrade_screen.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
