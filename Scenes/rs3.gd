extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "V6 2.7L Twin Turbo"
var weight_kg := 1610
var zero_to_hundred_display := 5.40

func _ready():

	# GAMEPLAY STATS — 1997 Audi S4 (B5)
	mass = 1610.0
	horsepower = 280
	max_rpm = 6800.0
	zero_to_hundred = 5.4
	top_speed_kmh = 265

	# Stable AWD sports sedan
	# Excellent traction, planted at speed,
	# quick but not razor-sharp like lighter sports cars
	turn_speed = 2.50
	brake_strength = 22.5
	lateral_friction = 1.14

	transmission = "Four wheel drive"

	# Twin-turbo V6 powerband
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
