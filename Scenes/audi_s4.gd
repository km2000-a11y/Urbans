extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Schroder Classique Sport"
var country := "Germany"
var engine := "V8 4.2L"
var weight_kg := 1855
var zero_to_hundred_display := 4.80

func _ready():
	# GAMEPLAY STATS — Audi S4 Convertible (B7)
	mass = 1855.0
	horsepower = 340
	max_rpm = 7000.0
	zero_to_hundred = 4.8
	top_speed_kmh = 265
	turn_speed = 2.55              # heavier GT cabrio, stable not twitchy
	brake_strength = 20.5          # strong brakes for 1.8t quattro chassis
	lateral_friction = 1.18        # quattro grip, but softer than TT RS
	transmission = "Four wheel drive"

	# SHIFT LOGIC — V8 high‑rev character
	shift_up_rpm = 6800
	shift_down_rpm = 3000

	# QUATTRO V8 GEARING (B7 S4 style)
	gear_count = 6
	gear_ratios = [
		3.67,  # 1st - strong V8 launch
		2.05,  # 2nd
		1.46,  # 3rd
		1.13,  # 4th
		0.97,  # 5th
		0.84   # 6th - long GT overdrive
	]

	# HANDLING PROFILE — Executive GT Cabrio
	# Heavy, planted, mature, quattro stability
	handling_type = "executive_gt"

	apply_stats()
	print("Child READY loaded:", def_car_name)
