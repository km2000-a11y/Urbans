extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Falcon"
var country := "UK"
var engine := "V8 4.2L"
var weight_kg := 1715
var zero_to_hundred_display := 6.10

func _ready():
	# GAMEPLAY STATS
	mass = 1815.0
	horsepower = 300
	max_rpm = 6100.0
	zero_to_hundred = 6.1
	top_speed_kmh = 267
	turn_speed = 2.45
	brake_strength = 11.5
	lateral_friction = 1.03
	transmission = "Rear wheel drive"

	# Jaguar XK8 grand tourer handling
	handling_type = "luxury_boat"

	# ZF 6-speed automatic
	gear_count = 5

	gear_ratios = [
		3.38, # 1st
		1.77, # 2nd
		1.18, # 3rd
		0.89, # 4th
		0.70  # 5th
]

	audio_character_type=8

	shift_up_rpm = 5500
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
