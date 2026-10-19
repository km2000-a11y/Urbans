extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Monarch"
var country := "Germany"
var engine := "V8 4.2L"
var weight_kg := 1565
var zero_to_hundred_display := 5.30

func _ready():
	# GAMEPLAY STATS — Refined German luxury GT with effortless V8 torque
	mass = 1678.0
	horsepower = 350
	max_rpm = 6500.0
	idle_rpm = 700.0
	zero_to_hundred = 5.3
	top_speed_kmh = 254
	transmission = "Rear wheel drive"

	# HANDLING — Stable grand tourer with predictable high-speed manners
	turn_speed = 2.65
	brake_strength = 12.2
	lateral_friction = 1.17

	# Mercedes 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.59,  # 1st - relaxed launch
		2.19,  # 2nd - strong V8 torque
		1.41,  # 3rd - effortless acceleration
		1.00,  # 4th - direct drive
		0.83   # 5th - autobahn cruising
	]

	has_supercharger = false

	shift_up_rpm = 6200
	shift_down_rpm = 2400

	apply_stats()
	print("Child READY loaded:", def_car_name)
