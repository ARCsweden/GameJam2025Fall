extends Panel
@export var info_label : Label

func _ready() -> void:
	if Utils.info != "":
		info_label.text = Utils.info
		self.visible = true
		
		
