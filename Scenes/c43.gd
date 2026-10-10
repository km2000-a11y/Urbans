extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Blazer"
var country := "Germany"
var engine := "V6 3.2L Supercharged"
var weight_kg := 1565
var zero_to_hundred_display := 4.80

func _ready():
	# GAMEPLAY STATS — Supercharged AMG sleeper with explosive mid-range power
	mass = 1565.0
	horsepower = 349
	max_rpm = 6500.0
	idle_rpm = 700.0
	zero_to_hundred = 5.6
	top_speed_kmh = 257
	transmission = "Rear wheel drive"

	# HANDLING — Sharp, stable and confidence-inspiring
	turn_speed = 2.65
	brake_strength = 12.2
	lateral_friction = 1.17

	# Mercedes 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st - strong launch
		2.19,  # 2nd - brutal supercharged pull
		1.41,  # 3rd - mid-range acceleration
		1.00,  # 4th - direct drive
		0.83   # 5th - high-speed cruising
	]

	shift_up_rpm = 6200
	shift_down_rpm = 2400

	apply_stats()
	print("Child READY loaded:", def_car_name)
