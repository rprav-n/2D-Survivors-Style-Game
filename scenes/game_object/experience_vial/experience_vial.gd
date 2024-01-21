extends Node2D

class_name ExperienceVial

@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func _on_area_entered(_other_area: Area2D) -> void:
	queue_free()
