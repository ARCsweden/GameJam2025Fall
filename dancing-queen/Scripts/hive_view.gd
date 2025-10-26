extends Control

@onready var anim = $AnimationPlayer
@onready var queen = $QueenBee
@onready var bee = $bees/BeeDancer
@onready var bee_indicator = $BeeIndicator

var queen_present = true
var minions = false
var beesInQueue : Array[Beegroup] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBuss.connect("bee_idle",_on_bee_idle)
	for child in $QueenBee/Minions.get_children():
		child.set_flying(true)
	bee_indicator.set_present(false)

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
		if !queen_present:
			anim.play("queen")
			queen_present = true
		elif len(beesInQueue) > 0:
			anim.play("dancers")
			queen_present = false
	if Input.is_action_just_pressed("flap") and queen_present and !anim.is_playing():
		if minions:
			print("Execute command queue: ")
			for cmd in command_queue:
				print("Command: %d, %f" % [cmd.dir, cmd.duration])
			anim.play("dismiss_minions")
			
			
			command_bee(command_queue)
			
		else:
			for child in $QueenBee/Minions.get_children():
				child.set_direction(Constants.DIR_NONE)
			command_queue.clear()
			anim.play("summon_minions")
		minions = !minions

	update_dancer_feedback(delta)
	
func command_bee(queue : Array[Command]):
	var queueCOPY = queue.duplicate()
	var q :int #See plugin docs
	var r :int #See plugin docs
	var s :int #See plugin docs
	
	#Quick and Stinky custom cordinate convertor
	for com in queueCOPY:
		if com.dir==Constants.DIR_E : 
			q=q+1
			r=r-1
		elif com.dir==Constants.DIR_SE:
			r=r+1
			s=s-1
		elif com.dir==Constants.DIR_SW:
			q=q-1
			s=s+1
		elif com.dir==Constants.DIR_W:
			q=q-1
			r=r+1
		elif com.dir==Constants.DIR_NW:
			r=r-1
			s=s+1
		elif com.dir==Constants.DIR_NE:
			q=q+1
			s=s-1
	var cords = Vector3i(q,r,s)
	beesInQueue.pop_front()
	if len(beesInQueue) > 0:
		set_dancer_feedback(convert_dance_to_command(beesInQueue[0]))
	else:
		bee_indicator.set_present(false)
	SignalBuss.send_bee.emit(cords)
	
func _on_bee_idle(new_bee : Beegroup):
	beesInQueue.append(new_bee)
	if len(beesInQueue) == 1:
		set_dancer_feedback(convert_dance_to_command(beesInQueue[0]))
	bee_indicator.set_present(true)
		
func convert_dance_to_command(bee1 : Beegroup) -> Array[Command]:
	var commandlist : Array[Command] = []
	for move in bee1.currentDance:
		var newCommand = Command.new()
		newCommand.dir = move[0]
		newCommand.duration = move[1]
		commandlist.append(newCommand)
	if len(commandlist) > 1 : commandlist.pop_front()
	return commandlist
