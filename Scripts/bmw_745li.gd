extends CarController

# COSMETIC INFO (UI only)
var def_car_name := "Eisenach Monarch"
var country := "Germany"
var engine := "V8 3.9L Twin Turbo Diesel"
var weight_kg := 1985
var zero_to_hundred_display := 7.10

func _ready():
	# GAMEPLAY STATS
	mass = 1985.0
	horsepower = 245
	max_rpm = 4800.0
	zero_to_hundred = 7.3
	top_speed_kmh = 252
	turn_speed = 2.20
	brake_strength = 10.4
	lateral_friction = 1.00
	transmission = "Rear wheel drive"

	# E38 740d automatic gearbox
	gear_count = 5
	gear_ratios = [
		3.57, # 1st - massive diesel launch torque
		2.20, # 2nd - strong mid-range pull
		1.51, # 3rd - effortless overtaking
		1.00, # 4th - direct drive
		0.83  # 5th - autobahn cruising
	]
	
	is_diesel=true
	has_turbo=true

	# SHIFT LOGIC (torquey diesel behavior)
	shift_up_rpm = 4300
	shift_down_rpm = 1400

	apply_stats()
	print("Child READY loaded:", def_car_name)
