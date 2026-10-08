extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Prince"
var country := "USA"
var engine := "V8 3.9L"
var weight_kg := 1780
var zero_to_hundred_display := 5.6

func _ready():
	# GAMEPLAY STATS
	mass = 1780.0
	horsepower = 285
	max_rpm = 6100.0
	idle_rpm = 700.0

	zero_to_hundred = 5.7
	top_speed_kmh = 253

	transmission = "Rear wheel drive"

	# Fast executive saloon
	turn_speed = 2.70
	brake_strength = 12.2
	lateral_friction = 1.14

	handling_type = "luxury_boat"

	# 6-speed automatic
	gear_count = 6
	gear_ratios = [
		4.17, # 1st
		2.34, # 2nd
		1.52, # 3rd
		1.14, # 4th
		0.87, # 5th
		0.69  # 6th
	]

	shift_up_rpm = 5900
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
