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
	"businessman_racers": 20000,
	"japanese_cup": 22000,
	"speedster_tournament":36000,
	"urban_performance_cars":35000,
	"eisenach_cup": 30000,
	"v8_fury":37000,
	"berkshire_cup": 35000,
	"drop_top_challenge":20000,
	"under_400_hp": 40000,
	"schroder_cup": 45000,
	"gentleman_racers": 55000,
	"kestrel_max": 60000,
	"diesel_masters": 65000,
	"american_thunder": 70000,
	"british_invasion": 75000,
	"grand_touring": 80000,
	"sport_racing": 85000,
	"v12_engines": 90000,
	"supercars": 100000,
	"track_cars": 120000
}

var class_lists: Dictionary = {
	"suv": [
		"Schroder Colosso",
		"Colossus Behemoth",
		"Mir Cars Nightwolf",
		"Colossus Titan Max"
	],

	"compact": [
		"Zenith Horizon",
		"Schroder Atrix Q32",
		"Kuro Zephyr",
		"Eisenach Bengal",
	],

	"muscle": [
		"Mir Cars Hutch",
		"Brutus Viper"
	],

	"urban": [
		"Kestrel Seabird",
			"Kestrel Speedster",
			"Kronstadt Blazer",
			"Berkshire Blunt",
				
		"Kuro Serenity"
	],

	"sedans": [
	"Schroder Suppressor",
	"Kuro Vault",
	"Strandberg Turbo",
	"Brutus Prince"
],

	"sport": [
		"Berkshire V12-S",
		"Brutus Stingray",
		"Schroder Classique Sport",
		"Kestrel Touring"
	],

	"sport_racing": [
		"Kronstadt Beast",
		"Linetti Shepherd",
		"Brutus Venom",
		"Kestrel Battleaxe"
	],

	"supercars": [
		"Linetti Terror",
		"Linetti Firestorm",
		"Kestrel Guillotine",
		"Mir Cars Raptor"
	],

	"track_cars": [
		"Mir Cars Athletic C70",
		"Bartoli Track Cruiser",
		"Brutus Thunderbolt"
	],

	"special": [
		"Bartoli Cruiser Interceptor"
	],
	"v6_engines":[
		"Schroder Atrix Q32",
		"Zenith Horizon"
	],
	"zenith_competition":[
		"Zenith Horizon"
	],
	"businessman_racers":[
	"Kuro Vault",
	"Schroder Suppressor",
	"Strandberg Turbo",
	"Brutus Prince",
],
	"speedster_tournament":[
		"Kestrel Speedster"
	],
	"kuro_cup":[
		"Kuro Zephyr",
		"Kuro Vault",
		"Kuro Serenity"
	],
	"all_wheel_grip":[
		"Strandberg Turbo",
		"Mir Cars Transporter",
		"Schroder Classique Sport",
		"Schroder Atrix Q32",
	],
	"eisenach_cup":[
		"Eisenach Bengal",
	],
	"under_400_hp": [
	"Mir Cars Hutch",
	"Brutus Prince",
	"Schroder Atrix Q32",
	"Colossus Titan Max",
	"Kestrel Touring",
	"Berkshire Blunt",
	"Kestrel Speedster",
	"Brutus Stingray",
	"Zenith Horizon",
	"Kuro Serenity",
	"Brutus Viper",
	"Kuro Vault",
	"Kronstadt Blazer",
	"Strandberg Turbo",
	"Schroder Colosso",
	"Mir Cars Transporter",
	"Schroder Suppressor",
	"Straeda Volant",
	"Kestrel Seabird",
	"Colossus Behemoth",
	"Schroder Classique Sport",
	"Eisenach Bengal",
	"Mir Cars Nightwolf",
	"Kuro Zephyr"
],
"v8_fury":[
	"Mir Cars Hutch",
	"Brutus Viper",
	"Kuro Vault",
	"Kuro Serenity",
	"Brutus Stingray",
	"Berkshire Blunt",
	"Brutus Prince",
	"Kestrel Touring",
],
"drop_top_challenge":[
	"Schroder Atrix Q32",
	"Kestrel Speedster",
	"Berkshire Blunt",
],
"berkshire_cup":[
	"Berkshire Blunt",
	"Berkshire Tempest",
	"Berkshire V12-S"
],
	"diesel_masters": [
		"Schroder Suppressor",
		"Schroder Colosso"
	],

	"american_thunder": [
		"Mir Cars Hutch",
		"Brutus Viper",
		"Brutus Prince",
		"Brutus Stingray",
		"Brutus Venom"
	],

	"british_invasion": [
		"Kestrel Seabird",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"grand_touring": [
		"Kuro Serenity",
		"Berkshire Blunt",
		"Berkshire V12-S"
	],
	"stingray_competition":[
		"Brutus Stingray"
	],
	"schroder_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		
	],
	"low_displacement_challenge":[
		"Kestrel Seabird",
		"Kuro Zephyr",
		"Schroder Classique Sport",
		"Straeda Volant",
		"Strandberg Turbo"
		
	],
	"gentleman_racers":[
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Kronstadt Blazer",
		"Brutus Prince",
				"Berkshire Tempest",
	],
		"japanese_cup":[
		"Zenith Horizon",
		"Kuro Zephyr",
		"Kuro Serenity",

		"Kuro Vault"
	],
		"german_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		"Kronstadt Blazer",

				"Schroder Suppressor",
		"Eisenach Bengal",


	],
	"urban_performance_cars":[
		"Kuro Serenity",
		"Berkshire Blunt",
		"Kronstadt Blazer",
		"Kestrel Seabird",
		"Kestrel Speedster",
	],
		"kestrel_max":[
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],
		"v12_engines":[
		"Berkshire V12-S",
		"Linetti Firestorm",
		"Linetti Terror"
	]
}
var cup_rewards: Dictionary = {
	"colossus": "Kuro Zephyr",
	"street_tuners": "Brutus Viper",
	"muscle_hustle": "Schroder Atrix Q32",
	"v6_engines": "Zenith Horizon",
	"zenith_competition": "Brutus Prince",
	"businessman_racers": "Kuro Serenity",
	"japanese_cup": "Strandberg Turbo",
	"all_wheel_grip": "Kestrel Speedster",
	"eisenach_cup": "Berkshire Blunt",
	"drop_top_challenge":"Kronstadt Blazer",
	"under_400_hp": "Schroder Classique Sport",
	"schroder_cup": "Brutus Stingray",
	"stingray_competition": "Berkshire V12-S",
	"gentleman_racers": "Kestrel Touring",
	"kestrel_max": "Linetti Shepherd",
	"sport_racing": "Linetti Firestorm",
	"v12_engines": "Linetti Terror",
	"supercars": "Bartoli Track Cruiser",
	"track_cars": "Mir Cars Athletic C70"
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
	"all_wheel_grip",
	"speedster_tournament",
	"urban_performance_cars",
	"low_displacement_challenge",
	"eisenach_cup",
	"berkshire_cup",
	"drop_top_challenge",
	"under_400_hp",
	"german_cup",
	"schroder_cup",
	"american_thunder",
	"british_invasion",
	"stingray_competition",
	"v8_fury",
	"gentleman_racers",
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
		"eligible_classes": ["suv"],
		"eligible_cars": [
			"Schroder Colosso",
			"Colossus Behemoth",
			"Mir Cars Nightwolf",
			"Colossus Titan Max"
		]
	},

	"street_tuners": {
		"eligible_classes": ["compact"],
		"eligible_cars": [
			"Schroder Atrix Q32",
			"Straeda Volant",
			"Zenith Horizon",
			"Kuro Zephyr",
			"Eisenach Bengal",
		]
	},

	"muscle_hustle": {
		"eligible_classes": ["muscle"],
		"eligible_cars": [
			"Brutus Viper",
			"Mir Cars Hutch"
		]
	},

