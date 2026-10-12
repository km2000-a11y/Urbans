extends CanvasLayer

var target_car: CarController

func _process(delta: float) -> void:
	$Control/Speed.text = "%d %s" % [
		int(round(Global.speed)),
		Global.speed_unit
	]

	if Global.gear == -1:
		$Control/Gear.text = "R"
	else:
		$Control/Gear.text = "G" + str(Global.gear)

	# Added digital tachometer display (assuming your label node path is $Control/Tachometer)
	$Control/Tachometer.text = "%d RPM" % int(round(Global.tachometer))
