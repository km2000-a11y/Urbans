extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Zenith Regent"
var country := "Japan"
var engine := "V8 4.5L"
var weight_kg := 1780
var zero_to_hundred_display := 6.60

func _ready():
	# GAMEPLAY STATS
	mass = 1780.0
	horsepower = 278
	max_rpm = 6900.0
	idle_rpm = 700.0
	zero_to_hundred = 6.6
	top_speed_kmh = 257
	transmission = "Rear wheel drive"

	# HANDLING — Fast Japanese luxury express
	turn_speed = 2.35
	brake_strength = 11.0
	lateral_friction = 1.08
	handling_type = "luxury_boat"

	# 4-speed automatic
	gear_count = 4
	gear_ratios = [
		2.79,  # 1st
		1.55,  # 2nd
		1.00,  # 3rd
		0.69   # 4th
	]

	shift_up_rpm = 6500
	shift_down_rpm = 2400

	apply_stats()
	print("Child READY loaded:", def_car_name)
