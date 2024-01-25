extends CanvasLayer

class_name UpgradeScreen

@export var ability_upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = %CardContainer


func _ready() -> void:
	get_tree().paused = true



func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	for upgrade in upgrades:
		var ability_upgrade_card: AbilityUpgradeCard = ability_upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(ability_upgrade_card)
		ability_upgrade_card.set_ability_upgrade(upgrade as AbilityUpgrade)
