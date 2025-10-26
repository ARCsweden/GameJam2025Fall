extends Node

var bees : Array[Beegroup]


func _ready():
	
	add_bee_group()
	SignalBuss.connect("send_bee",send_a_bee)
	SignalBuss.connect("bee_arrived_home",_on_bee_home)
	SignalBuss.connect("create_new_bee",add_bee_group)
	first_bee_search()
	

func first_bee_search():
	await get_tree().create_timer(1).timeout
	for hex in $"../PlayerTileMapLayer".cube_spiral(Vector3i(0,0,0),10):
		var tileInfo = $"..".get_world_tile($"../PlayerTileMapLayer".cube_to_map(hex))
		if tileInfo.honey_volume > 0 :
			bees[0].set_information(hex,69)
			break
	SignalBuss.bee_arrived_home.emit(bees[0])
	
func add_bee_group():
	var new_bee = Beegroup.new()
	bees.append(new_bee)
	add_child(new_bee)
	if len(bees) > 1:
		SignalBuss.bee_idle.emit(new_bee)

func _on_bee_home(bee : Beegroup):
	print("BEEEEEEEEEEEEEEE HOOOOOOOOOOOOOME")
	if bee.nectar_count > 0:
		SignalBuss.get_honey.emit()
	Utils.honey_stored += bee.nectar_count
	bee.nectar_count=0
	var beeInfoPos3 = Vector3i(bee.info[0],bee.info[1],bee.info[2])
	var new_dance = $"../PlayerTileMapLayer".get_dance_sequence($"../PlayerTileMapLayer".get_line_from_hive(beeInfoPos3),bee.info[3])
	bee.currentDance = new_dance
	SignalBuss.bee_idle.emit(bee)

func get_bee_count() -> int:
	return len(bees)


func send_a_bee(destination : Vector3i):
	
	for bee in bees:
		
		var tileInfo : WorldTile = $"..".get_world_tile($"../PlayerTileMapLayer".cube_to_map(destination))
		if bee.bee_home:
			
			bee.set_information(Vector3i(0,0,0),100)
			bee.leave_home(destination, tileInfo)
			$"..".empty_nectar($"../PlayerTileMapLayer".cube_to_map(destination))
			
			for hex in $"../PlayerTileMapLayer".cube_spiral(destination,1):
				tileInfo = $"..".get_world_tile($"../PlayerTileMapLayer".cube_to_map(hex))
				if tileInfo != null and tileInfo.honey_volume > 0 :
					bee.set_information(hex,69)
			break
				
