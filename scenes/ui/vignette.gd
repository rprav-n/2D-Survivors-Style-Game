extends CanvasLayer

class_name Vignette

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	GameEvents.player_damage.connect(_on_player_damage)


func _on_player_damage() -> void:
	animation_player.play("hit")
