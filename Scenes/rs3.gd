extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "L5 2.2L Turbo"
var weight_kg := 1495
var zero_to_hundred_display := 5.40

func _ready():
	# GAMEPLAY STATS — Audi S2 Coupe (1994)

	mass = 1495.0
	horsepower = 230
	max_rpm = 7200.0
	zero_to_hundred = 5.4
	top_speed_kmh = 263

	# Older chassis, but excellent quattro grip
	turn_speed = 2.75
	brake_strength = 20.0
	lateral_friction = 1.18

	transmission = "Four wheel drive"

	# Classic 5-cylinder turbo
	shift_up_rpm = 6800
	shift_down_rpm = 2600

	# 6-speed gameplay gearing
	gear_count = 5

	gear_ratios = [
		3.50, # 1st
		1.89, # 2nd
		1.32, # 3rd
		0.97, # 4th
		0.73  # 5th
	]

	has_turbo = true

	apply_stats()
	print("Child READY loaded:", def_car_name)
