extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Blazer"
var country := "Germany"
var engine := "V8 5.0L"
var weight_kg := 1830
var zero_to_hundred_display := 5.80

func _ready():
	# GAMEPLAY STATS
	mass = 1830.0
	horsepower = 316
	max_rpm = 6000.0
	zero_to_hundred = 5.8
	top_speed_kmh = 250
	turn_speed = 2.65
	brake_strength = 12.0
	lateral_friction = 1.08
	transmission = "Rear wheel drive"

	# SL500 R129-style handling (heavy GT, smooth V8, stable RWD)
	

	# Mercedes 5-speed automatic (long, torque-heavy gearing)
	gear_count = 5
	gear_ratios = [
		3.95,  # 1st - strong V8 launch
		2.41,  # 2nd
		1.49,  # 3rd
		1.00,  # 4th - direct drive
		0.73   # 5th - overdrive for 250 km/h
	]

	shift_up_rpm = 5600
	shift_down_rpm = 2300

	apply_stats()
	print("Child READY loaded:", def_car_name)
