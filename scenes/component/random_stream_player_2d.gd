extends AudioStreamPlayer2D

class_name RandomAudioStreamPlayer2D

@export var streams: Array[AudioStream]

func play_random() -> void:
	if streams == null or streams.size() == 0:
		return
	
	stream = streams.pick_random()
	play()
