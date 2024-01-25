extends Node

class_name VialDropComponent

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: HealthComponent
@export var experience_vial_scene: PackedScene


func _ready() -> void:
	health_component.died.connect(_on_died)


func spawn_experience_vial() -> void:
	var spawn_position: Vector2 = (owner as Node2D).global_position
	var experience_vial: ExperienceVial = experience_vial_scene.instantiate() as ExperienceVial
	var entities_layer: Node = get_tree().get_first_node_in_group("entities_layer") as Node
	entities_layer.add_child(experience_vial)
	experience_vial.global_position = spawn_position


func _on_died() -> void:
	if experience_vial_scene == null or not owner is Node2D or randf() > drop_percent:
		return
	call_deferred("spawn_experience_vial")

