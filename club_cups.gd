extends Node

# ============================================================
#  FULL CLASS LIST (LOCAL — SELF-CONTAINED)
# ============================================================
var completed_cups: Array = []
var cash_rewards: Dictionary = {
	"colossus": 2500,
	"street_tuners": 5000,
	"muscle_hustle": 7500,

	"v6_engines": 10000,
	"zenith_competition": 12500,

	"businessman_racers": 15000,
	"japan_vs_germany":13000,
	"japanese_cup": 17500,
	"diesel_masters": 20000,

	"all_wheel_grip": 25000,
	"urban_performance_cars": 30000,
	"england_vs_italy":30000,

	"eisenach_cup": 32500,
	"colin_tribute": 35000,
	"drop_top_challenge": 40000,

	"low_displacement_challenge": 45000,
	"under_400_hp": 50000,

	"german_cup": 60000,
	"schroder_cup": 70000,

	"speedster_tournament": 80000,

	"berkshire_cup": 90000,

	"american_thunder": 100000,
	"british_invasion": 110000,

	"stingray_competition": 120000,
	"v8_fury": 130000,

	"gentleman_racers": 140000,

	"kestrel_max": 160000,

	"sport_racing": 180000,

	"v12_engines": 220000,

	"supercars": 275000,

	"track_cars": 350000
}
var class_lists: Dictionary = {

	# MAIN CLASSES

	"suv": [
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Schroder Colosso",
		"Mir Cars Nightwolf"
	],

	"compact": [
		"Straeda Volant",
		"Schroder Atrix Q32",
		"Eisenach Bengal",
		"Zenith Horizon"
	],
	"urban": [
		"Berkshire Falcon",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Brutus Stingray",
		"Berkshire Blunt",
	],
	

	"muscle": [
		"Brutus Viper",
		"Mir Cars Hutch"
	],

	"sedans": [
		"Kuro Vault",
		"Berkshire Mocha",
		"Mir Cars Goblin",
		"Zenith Touring",
		"Strandberg Turbo",
	],
	"torque_monsters":[
		"Schroder Suppressor",
		"Eisenach Monarch",
		"Kronstadt Regent",
	],
	


	"sport": [
		"Schroder Classique Sport",
		"Berkshire V12-S",
		"Kronstadt Predator",
		"Bartoli Cruiser",
	],

	"sport_racing": [
		"Kestrel Battleaxe",
		"Brutus Venom",
		"Linetti Shepherd",
		"Berkshire Tempest",
	],

	"supercars": [
		"Kestrel Guillotine",
		"Linetti Firestorm",
		"Mir Cars Raptor",
		"Linetti Terror"
	],

	"track_cars": [
		"Bartoli Track Cruiser",
		"Brutus Thunderbolt",
		"Mir Cars Athletic C70"
	],

	"special": [
		"Bartoli Cruiser Interceptor"
	],

	# CHAMPIONSHIP CLASSES

	"v6_engines":[
		"Schroder Atrix Q32",
		"Schroder Suppressor",
		"Berkshire Mocha",
		"Schroder Colosso",
		"Zenith Touring",
		"Schroder Classique Sport",
		"Zenith Horizon"
	],

	"zenith_competition":[
		"Zenith Horizon",
		"Zenith Touring",
	],

	"businessman_racers":[
		"Strandberg Turbo",
		"Kuro Vault",
		"Kronstadt Regent",
		"Mir Cars Goblin",
		"Eisenach Monarch",
		"Zenith Touring",
		"Berkshire Mocha",
		"Schroder Suppressor"
	],

	"japanese_cup":[
		"Zenith Horizon",
		"Mir Cars Nightwolf",
		"Zenith Touring",
		"Kuro Vault"
	],

	"diesel_masters":[
		"Schroder Colosso",
		"Eisenach Monarch",
		"Kronstadt Regent",
		"Schroder Suppressor"
	],

	"all_wheel_grip":[
		"Schroder Atrix Q32",
		"Schroder Classique Sport"<
		"Schroder Suppressor",
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Berkshire Mocha",
		"Mir Cars Nightwolf",
		"Schroder Colosso"
	],
	"colin_tribute":[
		"Kestrel Seabird"
	],

	"speedster_tournament":[
		"Kestrel Speedster"
	],

	"urban_performance_cars":[
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Brutus Stingray",
		"Berkshire Blunt",
		"Berkshire Falcon"
	],

	"eisenach_cup":[
		"Eisenach Bengal",
		"Eisenach Monarch"
	],

	"v8_fury":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Kuro Vault",
		"Berkshire Falcon",
		"Bartoli Cruiser",
		"Eisenach Monarch",
		"Kronstadt Predator",
		"Berkshire Blunt",
		"Brutus Stingray"
	],

	"berkshire_cup":[
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Berkshire Tempest"
	],

	"drop_top_challenge":[
		"Schroder Atrix Q32",
		"Straeda Volant",
		"Kestrel Speedster",
		"Bartoli Cruiser",
		"Berkshire Falcon",
	],

	"under_400_hp":[
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Zenith Touring",
		"Eisenach Monarch",
		"Berkshire Falcon",
		"Kronstadt Regent",
		"Mir Cars Nightwolf",
		"Berkshire Mocha",
		"Schroder Colosso",

		"Straeda Volant",
		"Schroder Atrix Q32",
		"Eisenach Bengal",
		"Zenith Horizon",
		"Mir Cars Goblin",
		"Brutus Viper",
		"Mir Cars Hutch",

		"Strandberg Turbo",
		"Kuro Vault",
		"Schroder Suppressor",

		"Kestrel Seabird",
		"Kestrel Speedster",

		"Berkshire Blunt",

		"Schroder Classique Sport",
		"Brutus Stingray",
		"Berkshire V12-S"
	],

	"low_displacement_challenge":[
		"Straeda Volant",
		"Strandberg Turbo",
		"Schroder Classique Sport",
		"Kestrel Seabird"
	],

	"schroder_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Suppressor",
		"Schroder Classique Sport"
	],

	"gentleman_racers":[
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Zenith Touring",
		"Berkshire Falcon",
		"Kronstadt Predator",
		"Bartoli Cruiser",
		"Berkshire Mocha",
		"Berkshire Tempest",
	],

	"american_thunder":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Colossus Titan Max",
		"Brutus Thunderbolt",
		"Colossus Behemoth",
		"Mir Cars Goblin",
		"Brutus Stingray",
		"Brutus Venom"
	],

	"british_invasion":[
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Berkshire Mocha",
		"Berkshire V12-S",
		"Berkshire Falcon",
		"Berkshire Tempest",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"grand_touring":[
		
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Berkshire Tempest"
	],

	"stingray_competition":[
		"Brutus Stingray"
	],

	"german_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Suppressor",
		"Kronstadt Regent",
		"Kronstadt Predator",
		"Schroder Classique Sport",
		"Eisenach Monarch",
		"Eisenach Bengal",

	],

	"kestrel_max":[
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"v12_engines":[
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Linetti Firestorm",
		"Linetti Terror"
	],
		"england_vs_italy":[
		# ENGLAND

		"Kestrel Seabird",
		"Kestrel Speedster",
		"Kestrel Battleaxe",
		"Kestrel Guillotine",
		"Berkshire Falcon",
		"Berkshire Blunt",
		"Berkshire Mocha",
		"Berkshire V12-S",
		"Berkshire Tempest",

		# ITALY

		"Bartoli Cruiser",
		"Bartoli Track Cruiser",

		"Linetti Shepherd",
		"Linetti Firestorm",
		"Linetti Terror"
	],
	"japan_vs_germany":[
	# JAPAN

	"Zenith Horizon",
	"Zenith Touring",
	"Kronstadt Predator",

	"Kuro Vault",


	"Mir Cars Nightwolf",


	# GERMANY

	"Schroder Atrix Q32",
	"Schroder Colosso",
	"Schroder Suppressor",
	"Schroder Classique Sport",
	"Eisenach Monarch",

	"Eisenach Bengal"
],
}

