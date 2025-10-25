extends StaticBody2D

var hovering = false
var tokens : PackedScene
var texture : Texture
var new : Object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("pile")
	tokens = self.get_meta("Tokens")
	texture = self.get_meta("Texture")
	get_node("Sprite2D").texture = texture


func _process(_delta: float) -> void:
	if hovering:
		if Input.is_action_just_pressed("click"):
			print("picking up")
			new = tokens.instantiate()
			add_child(new)
			new.set_texture(texture)


func _on_mouse_entered() -> void:
	hovering = true

func _on_mouse_exited() -> void:
	hovering = false
