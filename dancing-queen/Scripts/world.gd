extends Node2D


	
var map_width : int = 32
var map_height : int = 32

@export var tileMapLayerDebug : TileMapLayer 
@export var tileMapLayerPlayer : TileMapLayer
@export var nectar_noise_tex : NoiseTexture2D
@export var threat_noise_tex : NoiseTexture2D
@export var max_flower_nectar : int = 100
@export var min_flower_nectar : int = 30

var grass_atlas = Vector2i(3,0)
var flower_atlas = Vector2i(2,0)
var hive_atlas = Vector2i(0,0)
var unexplored_atlas = Vector2i(4,0)
var world_tiles : Dictionary[Vector2i,WorldTile]

var danger_atlas = Vector2i(5,1)
var flag_atlas = Vector2i(5,0)
var noise : Noise
var source_id = 0



func _ready() -> void:
	generate_world()
	fill_player_world()
	pass


func generate_world():
	noise = nectar_noise_tex.noise
	for x in range(-map_width/2, map_width /2):
		for y in range(-map_height/2, map_height/2):
			if x == 0 and y == 0:
				world_tiles[Vector2i(0,0)] = WorldTile.new(0,0)
				continue
			var noise_val :float = noise.get_noise_2d(x,y)
			# placing ground
			if noise_val >= -0.2:
				tileMapLayerDebug.set_cell(Vector2i(x,y), source_id, grass_atlas)
				world_tiles[Vector2i(x,y)] = WorldTile.new(0,0)
			else:
				tileMapLayerDebug.set_cell(Vector2i(x,y), source_id,flower_atlas)
				world_tiles[Vector2i(x,y)] = WorldTile.new(randf_range(min_flower_nectar,max_flower_nectar),0)
	tileMapLayerPlayer.set_cell(Vector2i(0,0),source_id,hive_atlas)
	
func fill_player_world():
	for x in range(-map_width/2, map_width /2):
		for y in range(-map_height/2, map_height/2):
			# placing ground
			tileMapLayerPlayer.set_cell(Vector2i(x,y), source_id, unexplored_atlas)
	tileMapLayerPlayer.set_cell(Vector2i(0,0),source_id,hive_atlas)

func get_world_tile(tile_coords : Vector2i) -> WorldTile:
	if world_tiles.has(tile_coords):
		return world_tiles[tile_coords]
	return null

func _on_check_button_toggled(toggled_on: bool) -> void:
	tileMapLayerDebug.visible = toggled_on
	pass # Replace with function body.
