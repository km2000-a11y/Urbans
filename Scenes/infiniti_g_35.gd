extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Zenith Touring"
var country := "Japan"
var engine := "V6 3.5L"
var weight_kg := 1605
var zero_to_hundred_display := 5.60

func _ready():
	# GAMEPLAY STATS — Japanese sport executive coupe
	mass = 1605.0
	horsepower = 280
	max_rpm = 6600.0
	zero_to_hundred = 5.7
	top_speed_kmh = 253
	turn_speed = 2.55
	brake_strength = 10.8
	lateral_friction = 1.04
	transmission = "Rear wheel drive"

	# Agile GT handling
	handling_type = "executive_sedan"
	audio_character_type = 3

	# 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.54,  # 1st
		2.26,  # 2nd
		1.47,  # 3rd
		1.00,  # 4th
		0.83   # 5th
	]

	shift_up_rpm = 6400
	shift_down_rpm = 2500

	apply_stats()
	print("Child READY loaded:", def_car_name)
