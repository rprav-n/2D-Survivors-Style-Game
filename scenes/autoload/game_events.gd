extends Node

signal experience_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal player_damage

func emit_experience_vial_collected(number: float) -> void:
	experience_vial_collected.emit(number)
	

func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	ability_upgrade_added.emit(upgrade, current_upgrades)


func emit_player_damage() -> void:
	player_damage.emit()
