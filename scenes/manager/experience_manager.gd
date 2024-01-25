extends Node

class_name ExperienceManager

signal experience_updated(current_experience: float, target_experience: float)

const TARGET_EXPERIENCE_GROWTH: int = 5

var current_experience: float = 0
var current_level: int = 1
var target_experience: float = 5


func _ready() -> void:
		GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_experience(number: float) -> void:
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		current_experience = 0
		target_experience += TARGET_EXPERIENCE_GROWTH
		experience_updated.emit(current_experience, target_experience)


func _on_experience_vial_collected(number: float) -> void:
	increment_experience(number)
