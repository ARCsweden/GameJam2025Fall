extends GridContainer
enum Dance {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	FLAP,
	SHAKE,
	ANTENNA,
}

var dance_actions = {
	Dance.LEFT: "left",
	Dance.RIGHT: "right",
	Dance.UP: "up",
	Dance.DOWN: "down",
	Dance.FLAP: "flap",
	Dance.SHAKE: "shake",
	Dance.ANTENNA: "antenna",
}

var dance_tiles = {
	Dance.LEFT: %Dance1,
	Dance.RIGHT: %Dance2,
	Dance.UP: %Dance3,
	Dance.DOWN: %Dance4,
	Dance.FLAP: %Dance5,
	Dance.SHAKE: %Dance6,
	Dance.ANTENNA: %Dance7,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	for dance in Dance.values():
		var tile = dance_tiles.get(dance, null)
		if tile == null:
			push_error("Tile for " + str(dance) + " is null!")
			continue
		
		if Input.is_action_pressed(dance_actions[dance]):
			tile.color = Color("008632")  # green = active
		else:
			tile.color = Color("cb002f")  # white = inactive
