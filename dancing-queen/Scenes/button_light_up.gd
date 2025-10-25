extends GridContainer
enum dances {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	FLAP,
	SHAKE,
	ANTENNA,
}

var dances_actions = {
	dances.LEFT: "left",
	dances.RIGHT: "right",
	dances.UP: "up",
	dances.DOWN: "down",
	dances.FLAP: "flap",
	dances.SHAKE: "shake",
	dances.ANTENNA: "antenna",
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
