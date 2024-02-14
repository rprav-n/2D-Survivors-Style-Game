extends CanvasLayer

@export var upgrades: Array[MetaUpgrade] = []

@onready var grid_container: GridContainer = %GridContainer

var meta_upgrade_card_scene: PackedScene = preload("res://scenes/ui/meta_upgrade_card.tscn")


func _ready() -> void:
	for upgrade in upgrades:
		var meta_upgrade_card: MetaUpgradCard = meta_upgrade_card_scene.instantiate() as MetaUpgradCard
		grid_container.add_child(meta_upgrade_card)
		meta_upgrade_card.set_meta_upgrade(upgrade)
