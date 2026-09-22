extends CanvasLayer

signal countdown_finished

@onready var label := $Control/CountdownLabel

func start_countdown(car_list):
	
	MusicManager.start_countdown()
	# Freeze cars
	for c in car_list:
		if c is CarController:
			c.controls_enabled = false
			c.velocity = Vector3.ZERO

	var cam = get_viewport().get_camera_3d()

	visible = true

	if cam and cam.has_method("set_countdown_view"):
		cam.set_countdown_view(0)

	label.text = "3"
	await get_tree().create_timer(1.0).timeout

	if cam and cam.has_method("set_countdown_view"):
		cam.set_countdown_view(1)

	label.text = "2"
	await get_tree().create_timer(1.0).timeout

	if cam and cam.has_method("set_countdown_view"):
		cam.set_countdown_view(2)

	label.text = "1"
	await get_tree().create_timer(1.0).timeout

	if cam and cam.has_method("end_countdown_view"):
		cam.end_countdown_view()

	label.text = "GO!"
	await get_tree().create_timer(0.7).timeout

	# Unfreeze cars
	for c in car_list:
		if c is CarController:
			c.controls_enabled = true
			c.hard_frozen = false

	visible = false

	get_parent().race_started = true
	countdown_finished.emit()
