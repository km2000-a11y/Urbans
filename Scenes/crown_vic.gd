extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Brutus Mammoth"
var country := "USA"
var engine := "V8 4.6L Supercharged"
var weight_kg := 1880
var zero_to_hundred_display := 5.7

func _ready():
	# GAMEPLAY STATS
	mass = 1880.0
	horsepower = 365
	max_rpm = 6200.0
	zero_to_hundred = 5.7
	top_speed_kmh = 250
	turn_speed = 2.1
	brake_strength = 11.2
	lateral_friction = 1.02
	transmission = "Rear wheel drive"

	# DRIVETRAIN & GEARS
	gear_count = 4

	gear_ratios = [
		2.84,  # 1st
		1.55,  # 2nd
		1.00,  # 3rd
		0.70   # 4th
	]

	shift_up_rpm = 5800
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
