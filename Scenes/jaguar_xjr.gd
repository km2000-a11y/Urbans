extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Prince"
var country := "UK"
var engine := "V8 4.0L Supercharged"
var weight_kg := 1780
var zero_to_hundred_display := 5.70

func _ready():
	# GAMEPLAY STATS
	mass = 1780.0
	horsepower = 370
	max_rpm = 6200.0
	idle_rpm = 700.0

	zero_to_hundred = 5.7
	top_speed_kmh = 259

	transmission = "Rear wheel drive"

	# Fast executive saloon
	turn_speed = 2.65
	brake_strength = 12.0
	lateral_friction = 1.12

	handling_type = "luxury_boat"

	# 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st
		2.19,  # 2nd
		1.41,  # 3rd
		1.00,  # 4th
		0.83   # 5th
	]

	shift_up_rpm = 6000
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
