extends Node
@export var time_to_winter : float = 10
@export var time_label : Label
@export var debug_map : TileMapLayer
@onready var sparkle = $UI/UserInterface/GPUParticles2D

func _on_get_honey():
	sparkle.emitting = true

func _ready() -> void:
	SignalBuss.get_honey.connect(_on_get_honey)

func _process(delta: float) -> void:
	time_to_winter -= delta
	var minutes = floor(time_to_winter / 60)
	var seconds = round(time_to_winter - minutes * 60)
	time_label.text = "Winter arrives in: " + str(int(minutes))  + "m " + str(int(seconds)) + "s"
	if Utils.honey_stored >= Constants.STORE_GOAL && time_to_winter > 0:
		time_to_winter = 0
	if time_to_winter <= 0:
		end_game()
		time_label.text = "Winter arrived"

	if time_to_winter <= -10:
		move_on()

func end_game():
	if Utils.honey_stored >= Constants.STORE_GOAL:
		Utils.info = "You survived Winter"
	else:
		Utils.info = "The hive did not survive..."
	Utils.honey_stored = 0.0
	debug_map.visible = true
	
func move_on():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event: InputEvent):
	if Input.is_action_pressed("Quit"):
		Utils.honey_stored = 0.0
		Utils.info = "You left the hive to die..."
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
