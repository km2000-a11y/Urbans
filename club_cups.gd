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
		"Kronstadt Fortress",
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

# ============================================================
#  CHAMPIONSHIPS (ONLY THESE FOUR)
# ============================================================

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