"v6_engines": {
	"eligible_classes": ["v6_engines"],
	"eligible_cars": [
		"Zenith Horizon",
		"Schroder Atrix Q32"
	]
},
"urban_performance_cars": {
	"eligible_classes": ["urban"],
	"eligible_cars": [
		"Kestrel Seabird",
			"Kestrel Speedster",
			"Berkshire Blunt",
				"Kronstadt Blazer",
		"Kuro Serenity"
	]
},
"diesel_masters": {
	"eligible_classes": ["diesel_masters"],
	"eligible_cars": [

		"Schroder Suppressor",
		"Schroder Colosso"
	]
},
"low_displacement_challenge": {
	"eligible_classes": ["low_displacement_challenge"],
	"eligible_cars": [
"Kestrel Seabird",
		"Kuro Zephyr",
		"Schroder Classique Sport",
		"Straeda Volant",
		"Strandberg Turbo"
	]
},
"american_thunder": {
	"eligible_classes": ["american_thunder"],
	"eligible_cars": [
		"Mir Cars Hutch",
		"Brutus Viper",
		"Brutus Prince",
		"Brutus Stingray",
		"Brutus Venom"
	]
},

"british_invasion": {
	"eligible_classes": ["british_invasion"],
	"eligible_cars": [
		"Kestrel Seabird",
		"Berkshire Blunt",
		"Kestrel Speedster",
		"Berkshire V12-S",
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	]
},
"v8_fury": {
	"eligible_classes": ["v8_fury"],
	"eligible_cars": [
	"Mir Cars Hutch",
	"Brutus Viper",
	"Kuro Vault",
	"Kuro Serenity",
	"Brutus Stingray",
	"Berkshire Blunt",
	"Brutus Prince",
	"Kestrel Touring",

	]
},
"drop_top_challenge": {
	"eligible_classes": ["drop_top_challenge"],
	"eligible_cars": [
		"Schroder Atrix Q32",
	"Kestrel Speedster",
	"Berkshire Blunt",
	""
	]
},

