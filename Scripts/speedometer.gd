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

	$Control/Tachometer.text = "%d RPM" % int(round(Global.tachometer))

	var nitro_text := ""

	for i in range(4):

		var filled :int= i < Global.nitro_bottles

		if filled:

			var blinking :bool= (
				Global.nitro_active
				and i == Global.nitro_bottles - 1
				and Global.nitro_timer < 1.0
			)

			if blinking:

				if int(Time.get_ticks_msec() / 150) % 2 == 0:
					nitro_text += "[color=#00AAFF]█[/color] "
				else:
					nitro_text += "[color=#444444]█[/color] "

			else:
				nitro_text += "[color=#00AAFF]█[/color] "

		else:
			nitro_text += "[color=#444444]█[/color] "

	$Control/Nitro.text = nitro_text
