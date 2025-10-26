class_name Beegroup extends Node

var size : int 
var bee_home : bool
var info : Array[int]
@export var flight_timer : Timer
var time_per_hex
var gather_time
var nectar_count
var currentDance

func _init():
	size = 10
	bee_home = true
	flight_timer = Timer.new()
	info = [0,0,0,0]
	time_per_hex = 2
	gather_time = 5
	nectar_count = 0
	currentDance = [[100,0]]
	add_child(flight_timer)
	flight_timer.connect("timeout", _on_timer_timeout)

func leave_home(destination : Vector3i, targetTile : WorldTile):
	var flight_time = (get_line_distance_from_hive(destination) * time_per_hex) + gather_time
	bee_home = false
	flight_timer.wait_time = flight_time
	flight_timer.one_shot = true
	flight_timer.start()
	if targetTile != null and targetTile.honey_volume > 0 :
		nectar_count = nectar_count + (targetTile.honey_volume)
	
func set_information(destination: Vector3i, thing: int):
	info = [destination[0],destination[1],destination[2],thing]
	
func get_line_distance_from_hive(target: Vector3):
	var dist = len(HexagonTileMapLayer.new().cube_linedraw(Vector3i(0,0,0), target))
	return dist

func _on_timer_timeout():
	bee_home = true
	SignalBuss.bee_arrived_home.emit(self)
	
