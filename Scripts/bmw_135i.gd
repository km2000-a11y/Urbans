extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Bengal"
var country := "Germany"
var engine := "I6 3.0L Naturally Aspirated"
var weight_kg := 1430
var zero_to_hundred_display := 6.00

func _ready():
	# GAMEPLAY STATS
	mass = 1430.0
	horsepower = 265
	max_rpm = 7000.0
	zero_to_hundred = 6.1
	top_speed_kmh = 246
	turn_speed = 2.95
	brake_strength = 14.0
	lateral_friction = 1.10
	transmission = "Rear wheel drive"

	# 130i handling (balanced RWD hatch, strong top-end power)

	# 6-speed manual inspired gearing
	gear_count = 6
	gear_ratios = [
		4.35,  # 1st
		2.50,  # 2nd
		1.66,  # 3rd
		1.23,  # 4th
		1.00,  # 5th
		0.85   # 6th
	]

	shift_up_rpm = 6800
	shift_down_rpm = 2200
	is_diesel = false

	apply_stats()
	print("Child READY loaded:", def_car_name)
