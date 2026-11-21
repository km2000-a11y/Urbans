extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Mocha"
var country := "UK"
var engine := "V8 4.2L"
var weight_kg := 1750
var zero_to_hundred_display := 6.00

func _ready():
	# GAMEPLAY STATS — Refined British executive sedan
	mass = 1752.0
	horsepower = 238
	max_rpm = 5000.0
	zero_to_hundred = 7.1
	top_speed_kmh = 246
	turn_speed = 2.40
	brake_strength = 11.2
	lateral_friction = 1.05
	transmission = "Four wheel drive"

	# Smooth luxury-sedan handling
	handling_type = "executive_sedan"
	audio_character_type=10

	# ZF 6-speed automatic
	gear_count = 6

	gear_ratios = [
		4.10,  # 1st
		2.50,  # 2nd
		1.65,  # 3rd
		1.20,  # 4th
		0.90,  # 5th
		0.72   # 6th
	]

	shift_up_rpm = 4600
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