var cup_rewards: Dictionary = {
	"colossus":"Eisenach Bengal",
	"street_tuners":"Brutus Viper",
	"muscle_hustle":"Schroder Atrix Q32",

	"v6_engines":"Zenith Horizon",
	"zenith_competition":"Brutus Goblin",

	"businessman_racers":"Kuro Vault",

	"japanese_cup":"Kronstadt Regent",
	"diesel_masters":"Schroder Suppressor",

	"all_wheel_grip":"Berkshire Falcon",          # XKR

	"urban_performance_cars":"Kestrel Seabird",  # Exige

	"colin_tribute":"Zenith Touring",           # E55
	
	"japan_vs_germany":"Kestrel Speedster",

	"drop_top_challenge":"Berkshire Blunt",
	
	"british_invasion":"Brutus Stingray",    # Morgan

	"under_400_hp":"Schroder Classique Sport",
	
	"german_cup":"Bartoli Cruiser",
	
	"england_vs_italy":"Berkshire V12-S",

	"gentleman_racers":"Brutus Venom",
	"american_thunder":"Kronstadt Predator",
	"v8_fury":"Kestrel Battleaxe",
	"kestrel_max":"Berkshire Tempest",

	"sport_racing":"Linetti Firestorm",

	"v12_engines":"Linetti Terror",

	"supercars":"Bartoli Track Cruiser",

	"track_cars":"Mir Cars Athletic C70"
}
# ============================================================
#  CHAMPIONSHIPS (ONLY THESE FOUR)
# ============================================================
# ============================================================
#  CAREER PROGRESSION LOGIC
# ============================================================

