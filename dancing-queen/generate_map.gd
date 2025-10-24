extends TileMapLayer

@export var noise_tex : NoiseTexture2D

var grass_atlas = [Vector2i(1,1)]
var flower_atlas = [Vector2i(3,2)]
var danger_atlas = Vector2i(2,4)
var noise : Noise
func _ready() -> void:
	generate_world()
	pass

func generate_world():
	noise = noise_tex.noise
	
	pass
