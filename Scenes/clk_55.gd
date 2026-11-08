extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Monarch"
var country := "Germany"
var engine := "V8 5.4L"
var weight_kg := 1720
var zero_to_hundred_display := 5.50

func _ready():
	# GAMEPLAY STATS — 2002 Mercedes-Benz CLK55 AMG
	mass = 1720.0
	horsepower = 342
	max_rpm = 6100.0
	idle_rpm = 650.0
	zero_to_hundred = 4.9
	top_speed_kmh = 250
	transmission = "Rear wheel drive"

	# HANDLING — Stable AMG grand tourer
	turn_speed = 2.70
	brake_strength = 12.8
	audio_character_type=7
	lateral_friction = 1.20

	# Mercedes 722.6 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st
		2.19,  # 2nd
		1.41,  # 3rd
		1.00,  # 4th
		0.83   # 5th
	]

	has_supercharger = false

	shift_up_rpm = 5900
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
