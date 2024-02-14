extends PanelContainer

class_name MetaUpgradCard


@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel

var upgrade: MetaUpgrade

func _ready() -> void:
	purchase_button.pressed.connect(_on_purchase_button_pressed)
	

func set_meta_upgrade(meta_upgrade: MetaUpgrade) -> void:
	self.upgrade = meta_upgrade
	name_label.text = meta_upgrade.title
	description_label.text = meta_upgrade.description
	update_progress()


func update_progress() -> void:
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent: int = currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	

func select_card() -> void:
	animation_player.play("selected")


func _on_purchase_button_pressed() -> void:
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	animation_player.play("selected")
