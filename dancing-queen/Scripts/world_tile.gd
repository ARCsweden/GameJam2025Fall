class_name WorldTile extends Node

var honey_volume : float 
var threat_level : float #0-1

func _init(initial_honey,initial_threat):
	honey_volume = initial_honey
	threat_level = initial_threat
