extends Node

# ============================================================
#  FULL CLASS LIST (LOCAL — SELF-CONTAINED)
# ============================================================


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
		"Straeda B32",
		"Kuro Zephyr",
		"Schroder D-20"
	],

	"muscle": [
		"Mir Cars Hutch",
		"Brutus Viper"
	],

	"urban": [
		"Berkshire Blunt",
		"Eisenach Prince",
		"Kestrel Speedster",
		"Eisenach Bengal",
		"Kronstadt Essence",
				"Strandberg Turbo",
		"Kuro Serenity"
	],

	"sedans": [
		"Eisenach Suppressor",
		"Kuro Vault",
		"Mir Cars Transporter",
		"Kronstadt Fortress",
		"Kuro Persian"
	],

	"sport": [
				"Brutus Stingray",
		"Berkshire V12-S",
		"Eisenach Goblin",
		"Berkshire Tempest",
		"Schroder Classique Sport",
		"Kestrel Touring"
	],

	"sport_racing": [
		"Schroder Atrocity",
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
		"Kuro Persian",
		"Kuro Vault",
		"Eisenach Suppressor",
		"Kronstadt Fortress",
		"Mir Cars Transporter"
	],
	"speedster_tournament":[
		"Kestrel Speedster"
	],
	"kuro_cup":[
		"Kuro Zephyr",
		"Kuro Vault",
		"Kuro Persian",
		"Kuro Serenity"
	],
	"all_wheel_grip":[
		"Strandberg Turbo",
		"Mir Cars Transporter",
		"Schroder Classique Sport",
		"Schroder Atrix Q32",
		"Straeda B32"
	],
	"eisenach_cup":[
		"Eisenach Suppressor",
		"Eisenach Bengal",
		"Eisenach Goblin",
		"Eisenach Prince"
	],
	"under_400_hp":[
		"Schroder Colosso",
		"Colossus Behemoth",
		"Mir Cars Nightwolf",
		"Eisenach Goblin",
		"Colossus Titan Max",
				"Zenith Horizon",
		"Schroder Atrix Q32",
		"Straeda B32",
		"Kuro Zephyr",
		"Schroder D-20",
				"Mir Cars Hutch",
		"Brutus Viper",
				"Eisenach Suppressor",
		"Kuro Vault",
		"Mir Cars Transporter",
				"Kronstadt Fortress",
		"Kronstadt Essence",
		"Eisenach Goblin",
		"Strandberg Turbo",
		"Kuro Persian",
				"Kestrel Touring",
							"Berkshire Blunt",
		"Eisenach Prince",
		"Kestrel Speedster",
		"Eisenach Bengal",
		"Kuro Serenity"	
	],
	"stingray_competition":[
		"Brutus Stingray"
	],
	"schroder_cup":[
		"Schroder D-20",
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		"Schroder Atrocity"
	],
	"gentleman_racers":[
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Kronstadt Essence",
		"Berkshire Tempest",
		"Kestrel Speedster"
	],
		"japanese_cup":[
		"Zenith Horizon",
		"Kuro Zephyr",
		"Kuro Persian",
		"Kuro Serenity",
		"Kuro Vault"
	],
		"german_cup":[
		"Schroder D-20",
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		"Schroder Atrocity",
				"Eisenach Suppressor",
		"Eisenach Goblin",
		"Eisenach Bengal",
				"Kronstadt Fortress",
		"Kronstadt Essence",
		"Eisenach Prince",
		"Straeda B32"
	],
		"kestrel_max":[
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],
		"v12_engines":[
		"Kronstadt Fortress",
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Linetti Firestorm",
		"Linetti Terror"
	]
}
var cup_rewards: Dictionary = {
	"colossus": "Kuro Zephyr",                # Lexus IS250
	"street_tuners": "Brutus Viper",          # Shelby GT500
	"muscle_hustle": "Schroder Atrix Q32",    # Audi TT Roadster
	"v6_engines": "Zenith Horizon",           # Nissan 350Z
	"zenith_competition": "Mir Cars Transporter", # Audi S8
	"businessman_racers": "Kuro Serenity",    # Lexus SC400
	"japanese_cup": "Strandberg Turbo",       # Volvo S60R
	"all_wheel_grip": "Kestrel Speedster",    # Morgan Aero 8
	"speedster_tournament": "Eisenach Goblin",# BMW 1M Coupe
	"eisenach_cup": "Schroder Classique Sport", # Audi S4 Cabriolet
	"schroder_cup": "Berkshire Blunt",        # Jaguar XKR
	"under_400_hp": "Brutus Stingray",        # Corvette C6
	"stingray_competition": "Berkshire V12-S",# Aston Martin DB9
	"gentleman_racers": "Kestrel Touring",    # TVR Cerbera
	"kestrel_max": "Linetti Shepherd",        # Lamborghini Gallardo
	"sport_racing": "Linetti Firestorm",      # Lamborghini Diablo Roadster
	"v12_engines": "Mir Cars Raptor",         # Saleen S7
	"supercars": "Bartoli Track Cruiser",     # Maserati MC12
	"track_cars": "Mir Cars Athletic C70"     # Pagani Zonda
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
	"all_wheel_grip",
	"speedster_tournament",
	"eisenach_cup",
	"under_400_hp",
	"stingray_competition",
	"schroder_cup",
	"gentleman_racers",
	"kestrel_max",
	"german_cup",
	"sport_racing",   # ⭐ NEW
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
	var idx = career_order.find(cup_id)
	if idx != -1 and idx == current_stage:
		current_stage += 1
		if current_stage < career_order.size():
			var next_cup = career_order[current_stage]
			unlocked_cups.append(next_cup)
			print("Unlocked next cup: ", next_cup)
		else:
			print("Career completed!")

	# Unlock reward car
	if cup_rewards.has(cup_id):
		var reward_car = cup_rewards[cup_id]
		Cars.unlock_car(reward_car, cup_id)
		print("Unlocked car:", reward_car, "from cup:", cup_id)

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
			"Schroder D-20",
			"Zenith Horizon",
			"Kuro Zephyr",
			"Straeda B32"
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
"zenith_competition":{
	"eligible_classes":["zenith_competition"],
	"eligible_cars":[
		"Zenith Horizon"
	]
},
"businessman_racers":{
	"eligible_classes":["businessman_racers"],
	"eligible_cars":[
		"Kuro Persian",
		"Kuro Vault",
		"Eisenach Suppressor",
		"Mir Cars Transporter"
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
		"Kuro Persian",
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
		"Straeda B32"
	]
},
"eisenach_cup":{
	"eligible_classes":["eisenach_cup"],
	"eligible_cars":[
		"Eisenach Suppressor",
		"Eisenach Bengal",
		"Eisenach Prince"
	]
},
"under_400_hp":{
	"eligible_classes":["under_400_hp"],
	"eligible_cars":[
				"Schroder Colosso",
		"Colossus Behemoth",
		"Mir Cars Nightwolf",
		"Colossus Titan Max",
				"Zenith Horizon",
						"Eisenach Goblin",
		"Schroder Atrix Q32",
		"Straeda B32",
		"Kuro Zephyr",
		"Schroder D-20",
				"Mir Cars Hutch",
		"Brutus Viper",
				"Eisenach Suppressor",
						"Kronstadt Fortress",
		"Kronstadt Essence",
		"Kuro Vault",
		"Mir Cars Transporter",
		"Strandberg Turbo",
		"Kuro Persian",
				"Kestrel Touring",
							"Berkshire Blunt",
		"Eisenach Prince",
		"Kestrel Speedster",
		"Eisenach Bengal",
		"Kuro Serenity"	
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
				"Schroder D-20",
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		"Schroder Atrocity"
	]
},
"gentleman_racers":{
	"eligible_classes":["gentleman_racers"],
	"eligible_cars":[
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Kestrel Speedster"
	]
},
"japanese_cup":{
	"eligible_classes":["japanese_cup"],
	"eligible_cars":[
			"Zenith Horizon",
		"Kuro Zephyr",
		"Kuro Persian",
		"Kuro Serenity",
		"Kuro Vault"
	]
},
"german_cup":{
	"eligible_classes":["german_cup"],
	"eligible_cars":[
				"Schroder D-20",
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Classique Sport",
		"Schroder Atrocity",
				"Eisenach Suppressor",
						"Kronstadt Fortress",
		"Kronstadt Essence",
		"Eisenach Goblin",
		"Eisenach Bengal",
		"Eisenach Prince",
		"Straeda B32"
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
			"Kronstadt Fortress",
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Linetti Firestorm",
		"Linetti Terror"
	]
},
"sport_racing": {
	"eligible_classes": ["sport_racing"],
	"eligible_cars": [
		"Schroder Atrocity",
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
			print("Career progress loaded")
		file.close()
