extends Node2D

@onready var anim_tree = $AnimationTree

const HEAD_IDLE = 0
const HEAD_SHAKE = 1
const HEAD_ANGRY = 2

const WINGS_IDLE = 0
const WINGS_FLAP = 1

const BUTT_IDLE = 0
const BUTT_WIGGLE = 1
const BUTT_TWERK = 2

const ARM_TOP_IDLE = 0
const ARM_TOP_COMB = 1
const ARM_TOP_PUMP = 2

const ARM_MID_IDLE = 0
const ARM_MID_ELBOW = 1
const ARM_MID_STRETCH = 2

const LEGS_IDLE = 0
const LEGS_RAISE_LEFT = 1
const LEGS_RAISE_RIGHT = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_wings(state: int) -> void:
	if state == WINGS_FLAP:
		anim_tree.set("parameters/Wings/transition_request", "flap")
	else:
		anim_tree.set("parameters/Wings/transition_request", "idle")

func set_head(state: int) -> void:
	if state == HEAD_SHAKE:
		anim_tree.set("parameters/Head/transition_request", "shake")
	elif state == HEAD_ANGRY:
		anim_tree.set("parameters/Head/transition_request", "angry")
	else:
		anim_tree.set("parameters/Head/transition_request", "idle")

func set_arm_top(state: int) -> void:
	if state == ARM_TOP_COMB:
		anim_tree.set("parameters/ArmTop/transition_request", "comb")
	elif state == ARM_TOP_PUMP:
		anim_tree.set("parameters/ArmTop/transition_request", "pump")
	else:
		anim_tree.set("parameters/ArmTop/transition_request", "idle")

func set_arm_mid(state: int) -> void:
	if state == ARM_MID_ELBOW:
		anim_tree.set("parameters/ArmMid/transition_request", "elbow")
	elif state == ARM_MID_STRETCH:
		anim_tree.set("parameters/ArmMid/transition_request", "stretch")
	else:
		anim_tree.set("parameters/ArmMid/transition_request", "idle")

func set_legs(state: int) -> void:
	if state == LEGS_RAISE_LEFT:
		anim_tree.set("parameters/Legs/transition_request", "raise_left")
	elif state == LEGS_RAISE_RIGHT:
		anim_tree.set("parameters/Legs/transition_request", "raise_right")
	else:
		anim_tree.set("parameters/Legs/transition_request", "idle")

func set_butt(state: int) -> void:
	if state == BUTT_WIGGLE:
		anim_tree.set("parameters/Butt/transition_request", "wiggle")
	elif state == BUTT_TWERK:
		anim_tree.set("parameters/Butt/transition_request", "twerk")
	else:
		anim_tree.set("parameters/Butt/transition_request", "idle")


func set_direction(dir: int) -> void:
	if dir == Constants.DIR_NONE:
		set_legs(LEGS_IDLE)
		set_butt(BUTT_IDLE)
		set_arm_top(ARM_TOP_IDLE)
		set_arm_mid(ARM_MID_IDLE)
	else:
		# Set Left/Right
		if dir == Constants.DIR_E or dir == Constants.DIR_NE or dir == Constants.DIR_SE:
			set_legs(LEGS_RAISE_RIGHT)
		else:
			set_legs(LEGS_RAISE_LEFT)
		# Set Up
		if dir == Constants.DIR_NE or dir == Constants.DIR_NW:
			set_arm_top(ARM_TOP_PUMP)
		else:
			set_arm_top(ARM_TOP_IDLE)
		# Set Down
		if dir == Constants.DIR_SE or dir == Constants.DIR_SW:
			set_butt(BUTT_WIGGLE)
		else:
			set_butt(BUTT_IDLE)
		# Set Sides
		if dir == Constants.DIR_E or dir == Constants.DIR_W:
			set_arm_mid(ARM_MID_STRETCH)
		else:
			set_arm_mid(ARM_MID_IDLE)
