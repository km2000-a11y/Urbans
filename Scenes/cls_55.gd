extends CarController

# COSMETIC INFO (UI only)

var def_car_name := "Strandberg Sovereign"

var country := "Sweden"

var engine := "V8 4.4L"

var weight_kg := 1850

var zero_to_hundred_display := 5.70


func _ready():

	# GAMEPLAY STATS — Volvo S80 V8 AWD

	mass = 1850.0

	horsepower = 315

	max_rpm = 6500.0

	idle_rpm = 650.0

	zero_to_hundred = 5.7

	top_speed_kmh = 266

	transmission = "Four wheel drive"

	# HANDLING — Fast Swedish luxury flagship
	# Extremely stable at speed,
	# confident AWD grip,
	# more autobahn express than sports car

	turn_speed = 2.25

	brake_strength = 12.5

	lateral_friction = 1.28

	audio_character_type = 2

	has_supercharger = false

	has_turbo = false

	# 6-speed automatic

	gear_count = 6

	gear_ratios = [

		4.15, # 1st
		2.37, # 2nd
		1.56, # 3rd
		1.16, # 4th
		0.86, # 5th
		0.69  # 6th

	]

	shift_up_rpm = 6200

	shift_down_rpm = 1900

	apply_stats()

	print("Child READY loaded:", def_car_name)
