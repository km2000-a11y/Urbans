extends CarController

var def_car_name := "Mir Cars Blazer"
var country := "Germany"
var engine := "V8 5.4L"
var weight_kg := 1745
var zero_to_hundred_display := 5.6

func _ready():

	# ENGINE — 1999 Mercedes-Benz E55 AMG (W210)
	# M113 5.4L naturally aspirated AMG V8

	mass = 1745.0
	horsepower = 354.0
	max_rpm = 6200.0
	idle_rpm = 650.0

	zero_to_hundred = 5.6
	top_speed_kmh = 263.0

	transmission = "Rear wheel drive"

	# HANDLING — Fast executive bruiser
	# Stable at very high speed, strong traction,
	# surprisingly agile for its size, but still heavy.

	turn_speed = 2.35
	brake_strength = 15.0
	lateral_friction = 1.12
	handling_type = "balanced"

	# TRANSMISSION — 5-speed AMG automatic

	gear_count = 5

	gear_ratios = [
		3.59, # 1st
		2.19, # 2nd
		1.41, # 3rd
		1.00, # 4th
		0.83  # 5th
	]

	has_supercharger = false
	has_turbo = false
	is_diesel = false

	# AMG-style shift behaviour
	shift_up_rpm = 5900
	shift_down_rpm = 2200

	# ENGINE AUDIO — AMG V8
	audio_character_type = 7
	audio_base_pitch = 0.92
	audio_pitch_range = 0.75
	audio_volume_offset = 0.5

	apply_stats()
	print("Child READY loaded:", def_car_name)
