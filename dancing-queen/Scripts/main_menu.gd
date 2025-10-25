extends Control


func _on_start_button_down() -> void:
	get_tree().change_scene_to_file("res://Assets/World.tscn")


func _on_settings_button_down() -> void:
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
