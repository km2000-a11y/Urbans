extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Kronstadt Regent"
var country := "Germany"
var engine := "I6 3.2L Turbodiesel"
var weight_kg := 1685
var zero_to_hundred_display := 7.4


func _ready():

	# GAMEPLAY STATS

	mass = 1685.0

	horsepower = 197

	max_rpm = 5000.0
	idle_rpm = 700.0

	zero_to_hundred = 7.4

	top_speed_kmh = 246

	transmission = "Rear wheel drive"

	is_diesel = true

	# Comfortable but surprisingly capable

	turn_speed = 2.35
	brake_strength = 11.2
	lateral_friction = 1.04

	handling_type = "balanced"


	# Mercedes 722.6 5G-Tronic

	gear_count = 5

	gear_ratios = [
		3.59, # 1st
		2.19, # 2nd
		1.41, # 3rd
		1.00, # 4th
		0.83  # 5th
	]

	shift_up_rpm = 4500
	shift_down_rpm = 1700


	has_turbo = true
	has_supercharger = false

	apply_stats()

	print("Child READY loaded:", def_car_name)
