extends Node

class_name UpgradeManager

@export var experience_manager: ExperienceManager
#@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var current_upgrades: Dictionary = {}
var upgrade_pool: WeightedTable = WeightedTable.new()

var upgrade_axe: Resource = preload("res://resources/upgrades/axe.tres")
var upgrade_axe_damage: Resource = preload("res://resources/upgrades/axe_damage.tres")
var upgrade_sword_rate: Resource = preload("res://resources/upgrades/sword_rate.tres")
var upgrade_sword_damage: Resource = preload("res://resources/upgrades/sword_damage.tres")

func _ready() -> void:
	
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	
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
	
	if upgrade.max_quantiy > 0:
		var current_quantity: int = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantiy:
			upgrade_pool.remove_item(upgrade.id)
	updae_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func updae_upgrade_pool(choosen_upgrade: AbilityUpgrade) -> void:
	if choosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)


func pick_upgrades() -> Array[AbilityUpgrade]:
	
	var choosen_upgrades: Array[AbilityUpgrade] = []
	for i in 2:
		if upgrade_pool.items.size() == choosen_upgrades.size():
			break
		var choosen_upgrade: Object = upgrade_pool.pick_item(choosen_upgrades)
		choosen_upgrades.append(choosen_upgrade)
	
	return choosen_upgrades


func _on_level_up(_current_level: int) -> void:
	var upgrade_screen: UpgradeScreen = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen)
	var upgrades: Array[AbilityUpgrade] =  pick_upgrades()
	upgrade_screen.set_ability_upgrades(upgrades)
	upgrade_screen.upgrade_selected.connect(_on_upgrade_selected)


func _on_upgrade_selected(upgrade: AbilityUpgrade) -> void:
	apply_upgrade(upgrade)
