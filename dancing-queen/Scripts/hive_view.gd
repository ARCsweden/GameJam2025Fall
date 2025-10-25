extends Control

@onready var anim = $AnimationPlayer

var queen = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap_view") and !anim.is_playing():
		queen = !queen
		if queen:
			anim.play("queen")
		else:
			anim.play("dancers")
