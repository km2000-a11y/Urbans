extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Goblin"
var country := "USA"
var engine := "I5 2.5L Turbo"
var weight_kg := 1550
var zero_to_hundred_display := 6.6

func _ready():
	# GAMEPLAY STATS
	mass = 1710.0
	horsepower = 280
	max_rpm = 6500.0
	zero_to_hundred = 6.4
	top_speed_kmh = 250
	turn_speed = 2.5
	brake_strength = 11.8
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# DRIVETRAIN & GEARS
	gear_count = 5

	gear_ratios = [
		3.22,  # 1st
		2.05,  # 2nd
		1.38,  # 3rd
		1.00,  # 4th
		0.73   # 5th
	]

	shift_up_rpm = 6000
	shift_down_rpm = 2200

	apply_stats()
	print("Child READY loaded:", def_car_name)
