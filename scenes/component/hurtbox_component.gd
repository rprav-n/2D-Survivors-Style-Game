extends Area2D

class_name HurtboxComponent

@export var health_component: HealthComponent
@export var floating_text_scene: PackedScene

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func spawn_floating_text(damage: int) -> void:
	var owner_node2d: Node2D = owner as Node2D
	if floating_text_scene == null || owner_node2d == null:
		return
	
	var floating_text: FloatingText = floating_text_scene.instantiate() as FloatingText
	var foreground_layer: Node = get_tree().get_first_node_in_group("foreground_layer") as Node
	foreground_layer.add_child(floating_text)
	floating_text.global_position = global_position + (Vector2.UP * 16)
	floating_text.start(str(damage))
	

func _on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitboxComponent or health_component == null:
		return
	
	var hitbox_component: HitboxComponent = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	spawn_floating_text(hitbox_component.damage)
