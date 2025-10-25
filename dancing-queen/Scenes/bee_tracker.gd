extends Node

var bees : Array[Beegroup]
@onready var hexmap : HexagonTileMapLayer = $PlayerTileMapLayer

func _ready():
	add_bee_group()

func add_bee_group():
	bees.append(Beegroup.new())
	add_child(bees[len(bees)-1])
	bees[len(bees)-1].connect("bee_arrived_home", _on_bee_home)

func _on_bee_home(bee : Beegroup):
	pass

func get_bee_count() -> int:
	return len(bees)


func send_a_bee(destination : Vector3i):
	
	for bee in bees:
		var tileInfo : WorldTile = $"..".get_world_tile(hexmap.cube_to_map(destination))
		if bee.bee_home:
			bee.set_information(Vector3i(0,0,0),0)
			bee.leave_home(destination, tileInfo)
			$"..".empty_nectar(hexmap.cube_to_map(destination))
			
			for hex in hexmap.cube_spiral(destination,2):
				tileInfo = $"..".get_world_tile(hexmap.cube_to_map(hex))
				if tileInfo.honey_volume < 0 :
					bee.set_information(hex,69)
			break
				
