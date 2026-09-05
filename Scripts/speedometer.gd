extends CanvasLayer

var target_car: CarController
func _process(delta: float) -> void:
	$Control/Speed.text = str(int(round(Global.speed))) + " km/h"
	if Global.gear == -1:
		$Control/Gear.text = "R"
	else:
		$Control/Gear.text = "G" + str(Global.gear)
