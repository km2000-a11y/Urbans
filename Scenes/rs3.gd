extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "V8 4.2L"
var weight_kg := 1840
var zero_to_hundred_display := 5.60

func _ready():

	# GAMEPLAY STATS — Audi S4 Cabriolet (2004)

	mass = 1840.0
	horsepower = 344
	max_rpm = 7200.0
	zero_to_hundred = 5.4
	top_speed_kmh = 265

	# Heavy grand tourer with quattro stability
	turn_speed = 2.45
	brake_strength = 21.0
	lateral_friction = 1.14

	transmission = "Four wheel drive"

	# Naturally aspirated V8
	shift_up_rpm = 7000
	shift_down_rpm = 2500

	gear_count = 6

	gear_ratios = [
		3.67, # 1st
		2.05, # 2nd
		1.42, # 3rd
		1.07, # 4th
		0.86, # 5th
		0.69  # 6th
	]

	has_turbo = false

	apply_stats()
	print("Child READY loaded:", def_car_name)
