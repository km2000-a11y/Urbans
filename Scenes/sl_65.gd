extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Atrocity"
var country := "Germany"
var engine := "I4 2.3L Supercharged"
var weight_kg := 1450
var zero_to_hundred_display := 6.30

func _ready():
	# GAMEPLAY STATS
	mass = 1450.0
	horsepower = 325
	max_rpm = 6200.0
	zero_to_hundred = 5.2
	top_speed_kmh = 246
	turn_speed = 3.25
	brake_strength = 11.8
	lateral_friction = 1.03
	transmission = "Rear wheel drive"

	# Tuned W202 handling
	audio_character_type = 8
	has_supercharger=true
	# 5-speed manual
	gear_count = 5
	gear_ratios = [
		3.91,  # 1st
		2.20,  # 2nd
		1.52,  # 3rd
		1.00,  # 4th
		0.81   # 5th
	]

	shift_up_rpm = 6000
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