"grand_touring": {
	"eligible_classes": ["grand_touring"],
	"eligible_cars": [
		"Kuro Serenity",
		"Berkshire Blunt",
		"Berkshire Tempest",
		
		"Berkshire V12-S"
	]
},
"zenith_competition":{
	"eligible_classes":["zenith_competition"],
	"eligible_cars":[
		"Zenith Horizon",
		
	]
},
"businessman_racers":{
	"eligible_classes":["businessman_racers"],
	"eligible_cars":[
		"Brutus Prince",
		"Kuro Vault",
		"Schroder Suppressor",
		"Strandberg Turbo"
	]
},
"speedster_tournament":{
	"eligible_classes":["speedster_tournament"],
	"eligible_cars":[
		"Kestrel Speedster"
	]
},
"kuro_cup":{
	"eligible_classes":["kuro_cup"],
	"eligible_cars":[
		"Kuro Zephyr",
		"Kuro Vault",
		"Kuro Serenity"
	]
},
"all_wheel_grip":{
	"eligible_classes":["all_wheel_grip"],
	"eligible_cars":[
		"Strandberg Turbo",
		"Mir Cars Transporter",
		"Schroder Classique Sport",
		"Schroder Atrix Q32",
	]
},
"eisenach_cup":{
	"eligible_classes":["eisenach_cup"],
	"eligible_cars":[

		"Eisenach Bengal",
	]
},
"berkshire_cup":{
	"eligible_classes":["berkshire_cup"],
	"eligible_cars":[
	
		"Berkshire Tempest",
		"Berkshire Blunt",
		"Berkshire V12-S"
	]
},
"under_400_hp":{
	"eligible_classes":["under_400_hp"],
	"eligible_cars":[
	"Mir Cars Hutch",
	"Kestrel Speedster",
	"Schroder Atrix Q32",
	"Berkshire Mocha",
	"Colossus Titan Max",
	"Kestrel Touring",
	"Berkshire Blunt",
	"Zenith Horizon",
	"Kuro Serenity",
	"Brutus Viper",
	"Kuro Vault",
	"Schroder Classique Sport",
	"Strandberg Turbo",
	"Schroder Colosso",
	"Brutus Stingray",
	"Mir Cars Transporter",
	"Straeda Volant",
	"Schroder Suppressor",
	"Brutus Prince",
	"Kronstadt Blazer",
	"Kestrel Seabird",
	"Colossus Behemoth",
	"Eisenach Bengal",
	"Mir Cars Nightwolf",
	"Kuro Zephyr"
	]
},
"stingray_competition":{
	"eligible_classes":["stingray_competition"],
	"eligible_cars":[
		"Brutus Stingray"
	]
},
"schroder_cup":{
	"eligible_classes":["schroder_cup"],
	"eligible_cars":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
	]
},
"gentleman_racers":{
	"eligible_classes":["gentleman_racers"],
	"eligible_cars":[
		"Berkshire Blunt",
		"Berkshire Tempest",
		"Berkshire V12-S",
		"Kestrel Speedster",
		"Kronstadt Blazer",
	]
},
"japanese_cup":{
	"eligible_classes":["japanese_cup"],
	"eligible_cars":[
			"Zenith Horizon",
		"Kuro Zephyr",
		"Kuro Serenity",
		"Kuro Vault"
	]
},
"german_cup":{
	"eligible_classes":["german_cup"],
	"eligible_cars":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
	
				"Schroder Suppressor",
		"Kronstadt Blazer",
		"Eisenach Bengal",

	]
},
"kestrel_max":{
	"eligible_classes":["kestrel_max"],
	"eligible_cars":[
				"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	]
},
"v12_engines":{
	"eligible_classes":["v12_engines"],
	"eligible_cars":[
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Linetti Firestorm",
		"Linetti Terror"
	]
},
"sport_racing": {
	"eligible_classes": ["sport_racing"],
	"eligible_cars": [
		"Berkshire Tempest",
		"Linetti Shepherd",
		"Brutus Venom",
		"Kestrel Battleaxe"
	]
},

"supercars":{
	"eligible_classess":["supercars"],
	"eligible_cars":[
				"Linetti Terror",
		"Linetti Firestorm",
		"Kestrel Guillotine",
		"Mir Cars Raptor"
	]
},
"track_cars":{
	"eligible_classes":["track_cars"],
	"eligible_cars":[
		"Mir Cars Athletic C70",
		"Bartoli Track Cruiser",
		"Brutus Thunderbolt"
	]
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

	var eligible_classes: Array = cup["eligible_classes"]
	var eligible_cars: Array = cup["eligible_cars"]

	var result: Array[String] = []

	for class_id: String in eligible_classes:
		var cars_in_class: Array = class_lists.get(class_id, [])

		for car_name: String in cars_in_class:
			if eligible_cars.has(car_name):
				result.append(car_name)
				print("MATCH: ",car_name)

				

	print("ClubCups.gd USED")
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
