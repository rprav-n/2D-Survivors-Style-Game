extends CanvasLayer

class_name EndScreen

@onready var tile_label: Label = %TileLabel
@onready var description_label: Label = %DescriptionLabel
@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton
@onready var panel_container: PanelContainer = %PanelContainer
@onready var victory_audio_stream_player: AudioStreamPlayer = $VictoryAudioStreamPlayer
@onready var defeat_audio_stream_player: AudioStreamPlayer = $DefeatAudioStreamPlayer


func _ready() -> void:
	panel_container.pivot_offset = panel_container.size / 2
	var tween: Tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0.3)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func set_defeat() -> void:
	tile_label.text = "Defeat"
	description_label.text = "You lost!"
	play_jingle(true)
	

func play_jingle(defeat: bool = false):
	if defeat:
		defeat_audio_stream_player.play()
	else:
		victory_audio_stream_player.play()


func _on_restart_button_pressed() ->  void:
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
