extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Atrocity"
var country := "Germany"
var engine := "V12 6.0L Twin Turbo"
var weight_kg := 2080
var zero_to_hundred_display := 4.30

func _ready():
	# GAMEPLAY STATS
	mass = 2080.0
	horsepower = 612
	max_rpm = 6200.0
	zero_to_hundred = 4.3
	top_speed_kmh = 250
	turn_speed = 2.55
	brake_strength = 13.6
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# Heavy GT handling (stable, powerful, not very agile)
	audio_character_type=8
	# AMG 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st
		2.19,  # 2nd
		1.41,  # 3rd
		1.00,  # 4th
		0.83   # 5th
	]

	shift_up_rpm = 5900
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
