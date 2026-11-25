extends CarController

# COSMETIC INFO (UI only)

var def_car_name := "Schroder Prince"

var country := "Germany"

var engine := "W8 4.0L"

var weight_kg := 1750

var zero_to_hundred_display := 6.50

func _ready():

	# GAMEPLAY STATS — AWD executive sedan with smooth power delivery

	mass = 1750.0

	horsepower = 275

	max_rpm = 6200.0 # Naturally aspirated W8 with broad power band

	zero_to_hundred = 6.1

	top_speed_kmh = 250

	turn_speed = 2.45 # Stable and predictable rather than sporty

	brake_strength = 10.8 # Strong executive-car brakes

	lateral_friction = 1.05 # AWD grip but heavy chassis

	transmission = "Four wheel drive"

	# 5-Speed Automatic inspired gearing

	gear_count = 5

	gear_ratios = [
		3.57, # 1st
		2.09, # 2nd
		1.41, # 3rd
		1.00, # 4th
		0.74  # 5th
	]

	shift_up_rpm = 5900

	shift_down_rpm = 2200

	# DISTINCT HANDLING PROFILE — Heavy, refined German cruiser

	handling_type = "executive"

	apply_stats()

	print("Child READY loaded:", def_car_name)
