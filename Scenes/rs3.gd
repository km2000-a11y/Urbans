extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Strandberg Pilot"
var country := "Sweden"
var engine := "I4 2.3L Turbo"
var weight_kg := 1610
var zero_to_hundred_display := 5.40

func _ready():

	# GAMEPLAY STATS — Saab 9-5 Aero
	mass = 1610.0
	horsepower = 230
	max_rpm = 6800.0
	zero_to_hundred = 5.7
	top_speed_kmh = 250

	# Fast Swedish executive sedan
	# Strong turbo pull, stable motorway manners,
	# comfortable and predictable rather than aggressive
	turn_speed = 2.50
	brake_strength = 22.5
	lateral_friction = 1.14

	transmission = "Four wheel drive"

	# Turbocharged inline-four powerband
	shift_up_rpm = 6500
	shift_down_rpm = 2500

	gear_count = 6

	gear_ratios = [
		3.50, # 1st
		1.89, # 2nd
		1.23, # 3rd
		0.97, # 4th
		0.81, # 5th
		0.68  # 6th
	]

	has_turbo = true


	apply_stats()
	print("Child READY loaded:", def_car_name)