var career_order: Array = [
	"colossus",

	"street_tuners",
	"muscle_hustle",

	"v6_engines",
	"zenith_competition",

	"businessman_racers",

	"japanese_cup",
	"diesel_masters",

	"all_wheel_grip",          # Morgan reward

	"urban_performance_cars",  # First real Urban championship
	# XKR reward

	"eisenach_cup",

	"low_displacement_challenge",

	"colin_tribute",
	"japan_vs_germany",           # Exige reward
	
	"drop_top_challenge",
	"british_invasion",
	"stingray_competition",

	"under_400_hp",

	"german_cup",
	"schroder_cup",
	"england_vs_italy",
	"gentleman_racers",
	
	"american_thunder",
	
	"v8_fury",

	"kestrel_max",

	"sport_racing",

	"v12_engines",

	"supercars",

	"track_cars"
]

var current_stage: int = 0
var unlocked_cups: Array = ["colossus"]  # starter cup

func get_current_cup() -> String:
	return career_order[current_stage]

func is_cup_unlocked(cup_id: String) -> bool:
	return unlocked_cups.has(cup_id)
func complete_cup(cup_id: String) -> void:
	print("COMPLETE_CUP CALLED:", cup_id)

	if not completed_cups.has(cup_id):
		completed_cups.append(cup_id)

	var idx = career_order.find(cup_id)

	if idx != -1 and idx == current_stage:
		current_stage += 1

		if current_stage < career_order.size():
			var next_cup = career_order[current_stage]

			if not unlocked_cups.has(next_cup):
				unlocked_cups.append(next_cup)

			print("Unlocked next cup:", next_cup)
	if cup_rewards.has(cup_id):
		var reward_car: String = cup_rewards[cup_id]

		Cars.unlock_car(reward_car, "championship")
		print("Unlocked reward car:", reward_car)
	if cash_rewards.has(cup_id):
		var reward_cash: int = cash_rewards[cup_id]

		Cars.add_money(reward_cash)
		print("Awarded cash:", reward_cash)
	print("ACTIVE CUP:", ChampionshipState.active_cup)
	save_progress()
var cups: Dictionary = {

	"colossus": {
		"eligible_classes": ["suv"]
	},

	"street_tuners": {
		"eligible_classes": ["compact"]
	},

	"muscle_hustle": {
		"eligible_classes": ["muscle"]
	},

	"v6_engines": {
		"eligible_classes": ["v6_engines"]
	},

	"zenith_competition": {
		"eligible_classes": ["zenith_competition"]
	},

	"businessman_racers": {
		"eligible_classes": ["businessman_racers"]
	},

	"japanese_cup": {
		"eligible_classes": ["japanese_cup"]
	},

	"diesel_masters": {
		"eligible_classes": ["diesel_masters"]
	},

	"all_wheel_grip": {
		"eligible_classes": ["all_wheel_grip"]
	},

	"speedster_tournament": {
		"eligible_classes": ["speedster_tournament"]
	},

	"urban_performance_cars": {
		"eligible_classes": ["urban_performance_cars"]
	},

	"low_displacement_challenge": {
		"eligible_classes": ["low_displacement_challenge"]
	},

	"eisenach_cup": {
		"eligible_classes": ["eisenach_cup"]
	},
	"japan_vs_germany":{
		"eligible_classes":["japan_vs_germany"]
	},

	"berkshire_cup": {
		"eligible_classes": ["berkshire_cup"]
	},

	"drop_top_challenge": {
		"eligible_classes": ["drop_top_challenge"]
	},
	"colin_tribute": {
		"eligible_classes": ["colin_tribute"]
	},
	"england_vs_italy":{
		"eligible_classes":["england_vs_italy"]
	},

	"under_400_hp": {
		"eligible_classes": ["under_400_hp"]
	},

	"german_cup": {
		"eligible_classes": ["german_cup"]
	},

	"schroder_cup": {
		"eligible_classes": ["schroder_cup"]
	},

	"american_thunder": {
		"eligible_classes": ["american_thunder"]
	},

	"british_invasion": {
		"eligible_classes": ["british_invasion"]
	},

	"stingray_competition": {
		"eligible_classes": ["stingray_competition"]
	},

	"v8_fury": {
		"eligible_classes": ["v8_fury"]
	},

	"gentleman_racers": {
		"eligible_classes": ["gentleman_racers"]
	},

	"kestrel_max": {
		"eligible_classes": ["kestrel_max"]
	},

	"sport_racing": {
		"eligible_classes": ["sport_racing"]
	},

	"v12_engines": {
		"eligible_classes": ["v12_engines"]
	},

	"supercars": {
		"eligible_classes": ["supercars"]
	},

	"track_cars": {
		"eligible_classes": ["track_cars"]
	}
}

