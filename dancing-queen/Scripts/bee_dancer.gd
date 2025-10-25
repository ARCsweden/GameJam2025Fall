extends Node2D

@onready var anim_tree = $AnimationTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("ui_accept"):
		anim_tree.set("parameters/Transition/transition_request", "shake")
	else:
		anim_tree.set("parameters/Transition/transition_request", "idle")
