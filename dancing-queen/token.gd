extends Area2D

var dragable = false
var outside = false

var offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("token")

func set_texture(new_texture : Texture) -> void:
	get_node("Sprite2D").texture = new_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if dragable:
		if Input.is_action_just_pressed("click"):
			print("dragging")
			offset = get_global_mouse_position() - global_position
			Global.draging = true
		if Input.is_action_pressed("click"):
			Global.draging = true
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			print("dropping")
			Global.draging = false


func _on_mouse_entered() -> void:
	if !Global.draging:
		dragable = true


func _on_mouse_exited() -> void:
	if !Global.draging:
		dragable = false
		if outside:
			queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Map":
		print("entered")
		outside = false


func _on_area_exited(area: Area2D) -> void:
	if area.name == "Map":
		print("exit")
		outside = true
