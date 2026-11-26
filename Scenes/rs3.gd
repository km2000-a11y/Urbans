extends CarController

# COSMETIC INFO (UI only)

var def_car_name := "Strandberg Pilot"

var country := "Sweden"

var engine := "I5 2.3L Turbo"

var weight_kg := 1610

var zero_to_hundred_display := 6.10

func _ready():

	# GAMEPLAY STATS — 1999 Volvo C70 T5 Coupe

	mass = 1610.0

	horsepower = 245

	max_rpm = 6200.0

	zero_to_hundred = 6.1

	top_speed_kmh = 250

	# Stylish Swedish GT coupe
	# Strong turbo mid-range,
	# high-speed stability,
	# slight understeer under power,
	# more cruiser than sports car

	turn_speed = 2.35

	brake_strength = 22.0

	lateral_friction = 1.10

	transmission = "Front wheel drive"

	# Turbocharged inline-five powerband

	shift_up_rpm = 6100

	shift_down_rpm = 2400

	gear_count = 5

	gear_ratios = [
		3.38, # 1st
		1.90, # 2nd
		1.28, # 3rd
		0.95, # 4th
		0.70  # 5th
	]

	has_turbo = true

	apply_stats()

	print("Child READY loaded:", def_car_name)
