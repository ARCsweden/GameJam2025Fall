@tool
extends HexagonTileMapLayer

@export var hive_pos : Vector3i = Vector3i(0,0,0)

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
	#var test : WorldTile = $"..".world_tiles[cube_to_map(hovering_tile)]
	#print(hovering_tile, " ", test.honey_volume)
	pass 
