extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Suppressor"
var country := "Germany"
var engine := "I6 3.0L Twin Turbo Diesel"
var weight_kg := 1735
var zero_to_hundred_display := 6.00

func _ready():
	# GAMEPLAY STATS
	mass = 1735.0
	horsepower = 286
	max_rpm = 5000.0
	zero_to_hundred = 5.8
	top_speed_kmh = 250
	turn_speed = 2.60
	brake_strength = 13.0
	lateral_friction = 1.05
	transmission = "Rear wheel drive"

	# E60 535d handling (massive mid-range torque, stable cruiser)

	# 6-speed automatic inspired gearing
	gear_count = 6
	gear_ratios = [
		4.17, # 1st
		2.34, # 2nd
		1.52, # 3rd
		1.14, # 4th
		0.87, # 5th
		0.69  # 6th
	]

	# SHIFT LOGIC (high-torque diesel)
	shift_up_rpm = 4700
	shift_down_rpm = 1600
	is_diesel = true

	apply_stats()
	print("Child READY loaded:", def_car_name)
