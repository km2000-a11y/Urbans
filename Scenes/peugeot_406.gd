extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Straeda Volant"
var country := "France"
var engine := "V6 3.0L"
var weight_kg := 1390
var zero_to_hundred_display := 7.80

func _ready():
	# GAMEPLAY STATS — Nimble French executive sedan
	mass = 1390.0
	horsepower = 210
	max_rpm = 6500.0
	zero_to_hundred = 6.9
	top_speed_kmh = 238
	turn_speed = 3.20
	brake_strength = 13.5
	lateral_friction = 1.35
	transmission = "Front wheel drive"

	# Taxi-inspired handling
	handling_type = "fwd_hot_hatch"

	# 5-speed manual
	gear_count = 5
	gear_ratios = [
		3.45,  # 1st
		1.95,  # 2nd
		1.36,  # 3rd
		1.03,  # 4th
		0.82   # 5th
	]

	shift_up_rpm = 6100
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
