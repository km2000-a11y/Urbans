extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Blazer"
var country := "Germany"
var engine := "V8 4.3L"
var weight_kg := 1570
var zero_to_hundred_display := 6.10

func _ready():
	# GAMEPLAY STATS — Refined German V8 grand tourer
	mass = 1570.0
	horsepower = 278
	max_rpm = 6000.0
	idle_rpm = 650.0
	zero_to_hundred = 6.1
	top_speed_kmh = 256
	transmission = "Rear wheel drive"

	# HANDLING — Stable, predictable, confidence-inspiring
	turn_speed = 2.45
	brake_strength = 11.5
	lateral_friction = 1.12
	handling_type = "luxury_gt"

	# Mercedes 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st - smooth launch
		2.19,  # 2nd - strong V8 pull
		1.41,  # 3rd - mid-range cruising
		1.00,  # 4th - direct drive
		0.83   # 5th - highway overdrive
	]

	shift_up_rpm = 5800
	shift_down_rpm = 2300

	apply_stats()
	print("Child READY loaded:", def_car_name)
