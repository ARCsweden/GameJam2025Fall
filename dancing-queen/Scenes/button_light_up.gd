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

@onready var dance_tiles = {
	Dance.LEFT: %Dance1,
	Dance.RIGHT: %Dance2,
	Dance.UP: %Dance3,
	Dance.DOWN: %Dance4,
	Dance.FLAP: %Dance5,
	Dance.SHAKE: %Dance6,
	Dance.ANTENNA: %Dance7,
}

func _process(_delta):
	for dance in Dance.values():
		var tile = dance_tiles.get(dance, null)
		if tile == null:
			continue
		
		if Input.is_action_pressed(dance_actions[dance]):
			tile.color = Color("008632")  # green = active
		else:
			tile.color = Color("cb002f")  # white = inactive
