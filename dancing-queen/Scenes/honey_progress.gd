extends ProgressBar

func _process(delta: float) -> void:
	value = Utils.honey_stored / Constants.STORE_GOAL * 100
