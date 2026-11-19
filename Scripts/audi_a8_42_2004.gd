extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Mir Cars Transporter"
var country := "UAE"
var engine := "V8 5.0L"
var weight_kg := 1780
var zero_to_hundred_display := 6.20

func _ready():
	# GAMEPLAY STATS — UAE performance sedan with AWD traction
	mass = 1550.0
	horsepower = 240
	max_rpm = 6500.0               # High-revving 5.0L tuned for strong mid-range acceleration
	zero_to_hundred = 6.1
	top_speed_kmh = 250
	turn_speed = 2.55              # Balanced steering; heavier than sport sedans, lighter than SUVs
	brake_strength = 11.2          # Strong brakes for a 1.7-ton AWD chassis
	lateral_friction = 1.08        # Confident AWD grip on pavement and desert roads
	transmission = "Front wheel drive"

	# Mir Cars 6-Speed Performance AWD Gearbox
	# Tuned for quick launches, highway speed, and desert stability
	gear_count = 5

	gear_ratios = [
		3.38, # 1st
		1.77, # 2nd
		1.18, # 3rd
		0.89, # 4th
		0.70  # 5th
]
	shift_up_rpm = 6200
	shift_down_rpm = 2600

	# DISTINCT HANDLING PROFILE — Heavy, stable, UAE performance sedan
	handling_type = "performance_sedan"

	apply_stats()
	print("Child READY loaded:", def_car_name)
