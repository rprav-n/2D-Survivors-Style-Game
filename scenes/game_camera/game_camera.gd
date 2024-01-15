extends Camera2D

class_name GameCamera

const SMOOTHING_VALUE: int = 10
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	make_current()


func _process(delta: float) -> void:
	acquire_target()
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * SMOOTHING_VALUE))
	

func acquire_target() -> void:
	var player: Player = get_tree().get_first_node_in_group("player") as Player
	if !is_instance_valid(player): return
	target_position = player.global_position
