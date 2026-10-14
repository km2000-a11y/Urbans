extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Zenith Prince"
var country := "Japan"
var engine := "V8 4.5L"
var weight_kg := 1850
var zero_to_hundred_display := 5.8

func _ready():
	# GAMEPLAY STATS
	mass = 1850.0
	horsepower = 340
	max_rpm = 6500.0
	idle_rpm = 650.0

	zero_to_hundred = 5.8
	top_speed_kmh = 253

	transmission = "Rear wheel drive"

	# Luxury performance sedan
	turn_speed = 2.55
	brake_strength = 12.0
	lateral_friction = 1.10

	# 5-speed automatic
	gear_count = 5
	gear_ratios = [
		3.83, # 1st
		2.36, # 2nd
		1.53, # 3rd
		1.00, # 4th
		0.83  # 5th
	]

	shift_up_rpm = 6200
	shift_down_rpm = 2100

	apply_stats()
	print("Child READY loaded:", def_car_name)
