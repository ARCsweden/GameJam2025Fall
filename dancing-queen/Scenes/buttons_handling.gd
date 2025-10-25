extends HBoxContainer

enum Dance {
	LEFT,
	RIGHT,
	UP,
	DOWN,
}

var dance_actions = {
	Dance.LEFT: "left",
	Dance.RIGHT: "right",
	Dance.UP: "up",
	Dance.DOWN: "down",
	
}

@onready var dance_tiles = {
	Dance.LEFT: %left,
	Dance.RIGHT: %right,
	Dance.UP: %up,
	Dance.DOWN: %down,
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
