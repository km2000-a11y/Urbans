extends CarController

var def_car_name := "Kronstadt Monarch" 
var country := "Germany" 
var engine := "V8 4.3L" 
var weight_kg := 1660 
var zero_to_hundred_display := 6.6

func _ready():

	# ENGINE — 2001 Mercedes-Benz E430 (W210)
	# M113 4.3L naturally aspirated V8
	mass = 1660.0
	horsepower = 275.0
	max_rpm = 6000.0
	idle_rpm = 650.0
	zero_to_hundred = 6.4
	top_speed_kmh = 250.0
	transmission = "Rear wheel drive"

	# HANDLING — Composed executive sedan
	# Stable at speed, comfortable through corners,
	# with a little body weight and rear-drive character.
	turn_speed = 2.25
	brake_strength = 13.0
	lateral_friction = 1.10
	handling_type = "balanced"

	# TRANSMISSION — 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59, # 1st
		1.99, # 2nd
		1.41, # 3rd
		1.00, # 4th
		0.83  # 5th
	]

	has_supercharger = false
	has_turbo = false
	is_diesel = false

	# Smooth, conservative automatic shift behavior
	shift_up_rpm = 5500
	shift_down_rpm = 1800

	# ENGINE AUDIO — Quiet, refined Mercedes V8
	audio_character_type = 0
	audio_base_pitch = 0.88
	audio_pitch_range = 0.38
	audio_volume_offset = -3.0

	apply_stats()
	print("Child READY loaded:", def_car_name)
