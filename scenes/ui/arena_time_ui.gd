extends CanvasLayer

class_name AreanTimerUI

@export var arena_time_manager: ArenaTimeManager
@onready var label: Label = %Label


func _process(_delta: float) -> void:
	if arena_time_manager == null: return
	var time_elapsed: float = arena_time_manager.get_time_elapsed()
	
	label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(time_elapsed: float) -> String:
	var minutes: int = floor(time_elapsed / 60)
	var seconds: int = floor(time_elapsed - (minutes * 60))
	
	return "%d:%02d" % [minutes, seconds]
