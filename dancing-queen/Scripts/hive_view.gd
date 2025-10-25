extends Control

@onready var anim = $AnimationPlayer
@onready var queen = $QueenBee
@onready var bee = $bees/BeeDancer

var queen_present = true
var minions = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in $QueenBee/Minions.get_children():
		child.set_flying(true)

class Command:
	var dir : int
	var modifiers : int
	var duration : float

var command_queue : Array[Command] = []
var cur_command : Command = Command.new()

func append_command() -> void:
	if cur_command.dir != Constants.DIR_NONE:
		for child in $QueenBee/Minions.get_children():
			child.do_a_wiggle()
			child.set_direction(cur_command.dir)
		
		print("Appended command: %d, %f" % [cur_command.dir, cur_command.duration])
		command_queue.append(cur_command)
	cur_command = Command.new()

var feedback_queue : Array[Command] = []
var feedback_queue_timer : float = 0.0
var feedback_queue_index : int = 0

func set_dancer_feedback(cmd_queue : Array[Command]) -> void:
	feedback_queue = cmd_queue.duplicate()
	# TODO: REMOVE
	var dummy_start = Command.new()
	dummy_start.duration = 1.0
	feedback_queue.push_front(dummy_start)

	feedback_queue_timer = 0.0
	feedback_queue_index = 0
	bee.set_direction(Constants.DIR_NONE)
	bee.set_flying(true)

func update_dancer_feedback(delta : float) -> void:
	if feedback_queue:
		feedback_queue_timer += delta
		var cmd = feedback_queue[feedback_queue_index]
		if feedback_queue_timer >= cmd.duration:
			feedback_queue_timer = 0.0
			feedback_queue_index += 1
			if feedback_queue_index >= feedback_queue.size():
				feedback_queue_index = 0
			cmd = feedback_queue[feedback_queue_index]
			# Set new command animation
			if feedback_queue_index == 0:
				bee.set_direction(Constants.DIR_NONE)
				bee.set_flying(true)
			else:
				bee.set_direction(cmd.dir)
				bee.set_flying(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if listening for commands
	var listening = queen_present and minions
	if listening:
		cur_command.duration += delta
		var dir = queen.dir
		if dir != cur_command.dir:
			if cur_command.duration >= Constants.CMD_MIN_TIME:
				# Command done
				append_command()
			cur_command.duration = 0.0
		else:
			if cur_command.duration >= Constants.CMD_MAX_TIME:
				append_command()
		cur_command.dir = dir
	
	
	if Input.is_action_just_pressed("swap_view") and !anim.is_playing():
		queen_present = !queen_present
		if queen_present:
			anim.play("queen")
		else:
			anim.play("dancers")
	if Input.is_action_just_pressed("flap") and queen_present and !anim.is_playing():
		if minions:
			print("Execute command queue: ")
			for cmd in command_queue:
				print("Command: %d, %f" % [cmd.dir, cmd.duration])
			anim.play("dismiss_minions")
			# TODO: Finalize command_queue and execute
			set_dancer_feedback(command_queue)
		else:
			for child in $QueenBee/Minions.get_children():
				child.set_direction(Constants.DIR_NONE)
			command_queue.clear()
			anim.play("summon_minions")
		minions = !minions

	update_dancer_feedback(delta)
