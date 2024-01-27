extends CanvasLayer

class_name UpgradeScreen

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var ability_upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = %CardContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]) -> void:
	var delay: float = 0
	for upgrade in upgrades:
		var ability_upgrade_card: AbilityUpgradeCard = ability_upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(ability_upgrade_card)
		ability_upgrade_card.set_ability_upgrade(upgrade as AbilityUpgrade)
		ability_upgrade_card.play_in(delay)
		ability_upgrade_card.selected.connect(_on_selected.bind(upgrade))
		delay += 0.2
		
		
func _on_selected(upgrade: AbilityUpgrade) -> void:
	upgrade_selected.emit(upgrade)
	animation_player.play("out")
	await animation_player.animation_finished
	get_tree().paused = false
	queue_free()
