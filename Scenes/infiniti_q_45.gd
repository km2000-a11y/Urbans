extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Regent"
var country := "Japan"
var engine := "L6 3.0L"
var weight_kg := 1680
var zero_to_hundred_display := 6.30

func _ready():
	# GAMEPLAY STATS
	mass = 1680.0
	horsepower = 228
	max_rpm = 6500.0
	idle_rpm = 700.0
	zero_to_hundred = 6.4
	top_speed_kmh = 250
	transmission = "Rear wheel drive"

	# HANDLING — Sport luxury sedan
	turn_speed = 2.5
	brake_strength = 11.5
	lateral_friction = 1.12
	handling_type = "sport_sedan"

	# 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.36,	# 1st
		2.00,	# 2nd
		1.42,	# 3rd
		1.00,	# 4th
		0.75	# 5th
	]

	shift_up_rpm = 6200
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
