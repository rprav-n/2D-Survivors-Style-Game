extends CanvasLayer

class_name ExperienceBar

@export var experience_manager: ExperienceManager
@onready var progress_bar: ProgressBar = %ProgressBar


func _ready() -> void:
	progress_bar.value = 0
	experience_manager.experience_updated.connect(_on_experience_updated)
	

func _on_experience_updated(current_experience: float, target_experience: float) -> void:
	var percent: float = current_experience / target_experience
	progress_bar.value = percent
