extends AudioStreamPlayer2D

# Exports the array of AudioStreams and parameters for pitch randomization.
@export var streams: Array[AudioStream]
@export var randomize_pitch: bool = true
@export var min_pitch: float = 0.9
@export var max_pitch: float = 1.1


# Plays a random stream from the provided array.
func play_random():
	# Check if the streams array is empty or undefined.
	if not streams or streams.size() == 0:
		return

	# Randomize the pitch if enabled, otherwise set to default (1).
	pitch_scale = randf_range(min_pitch, max_pitch) if randomize_pitch else 1

	# Choose a random stream from the array and play it.
	stream = streams.pick_random()
	play()

	play()




