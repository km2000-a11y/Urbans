extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Roadstar"
var country := "Germany"
var engine := "V8 4.9L"
var weight_kg := 1585
var zero_to_hundred_display := 4.70

func _ready():
	# GAMEPLAY STATS — Elegant German roadster with V8 muscle
	mass = 1585.0
	horsepower = 400
	max_rpm = 6800.0
	idle_rpm = 750.0
	zero_to_hundred = 4.9
	top_speed_kmh = 280
	transmission = "Rear wheel drive"

	# HANDLING — Sharp for a GT, stable at speed
	turn_speed = 2.65
	brake_strength = 12.5
	lateral_friction = 1.18
	handling_type = "luxury_gt"

	# 6-speed manual
	gear_count = 6
	gear_ratios = [
		4.23,  # 1st - strong launch
		2.53,  # 2nd - hard acceleration
		1.67,  # 3rd - mid-range pull
		1.23,  # 4th - driving gear
		1.00,  # 5th - direct drive
		0.83   # 6th - cruising overdrive
	]

	shift_up_rpm = 6600
	shift_down_rpm = 2500

	apply_stats()
	print("Child READY loaded:", def_car_name)
