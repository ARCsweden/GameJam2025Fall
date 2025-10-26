extends Camera2D

func _input(event):
	## Mouse in viewport coordinates.
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
			position -= event.relative / zoom.x
			print(event.relative)
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			# zoom in
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				#zoom_pos = get_global_mouse_position()
				# call the zoom function
				zoom += Vector2(0.1,0.1)
			# zoom out
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				#zoom_pos = get_global_mouse_position()
				# call the zoom function
				zoom -= Vector2(0.1,0.1)
			zoom.x = clamp(zoom.x,1,4.5)
			zoom.y = clamp(zoom.y,1,4.5)
			
		#print("Mouse Click/Unclick at: ", event.position)
	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
#
	## Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
