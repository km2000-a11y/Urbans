extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Straeda Volant"
var country := "Germany"
var engine := "I4 1.8L Turbo"
var weight_kg := 1375
var zero_to_hundred_display := 6.90

func _ready():
	# GAMEPLAY STATS
	mass = 1375.0
	horsepower = 180
	max_rpm = 6200.0
	zero_to_hundred = 6.9
	top_speed_kmh = 238
	turn_speed = 2.7
	brake_strength = 19.0
	lateral_friction = 1.15
	transmission = "Front wheel drive"

	# DISTINCT HANDLING PROFILE
	# Agile hot hatch with strong turbo torque.
	# Quick direction changes but prone to understeer at the limit.
	gear_count= 6

	gear_ratios = [
		3.36, # 1st
		2.09, # 2nd
		1.47, # 3rd
		1.10, # 4th
		0.87, # 5th
		0.74  # 6th
	]
	has_turbo=true
	shift_up_rpm = 5900
	shift_down_rpm = 2400

	# APPLY STATS + HANDLING
	apply_stats()

	print("Child READY loaded:", def_car_name)
