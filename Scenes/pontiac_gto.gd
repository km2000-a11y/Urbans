extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Dragster"
var country := "USA"
var engine := "V8 5.7L"
var weight_kg := 1680
var zero_to_hundred_display := 5.20

func _ready():
	# GAMEPLAY STATS
	mass = 1680.0
	horsepower = 350
	max_rpm = 6000.0
	zero_to_hundred = 4.9
	top_speed_kmh = 278
	turn_speed = 2.70
	brake_strength = 12.4
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# Holden Monaro / Pontiac GTO character
	# Strong V8 torque, stable highway cruiser, less agile than XLR
	gear_count = 6
	gear_ratios = [
		2.66,  # 1st
		1.78,  # 2nd
		1.30,  # 3rd
		1.00,  # 4th
		0.74,  # 5th
		0.50   # 6th
	]

	shift_up_rpm = 5800
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
