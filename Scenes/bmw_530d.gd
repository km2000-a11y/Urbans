extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Fastback"
var country := "Germany"
var engine := "V6 3.0L Turbo Diesel"
var weight_kg := 1680
var zero_to_hundred_display := 5.9

func _ready():

	# GAMEPLAY STATS
	mass = 1680.0
	horsepower = 240
	max_rpm = 5000.0

	zero_to_hundred = 5.6
	top_speed_kmh = 250

	turn_speed = 2.70
	brake_strength = 13.0
	lateral_friction = 1.08

	transmission = "Four wheel drive"

	# Audi A4 3.0 TDI Quattro
	# Fast executive cruiser with strong diesel torque

	gear_count = 6

	gear_ratios = [
		3.67, # 1st
		2.05, # 2nd
		1.36, # 3rd
		0.97, # 4th
		0.74, # 5th
		0.62  # 6th
	]

	# DIESEL SHIFT LOGIC
	shift_up_rpm = 4700
	shift_down_rpm = 1500

	is_diesel = true
	has_turbo = true

	apply_stats()

	print("Child READY loaded:", def_car_name)
