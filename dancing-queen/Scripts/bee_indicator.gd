extends Node2D

@onready var anim_tree = $AnimationTree

func set_present(value: bool) -> void:
	if value:
		anim_tree.set("parameters/conditions/leave", false)
		anim_tree.set("parameters/conditions/present", true)
	else:
		anim_tree.set("parameters/conditions/present", false)
		anim_tree.set("parameters/conditions/leave", true)
