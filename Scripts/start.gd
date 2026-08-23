extends CanvasLayer

signal countdown_finished

@onready var label := $Control/CountdownLabel

var cars: Array = []

func start_countdown(car_list):
	cars = car_list

	# freeze cars
	for c in cars:
		if c is CarController:
			c.controls_enabled = false
			c.velocity = Vector3.ZERO


	visible = true
	$Control/CountdownLabel.text = "3"
	await get_tree().create_timer(1.0).timeout

	$Control/CountdownLabel.text = "2"
	await get_tree().create_timer(1.0).timeout

	$Control/CountdownLabel.text = "1"
	await get_tree().create_timer(1.0).timeout

	$Control/CountdownLabel.text = "GO!"
	await get_tree().create_timer(0.7).timeout

	# unfreeze cars
	for c in cars:
		if c is CarController:
			c.controls_enabled = true
			c.hard_frozen = false

	visible = false

	get_parent().race_started = true
	emit_signal("countdown_finished")
