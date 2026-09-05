extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Blunt"
var country := "UK"
var engine := "V8 4.2L Supercharged"
var weight_kg := 1832
var zero_to_hundred_display := 5.60

func _ready():
	# GAMEPLAY STATS
	mass = 1832.0
	horsepower = 390
	max_rpm = 6200.0
	zero_to_hundred = 5.5
	top_speed_kmh = 273
	turn_speed = 2.55
	brake_strength = 12.0
	lateral_friction = 1.06
	transmission = "Rear wheel drive"

	# Jaguar XKR-style GT handling (heavy, smooth, torque-rich)
	handling_type = "luxury_boat"

	# ⭐ 2003 XKR — ZF 6HP26 6-speed automatic
	gear_count = 6
	gear_ratios = [
		4.171,  # 1st - strong supercharged launch
		2.340,  # 2nd
		1.521,  # 3rd
		1.143,  # 4th
		0.867,  # 5th
		0.691   # 6th - overdrive
	]

	shift_up_rpm = 5600
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
