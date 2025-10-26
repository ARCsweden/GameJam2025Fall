extends Node
@export var time_to_winter : float = 10
@export var time_label : Label

func _process(delta: float) -> void:
	time_to_winter -= delta
	var minutes = floor(time_to_winter / 60)
	var seconds = round(time_to_winter - minutes * 60)
	time_label.text = "Winter arrives in: " + str(minutes)  + "m " + str(seconds) + "s"
	if time_to_winter <= 0:
		end_game()

func end_game():
	if Utils.honey_stored >= Constants.STORE_GOAL:
		Utils.info = "You survived Winter"
	else:
		Utils.info = "The hive did not survive..."
	Utils.honey_stored = 0.0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
