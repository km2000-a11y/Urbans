extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Roadstar"
var country := "Germany"
var engine := "I6 3.2L Naturally Aspirated"
var weight_kg := 1485
var zero_to_hundred_display := 4.80

func _ready():
	# GAMEPLAY STATS — Lightweight BMW M roadster with high-revving straight-six
	mass = 1485.0
	horsepower = 343
	max_rpm = 8000.0
	idle_rpm = 800.0
	zero_to_hundred = 4.5
	top_speed_kmh = 250
	transmission = "Rear wheel drive"

	# HANDLING — Agile, responsive and playful
	turn_speed = 2.85
	brake_strength = 12.8
	lateral_friction = 1.22
	# 6-speed manual
	gear_count = 6
	gear_ratios = [
		4.35,  # 1st - aggressive launch
		2.50,  # 2nd - strong acceleration
		1.66,  # 3rd - high-rev pull
		1.23,  # 4th - fast road gear
		1.00,  # 5th - direct drive
		0.83   # 6th - high-speed cruising
	]

	shift_up_rpm = 7900
	shift_down_rpm = 2800

	apply_stats()
	print("Child READY loaded:", def_car_name)
