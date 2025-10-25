extends Node2D
@export var tileMapLayerDebug : TileMapLayer 
@export var tileMapLayerPlayer : TileMapLayer

@export var noise_tex : NoiseTexture2D

var grass_atlas = Vector2i(2,0)
var flower_atlas = Vector2i(0,0)
var danger_atlas = Vector2i(1,0)
var noise : Noise
var width : int = 32
var height : int = 32
var source_id = 0

func _ready() -> void:
	generate_world()
	fill_player_world()
	pass


func generate_world():
	noise = noise_tex.noise
	for x in range(-width/2, width /2):
		for y in range(-height/2, height/2):
			var noise_val :float = noise.get_noise_2d(x,y)
			# placing ground
			if noise_val >= -0.2:
				tileMapLayerDebug.set_cell(Vector2i(x,y), source_id, grass_atlas)
			else:
				tileMapLayerDebug.set_cell(Vector2i(x,y), source_id,flower_atlas)
func fill_player_world():
	for x in range(-width/2, width /2):
		for y in range(-height/2, height/2):
			# placing ground
			tileMapLayerPlayer.set_cell(Vector2i(x,y), source_id, danger_atlas)
