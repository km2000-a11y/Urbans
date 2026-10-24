extends Node

# ============================================================
#  FULL CLASS LIST (LOCAL — SELF-CONTAINED)
# ============================================================
var completed_cups: Array = []
var cash_rewards: Dictionary = {
	"colossus": 5000,
	"street_tuners": 10000,
	"muscle_hustle": 12000,

	"v6_engines": 15000,
	"zenith_competition": 18000,

	"businessman_racers": 22000,
	"japanese_cup": 25000,
	"diesel_masters": 28000,

	"all_wheel_grip": 32000,
	"urban_performance_cars": 35000,

	"eisenach_cup": 38000,
	"colin_tribute": 35000,
	"drop_top_challenge": 40000,

	"low_displacement_challenge": 45000,
	"under_400_hp": 50000,

	"german_cup": 55000,
	"schroder_cup": 65000,

	"speedster_tournament": 70000,

	"berkshire_cup": 75000,

	"american_thunder": 80000,
	"british_invasion": 85000,

	"stingray_competition": 90000,
	"v8_fury": 100000,

	"gentleman_racers": 110000,

	"kestrel_max": 125000,

	"sport_racing": 150000,

	"v12_engines": 175000,

	"supercars": 225000,

	"track_cars": 300000
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

	"muscle": [
		"Brutus Viper",
		"Mir Cars Hutch"
	],

	"sedans": [
		"Strandberg Turbo",
		"Kuro Vault",
		"Zenith Prince",
		"Brutus Goblin",
		"Schroder Suppressor"
	],

	"urban": [
		"Kuro Serenity",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Mir Cars Blazer"
	],

	"sport": [
		"Schroder Classique Sport",
		"Berkshire V12-S",
		"Brutus Stingray",
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
		"Zenith Horizon"
	],

	"zenith_competition":[
		"Zenith Horizon",
		"Zenith Prince"
	],

	"businessman_racers":[
		"Strandberg Turbo",
		"Kuro Vault",
		"Zenith Prince",
		"Brutus Goblin",
		"Schroder Suppressor"
	],

	"japanese_cup":[
		"Zenith Horizon",
		"Kuro Serenity",
		"Zenith Prince",
		"Kuro Vault"
	],

	"diesel_masters":[
		"Schroder Colosso",
		"Schroder Suppressor"
	],

	"all_wheel_grip":[
		"Schroder Atrix Q32",
		"Strandberg Turbo",
		"Brutus Goblin",
		"Schroder Classique Sport"<
		"Schroder Suppressor",
		"Schroder Colosso"
	],
	"colin_tribute":[
		"Kestrel Seabird"
	],

	"speedster_tournament":[
		"Kestrel Speedster"
	],

	"urban_performance_cars":[
		"Kuro Serenity",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Mir Cars Blazer"
	],

	"eisenach_cup":[
		"Eisenach Bengal"
	],

	"v8_fury":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Kuro Vault",
		"Bartoli Cruiser",
		"Kuro Serenity",
		"Mir Cars Blazer",
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
		"Kestrel Speedster",
		"Berkshire Blunt"
	],

	"under_400_hp":[
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Mir Cars Nightwolf",
		"Schroder Colosso",

		"Straeda Volant",
		"Schroder Atrix Q32",
		"Eisenach Bengal",
		"Zenith Horizon",
		"Brutus Goblin",
		"Brutus Viper",
		"Mir Cars Hutch",

		"Strandberg Turbo",
		"Kuro Vault",
		"Zenith Prince",
		"Schroder Suppressor",

		"Kuro Serenity",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Mir Cars Blazer",
		"Berkshire Blunt",

		"Schroder Classique Sport",
		"Brutus Stingray",
		"Berkshire V12-S"
	],

	"low_displacement_challenge":[
		"Straeda Volant",
		"Brutus Goblin",
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
		"Kuro Serenity",
		"Kestrel Speedster",
		"Mir Cars Blazer",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Bartoli Cruiser",
		"Berkshire Tempest",
		"Schroder Classique Sport"
	],

	"american_thunder":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Colossus Titan Max",
		"Brutus Thunderbolt",
		"Colossus Behemoth",
		"Brutus Goblin",
		"Brutus Stingray",
		"Brutus Venom"
	],

	"british_invasion":[
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"grand_touring":[
		"Kuro Serenity",
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
		"Schroder Classique Sport",
		"Eisenach Bengal",
		"Mir Cars Blazer"
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
	]
}
var cup_rewards: Dictionary = {
	"colossus": "Eisenach Bengal",             # 130i

	"muscle_hustle": "Schroder Atrix Q32",     # TT

	"businessman_racers": "Kuro Vault",        # LS430

	"all_wheel_grip": "Strandberg Turbo",      # V70R

	"speedster_tournament": "Kestrel Speedster", # Morgan

	"eisenach_cup": "Berkshire Blunt",         # XKR

	"colin_tribute": "Kestrel Seabird",        # Exige

	"drop_top_challenge": "Bartoli Cruiser",   # GranCabrio

	"schroder_cup": "Schroder Classique Sport", # Audi S2

	"gentleman_racers": "Berkshire V12-S",     # DB7

	"american_thunder": "Brutus Venom",        # Viper RT10

	"british_invasion": "Berkshire Tempest",   # Vanquish

	"v8_fury": "Brutus Stingray",              # Corvette C6

	"stingray_competition":"Kestrel Battleaxe", # Gallardo

	"kestrel_max": "Linetti Shepherd",        # TVR Sagaris

	"sport_racing": "Linetti Firestorm",      # TVR T440R

	"v12_engines": "Linetti Terror",        # Diablo Roadster

	"supercars": "Bartoli Track Cruiser",      # MC12

	"track_cars": "Mir Cars Athletic C70"      # Zonda
}
# ============================================================
#  CHAMPIONSHIPS (ONLY THESE FOUR)
# ============================================================
# ============================================================
#  CAREER PROGRESSION LOGIC
# ============================================================
var career_order: Array = [
	"colossus",                 # SUVs

	"street_tuners",            # Compacts
	"muscle_hustle",            # Muscle

	"v6_engines",
	"zenith_competition",

	"businessman_racers",       # Executive introduction

	"japanese_cup",
	"diesel_masters",

	"all_wheel_grip",
	
	"speedster_tournament",

	"eisenach_cup",

	"low_displacement_challenge",

	"colin_tribute",            # Lotus Exige reward route

	"urban_performance_cars",

	"drop_top_challenge",

	"under_400_hp",

	"german_cup",
	"schroder_cup",

	"gentleman_racers",

	"american_thunder",
	"british_invasion",

	"v8_fury",
	
	
	"stingray_competition",

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

	"berkshire_cup": {
		"eligible_classes": ["berkshire_cup"]
	},

	"drop_top_challenge": {
		"eligible_classes": ["drop_top_challenge"]
	},
	"colin_tribute": {
		"eligible_classes": ["colin_tribute"]
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
