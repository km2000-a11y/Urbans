extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Berkshire Blunt"
var country := "UK"
var engine := "V8 4.0L Supercharged"
var weight_kg := 1832
var zero_to_hundred_display := 5.60

func _ready():
	# GAMEPLAY STATS
	mass = 1832.0
	horsepower = 370
	max_rpm = 6200.0
	zero_to_hundred = 5.6
	top_speed_kmh = 268
	turn_speed = 2.55
	brake_strength = 12.0
	lateral_friction = 1.06
	transmission = "Rear wheel drive"

	# Jaguar XKR-style GT handling (heavy, smooth, torque-rich)


	# Jaguar 5-speed auto (1999 spec, long gears, smooth shifts)
	gear_count = 5
	gear_ratios = [
		3.36,  # 1st - strong GT launch
		2.04,  # 2nd
		1.40,  # 3rd
		1.00,  # 4th
		0.70   # 5th - overdrive
	]
	shift_up_rpm = 5600
	shift_down_rpm = 2000

	apply_stats()
	print("Child READY loaded:", def_car_name)
