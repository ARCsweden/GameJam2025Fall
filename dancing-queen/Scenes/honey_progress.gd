extends ProgressBar

func _process(_delta: float) -> void:
	value = Utils.honey_stored / Constants.STORE_GOAL * 100
