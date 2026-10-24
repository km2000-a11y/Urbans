extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Strandberg Turbo"
var country := "USA"
var engine := "I5 2.5L Turbo"
var weight_kg := 1550
var zero_to_hundred_display := 6.6

func _ready():
	# GAMEPLAY STATS
	mass = 1550.0
	horsepower = 250
	max_rpm = 6500.0
	zero_to_hundred = 5.9
	top_speed_kmh = 250
	turn_speed = 2.8
	brake_strength = 11.8
	lateral_friction = 1.08
	transmission = "Four wheel drive"

	# DRIVETRAIN & GEARS
	gear_count = 6
	gear_ratios = [
		3.35,
		2.10,
		1.45,
		1.10,
		0.90,
		0.73
	]
	shift_up_rpm = 6200
	shift_down_rpm = 2700
	has_turbo = true

	apply_stats()
	print("Child READY loaded:", def_car_name)
