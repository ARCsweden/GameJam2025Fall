extends AudioStreamPlayer

# Preload your two songs
const SONG_MAIN = preload("res://Assets/Sounds/beeckround.mp3")
const SONG_RARE = preload("res://Assets/Sounds/bumble-bee.mp3")

func _ready():
	# Randomly choose a song (90% chance main, 10% rare)
	var rand_val = randf()
	stream = SONG_MAIN if rand_val < 0.9 else SONG_RARE

	# Play it
	play()
