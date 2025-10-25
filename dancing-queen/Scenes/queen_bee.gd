extends "res://Scripts/bee_dancer.gd"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var dir_vec = Input.get_vector("left", "right", "up", "down")

	var dir = Constants.DIR_NONE
	if dir_vec.x > 0.0: # right
		if dir_vec.y > 0: # down
			dir = Constants.DIR_SE
		elif dir_vec.y < 0: # up
			dir = Constants.DIR_NE
		else:
			dir = Constants.DIR_E
	elif dir_vec.x < 0.0: # left
		if dir_vec.y > 0: # down
			dir = Constants.DIR_SW
		elif dir_vec.y < 0: # up
			dir = Constants.DIR_NW
		else:
			dir = Constants.DIR_W

	set_direction(dir)

	if Input.is_action_pressed("antenna") and dir_vec.y < 0:
		set_head(HEAD_SHAKE)
	elif Input.is_action_pressed("antenna"):
		set_head(HEAD_ANGRY)
	else:
		set_head(HEAD_IDLE)

	if Input.is_action_pressed("flap"):
		set_wings(WINGS_FLAP)
	else:
		set_wings(WINGS_IDLE)
	
	if Input.is_action_pressed("comb"):
		set_arm_top(ARM_TOP_COMB)
	if Input.is_action_pressed("shake"):
		set_butt(BUTT_TWERK)
	if Input.is_action_pressed("elbow"):
		set_arm_mid(ARM_MID_ELBOW)
	
