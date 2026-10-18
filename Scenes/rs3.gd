extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "L5 2.2L Turbo"
var weight_kg := 1490
var zero_to_hundred_display := 5.40

func _ready():

	# GAMEPLAY STATS — Audi S2 Inspired
	mass = 1490.0
	horsepower = 270
	max_rpm = 7200.0
	zero_to_hundred = 5.4
	top_speed_kmh = 265

	# Compact AWD turbo gremlin
	# Fast direction changes, excellent traction,
	# slightly nose-heavy at the limit
	turn_speed = 2.70
	brake_strength = 22.5
	lateral_friction = 1.18

	transmission = "Four wheel drive"

	# Turbocharged five-cylinder powerband
	shift_up_rpm = 6900
	shift_down_rpm = 2800

	gear_count = 6

	gear_ratios = [
		3.50, # 1st
		2.12, # 2nd
		1.48, # 3rd
		1.12, # 4th
		0.88, # 5th
		0.72  # 6th
	]

	has_turbo = true

	apply_stats()
	print("Child READY loaded:", def_car_name)
