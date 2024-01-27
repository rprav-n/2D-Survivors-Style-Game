extends Node2D

class_name ExperienceVial

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var random_stream_player_2d: RandomAudioStreamPlayer2D = $RandomStreamPlayer2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func tween_collect(percent: float, start_position: Vector2) -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return
	
	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start: Vector2 = player.global_position - start_position
	var target_rotation = direction_from_start.angle() + deg_to_rad(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-2 * get_process_delta_time()))


func collect() -> void:
	GameEvents.emit_experience_vial_collected(1)
	queue_free()


func disable_collision() -> void:
	collision_shape_2d.disabled = true
	

func _on_area_entered(_other_area: Area2D) -> void:
	call_deferred("disable_collision")
	var tween: Tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.5)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_BACK)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.05).set_delay(0.45)
	tween.chain()
	
	tween.tween_callback(collect)
	
	random_stream_player_2d.play_random()
