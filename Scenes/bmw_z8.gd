extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Sovereign 650"
var country := "Germany"
var engine := "V8 4.8L Naturally Aspirated"
var weight_kg := 1735
var zero_to_hundred_display := 5.40

func _ready():
	# GAMEPLAY STATS — BMW 650i (E63/E64)
	mass = 1735.0
	horsepower = 360
	max_rpm = 6500.0
	idle_rpm = 700.0
	zero_to_hundred = 5.4
	top_speed_kmh = 266
	transmission = "Rear wheel drive"

	# HANDLING — Grand Tourer, stable and powerful
	turn_speed = 2.55
	brake_strength = 12.5
	lateral_friction = 1.15

	# 6-speed automatic/manual
	gear_count = 6
	gear_ratios = [
		4.17,  # 1st
		2.34,  # 2nd
		1.52,  # 3rd
		1.14,  # 4th
		0.87,  # 5th
		0.69   # 6th
	]

	shift_up_rpm = 6400
	shift_down_rpm = 1800

	apply_stats()
	print("Child READY loaded:", def_car_name)
