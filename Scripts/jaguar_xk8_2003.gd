extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Falcon"
var country := "UK"
var engine := "V8 4.2L"
var weight_kg := 1715
var zero_to_hundred_display := 6.10

func _ready():
	# GAMEPLAY STATS
	mass = 1715.0
	horsepower = 300
	max_rpm = 6100.0
	zero_to_hundred = 5.8
	top_speed_kmh = 273
	turn_speed = 2.45
	brake_strength = 11.5
	lateral_friction = 1.03
	transmission = "Rear wheel drive"

	# Jaguar XK8 grand tourer handling
	handling_type = "luxury_boat"

	# ZF 6-speed automatic
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st
		2.34,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.87,  # 5th
		0.69   # 6th
	]

	has_supercharger = false

	shift_up_rpm = 5500
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