# ============================================================
#  MAIN FILTER FUNCTION (MENU + AI)
# ============================================================
func _ready():
	load_progress()
	get_shuffled_under_400_hp()
		
func get_available_cars(cup_id: String) -> Array[String]:

	var cup: Dictionary = cups[cup_id]

	var result: Array[String] = []

	for class_id in cup["eligible_classes"]:

		if class_lists.has(class_id):

			for car_name in class_lists[class_id]:

				if not result.has(car_name):
					result.append(car_name)

	return result
	
var save_path := "user://career_progress.json"
var career_progress: Dictionary = {}  # cup_id -> { "normal":false, "duel":false, "elimination":false, "radar":false }

func save_progress():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify({
	"current_stage": current_stage,
	"unlocked_cups": unlocked_cups,
	"completed_cups": completed_cups,
	"career_progress": career_progress
}))
		file.close()
		print("Career progress saved")

func load_progress():
	if not FileAccess.file_exists(save_path):
		print("No career save found, starting fresh")
		return

	var file = FileAccess.open(save_path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var data = JSON.parse_string(text)
		if typeof(data) == TYPE_DICTIONARY:
			current_stage = data.get("current_stage", 0)
			unlocked_cups = data.get("unlocked_cups", ["colossus"])
			career_progress = data.get("career_progress", {})
			completed_cups = data.get("completed_cups", [])
			print("Career progress loaded")
		file.close()
	
func get_shuffled_under_400_hp() -> Array:
	var cars: Array = class_lists["under_400_hp"].duplicate()
	cars.shuffle()
	return cars
func is_cup_completed(cup_id: String) -> bool:
	return completed_cups.has(cup_id)
func debug_reset_career():
	current_stage = 0
	unlocked_cups = ["colossus"]
	completed_cups = []
	career_progress.clear()

	save_progress()

	print("DEBUG: Career reset")
func debug_unlock_next_cup():
	if current_stage >= career_order.size() - 1:
		print("DEBUG: Already at final cup")
		return

	current_stage += 1

	var next_cup = career_order[current_stage]

	if not unlocked_cups.has(next_cup):
		unlocked_cups.append(next_cup)

	save_progress()

	print("DEBUG: Unlocked ", next_cup)
func debug_complete_current_cup():
	if current_stage >= career_order.size():
		return

	var cup_id = career_order[current_stage]

	print("DEBUG: Completing ", cup_id)

	complete_cup(cup_id)
func debug_unlock_all_cups():
	unlocked_cups.clear()

	for cup_id in career_order:
		unlocked_cups.append(cup_id)

	current_stage = career_order.size() - 1

	save_progress()

	print("DEBUG: All cups unlocked")
func get_cup_details_text(cup_id: String) -> String:
	var text := ""

	text += "Reward Car: "
	text += cup_rewards.get(cup_id, "None")
	text += "\n"

	text += "Cash Reward: $"
	text += str(cash_rewards.get(cup_id, 0))
	text += "\n\n"

	text += "Eligible Cars:\n"

	for car in get_available_cars(cup_id):
		text += "• " + car + "\n"

	return text
func debug_complete_career():
	while current_stage < career_order.size():
		debug_complete_current_cup()

	save_progress()

	print("DEBUG: Career completed")
