@tool
extends HexagonTileMapLayer

@export var hive_pos : Vector3i = Vector3i(0,0,0)
@export var danger_layer : TileMapLayer
@export var flag_layer : TileMapLayer
@onready var background_layer : TileMapLayer  = self
@onready var current_paint_layer : TileMapLayer = background_layer
@onready var current_atlas : Vector2i = no_atlas 
var grass_atlas = Vector2i(3,0)
var flower_atlas = Vector2i(2,0)
var hive_atlas = Vector2i(0,0)
var unexplored_atlas = Vector2i(4,0)
var danger_atlas = Vector2i(5,1)
var flag_atlas = Vector2i(5,0)
var no_atlas = Vector2i(-1,-1)

var hovering_tile: Vector3i = Vector3i.ZERO
signal hovering_changed


func _ready() -> void:
	super._ready()
	# Enable pathfinding
	pathfinding_enabled = true				
				
func get_dance_sequence(lineToTarget:Array[Vector3i], objectFound: int) -> Array[Array]:
	
	var lasthex = lineToTarget[0]
	lineToTarget.remove_at(0)
	var moves = []
	var dance = [[objectFound,1]]
	for hex in lineToTarget:
		if hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_RIGHT_SIDE):
			moves.append(1)
			
			pass
			
		elif hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE):
			moves.append(2)
			pass
			
		elif hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE):
			moves.append(3)
			pass
			
		elif hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_LEFT_SIDE):
			moves.append(4)
			pass
			
		elif hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_TOP_LEFT_SIDE):
			moves.append(5)
			pass
			
		elif hex == cube_neighbor(lasthex,TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE):
			moves.append(6)
			pass
		lasthex = hex
	
	for move in moves:
		var found = false
		for i in len(dance):
			if dance[i-1][0] == move:
				dance[i-1][1] = dance[i-1][1] + 1
				found = true
		if found==false: dance.append([move,1]) 
		found = false
			
	return dance

func get_line_from_hive(target: Vector3):
	var line = self.cube_linedraw(hive_pos,target)
	return line

func _unhandled_input(event: InputEvent):
	if is_visible_in_tree() and event is InputEventMouseMotion:
		var cell_under_mouse = get_closest_cell_from_mouse()
		if cell_under_mouse.distance_squared_to(hovering_tile) != 0:
			hovering_tile = cell_under_mouse
			hovering_changed.emit()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if cube_to_map(hovering_tile) == Vector2i(0,0):
				return
			if current_atlas != no_atlas && $"..".get_world_tile(cube_to_map(hovering_tile)) != null: 
				set_cell(cube_to_map(hovering_tile),0,current_atlas)
			

func get_hovering_tile_Vec2() -> Vector2i:
	return cube_to_map(hovering_tile)
	 
func get_hovering_tile_cube() -> Vector3i:
	return hovering_tile
	
	
# RIGHT_SIDE  1
# BOTTOM_RIGHT_SIDE 2
# BOTTOM_LEFT_SIDE 3
# LEFT_SIDE 4
# TOP_LEFT_SIDE 5
# TOP_RIGHT_SIDE 6


func _on_hovering_changed() -> void:
	var currentTileData : WorldTile = $"..".get_world_tile(cube_to_map(hovering_tile))
	if currentTileData != null:
		print(hovering_tile, " ", currentTileData.honey_volume)
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if cube_to_map(hovering_tile) == Vector2i(0,0):
				return
		if current_atlas != no_atlas: 
			current_paint_layer.set_cell(cube_to_map(hovering_tile),0,current_atlas)
			if current_atlas == unexplored_atlas:
				danger_layer.set_cell(cube_to_map(hovering_tile),0,no_atlas)
				flag_layer.set_cell(cube_to_map(hovering_tile),0,no_atlas)

func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if cube_to_map(hovering_tile) == Vector2i(0,0):
				return
			if current_atlas != no_atlas: 
				current_paint_layer.set_cell(cube_to_map(hovering_tile),0,current_atlas)
				if current_atlas == unexplored_atlas:
					danger_layer.set_cell(cube_to_map(hovering_tile),0,no_atlas)
					flag_layer.set_cell(cube_to_map(hovering_tile),0,no_atlas)


func _on_flower_tile_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_atlas = flower_atlas
		current_paint_layer = background_layer
	elif current_atlas == flower_atlas:
		current_atlas = no_atlas


func _on_danger_tile_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_atlas = danger_atlas
		current_paint_layer = danger_layer
	elif current_atlas == danger_atlas:
		current_atlas = no_atlas


func _on_blank_tile_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_atlas = unexplored_atlas
		current_paint_layer = background_layer
	elif current_atlas == unexplored_atlas:
		current_atlas = no_atlas


func _on_flag_tile_toggled(toggled_on: bool) -> void:
	if toggled_on:
		current_atlas = flag_atlas
		current_paint_layer = flag_layer
		
	elif current_atlas == flag_atlas:
		current_atlas = no_atlas
