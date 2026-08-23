extends Node

var selected_car: String = ""          # scene path
var selected_car_name: String = ""     # car name string

var selected_ai_car: String = ""       # scene path
var selected_ai_car_name: String = ""  # car name string

var selected_color: Color = Color.WHITE
var selected_class: String = ""
var all_cars: Array = []
var manual_class_clear := false


var class_lists := {
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
	"track_cars": [
	"Mir Cars Athletic C70",
	"Bartoli Track Cruiser",
	"Brutus Thunderbolt"
],


	"muscle": [
		"Mir Cars Hutch",
		"Brutus Viper"
	],

	"urban": [
					"Berkshire Blunt",
		"Eisenach Prince",
		"Kestrel Speedster",
			"Strandberg Turbo",
				"Kronstadt Essence",
		"Eisenach Bengal",
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
			"Eisenach Goblin",
		"Berkshire V12-S",
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
	"special": [
		"Bartoli Cruiser Interceptor"
	],
	"v6_engines": [
	"Zenith Horizon",
	"Schroder Atrix Q32"
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
		"Eisenach Goblin",
		"Eisenach Bengal",
		"Eisenach Prince"
	],
		"under_400_hp":[
		"Schroder Colosso",
		"Colossus Behemoth",
		"Mir Cars Nightwolf",
		"Kronstadt Fortress",
		"Colossus Titan Max",
				"Kronstadt Essence",
				"Zenith Horizon",
		"Schroder Atrix Q32",
		"Straeda B32",
		"Kuro Zephyr",
		"Schroder D-20",
				"Mir Cars Hutch",
		"Brutus Viper",
		"Eisenach Goblin",
				"Eisenach Suppressor",
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
				"Kronstadt Essence",
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


var car_scene_paths := {
	"Colossus Titan Max":"res://Scenes/hummer_h1.tscn",
	"Colossus Behemoth":"res://Scenes/hummer_h2.tscn",
	"Mir Cars Nightwolf":"res://Scenes/lexus_lx470.tscn",
	"Straeda Pitbull":"res://Scenes/vw_touareg_v10.tscn",
	"Schroder Colosso":"res://Scenes/audi_q7.tscn",

	"Schroder Atrix Q32":"res://Scenes/audi_tt.tscn",
	"Straeda B32":"res://Scenes/new_beetle.tscn",
	"Zenith Horizon":"res://Scenes/nissan_350z.tscn",
	"Kuro Zephyr":"res://Scenes/lexus_is250.tscn",

	"Kestrel Seabird":"res://Scenes/lotus_exige_s.tscn",
	"Kestrel Speedster":"res://Scenes/morgan_aero_8.tscn",
	"Berkshire Blunt":"res://Scenes/jaguar_xkr.tscn",
	"Brutus Stingray":"res://Scenes/chevrolet_corvette_c5.tscn",
	"Kuro Zephyr V6":"res://Scenes/lexus_is350.tscn",
	"Eisenach Bengal":"res://Scenes/bmw_135.tscn",
	"Strandberg Turbo":"res://Scenes/volvo_s60r.tscn",
	"Eisenach Prince":"res://Scenes/bmw_m5_e39.tscn",
		"Kronstadt Blazer":"res://Scenes/sl_500.tscn",	
	"Schroder Classique Sport":"res://Scenes/audi_s4.tscn",

	"Brutus Viper":"res://Scenes/gt500.tscn",
	"Mir Cars Hutch":"res://Scenes/chevelle_ss.tscn",
	"Mir Cars Crawler":"res://Scenes/volvo_xc90.tscn",
	"Eisenach Escorter":"res://Scenes/bmw_x5.tscn",

	"Eisenach Monarch":"res://Scenes/bmw_745.tscn",
	"Mir Cars Transporter":"res://Scenes/audi_a8.tscn",
	"Kuro Vault":"res://Scenes/lexus_ls430.tscn",
	"Eisenach Suppressor":"res://Scenes/bmw_535d.tscn",
	"Schroder D-20":"res://Scenes/audi_a3.tscn",
		"Kuro Serenity":"res://Scenes/lexus_sc.tscn",
		"Kronstadt Fortress":"res://Scenes/s600.tscn",
			"Eisenach Goblin":"res://Scenes/bmw_1m.tscn",


	"Schroder Atrix Sport":"res://Scenes/audi_tt_rs.tscn",
	"Bartoli Cruiser":"res://Scenes/granturismo.tscn",
	"Berkshire V12-S":"res://Scenes/aston_db9.tscn",
	"Berkshire Tempest":"res://Scenes/vanquish.tscn",
	"Eisenach Black Panda":"res://Scenes/bmw_330d.tscn",
	"Kuro Persian":"res://Scenes/lexus_gs430.tscn",
		"Kronstadt Essence":"res://Scenes/clk_55.tscn",
	"Kronstadt Crest":"res://Scenes/slk.tscn",


	"Schroder Atrocity":"res://Scenes/audi_s6.tscn",
	"Kestrel Battleaxe":"res://Scenes/sagaris.tscn",
	"Linetti Shepherd":"res://Scenes/gallardo.tscn",
	"Brutus Venom":"res://Scenes/dodge_viper.tscn",
	"Kestrel Touring":"res://Scenes/tvr_cerbera.tscn",



	"Linetti Terror":"res://Scenes/murcielago.tscn",
	"Linetti Firestorm":"res://Scenes/diablo_road.tscn",
	"Kestrel Guillotine":"res://Scenes/tvr t 440r.tscn",
	"Mir Cars Raptor":"res://Scenes/saleen_s7.tscn",
	"Schroder Fastback":"res://Scenes/audi_a5_tdi.tscn",
	"Mir Cars Athletic C70":"res://Scenes/zonda.tscn",
	"Bartoli Track Cruiser":"res://Scenes/mc12.tscn",
	"Brutus Thunderbolt":"res://Scenes/ford_cobra.tscn",


	"Bartoli Cruiser Interceptor": "res://Scenes/granturismo_police.tscn"
}
var radar_target_speeds := {
	"suv": 170,
	"compact": 185,
	"track_cars": 300,
	"muscle": 200,
	"urban": 190,
	"sedans": 195,
	"sport": 210,
	"sport_racing": 250,
	"supercars": 270,
	"special": 230
}

var car_colors := {
	"Straeda Pitbull":[Color8(128,128,0), Color8(90,90,90), Color8(180,150,80), Color8(0,70,40)],
	"Colossus Behemoth":[Color8(215,255,1), Color8(255,255,255), Color8(200,180,120), Color8(160,0,0)],
	"Mir Cars Nightwolf":[Color8(40,40,40), Color8(200,180,120), Color8(0,60,120), Color8(160,0,0)],
	"Colossus Titan Max":[Color8(255,0,0), Color8(180,180,180), Color8(210,180,90), Color8(120,40,40)],

	"Zenith Horizon":[Color8(255,116,49), Color8(255,255,255), Color8(0,90,180), Color8(180,180,180)],
	"Schroder Atrix Q32":[Color8(192,192,192), Color8(255,255,255), Color8(140,0,255), Color8(0,120,160)],
	"Straeda B32":[Color8(132,132,132), Color8(255,255,255), Color8(255,140,0), Color8(0,120,200)],

	"Kuro Zephyr":[
		Color8(240,240,240),
		Color8(120,20,20),
		Color8(0,110,130),
		Color8(70,70,70)
	],
	"Eisenach Suppressor":[
	Color8(75,78,71),     # ⭐ Default — Graphite (boring executive)
	Color8(180,180,180),  # Silver
	Color8(60,60,60),     # Dark Grey
	Color8(0,70,120)      # Deep Blue
],
"Kronstadt Crest":[
	Color8(180,180,180),   # Iridium Silver
	Color8(255,255,255),   # Calcite White
	Color8(60,60,60),      # Tenorite Grey
	Color8(0,70,120)       # Cavansite Blue
],
	"Mir Cars Crawler":[
		Color8(200,40,40),   # Deep Red (default)
		Color8(255,255,255), # White
		Color8(60,60,60),    # Graphite
		Color8(0,80,160)     # Deep Blue
	],
		"Eisenach Goblin":[
	Color8(237,132,69),    # ⭐ Fire Orange (default — BMW 1M signature)
	Color8(255,255,255),  # White
	Color8(60,60,60),     # Graphite
	Color8(0,90,180)      # Deep Blue
],

	"Eisenach Escorter":[
		Color8(180,180,180), # Silver (default BMW SUV vibe)
		Color8(255,255,255), # White
		Color8(60,60,60),    # Dark Grey
		Color8(0,70,120)     # Deep Blue
	],
	"Kronstadt Blazer":[
	Color8(180,180,180),   # Silver (default)
	Color8(200,40,40),     # ⭐ Deep Mercedes Red
	Color8(60,60,60),      # Graphite
	Color8(0,70,120)       # Deep Blue
],
"Kuro Serenity":[
	Color8(20,40,60),     # ⭐ Midnight Jade Pearl (default) — deep green-black Lexus luxury
	Color8(255,255,255),  # ⭐ Diamond White Pearl — classic Lexus VIP white
	Color8(180,180,180),  # ⭐ Platinum Silver — calm GT silver
	Color8(60,60,60)      # ⭐ Graphite Shadow — dark executive grey
],


"Kestrel Touring":[
	Color8(255,54,35),     # ⭐ Midnight Blackpool (default)
	Color8(160,40,200),   # Toxic Purple
	Color8(120,255,40),   # Radioactive Lime
	Color8(255,90,20)     # Cerbera Flame Orange
],
	"Kronstadt Fortress":[
	Color8(0,0,0),       # Black (default)
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(0,40,80)      # Navy Blue
],

	"Mir Cars Hutch":[Color8(180,20,20), Color8(255,255,255), Color8(60,60,60), Color8(0,40,80)],
	"Brutus Viper":[Color8(0,0,128), Color8(255,255,255), Color8(200,200,200), Color8(160,0,0)],

	"Brutus Stingray":[Color8(255,255,0), Color8(255,255,255), Color8(255,0,0), Color8(160,160,160)],
	"Kestrel Speedster":[Color8(192,192,192), Color8(255,255,255), Color8(0,120,180), Color8(180,180,180)],
	"Berkshire Blunt":[Color8(0,66,37), Color8(173,69,67), Color8(180,180,180), Color8(172,213,243)],
	"Kestrel Seabird":[Color8(50,205,50), Color8(255,255,255), Color8(255,200,0), Color8(0,120,200)],
	"Kuro Zephyr V6":[Color8(255,255,255), Color8(64,64,64), Color8(0,90,180), Color8(180,180,180)],
	"Strandberg Turbo":[Color8(133,82,141), Color8(255,255,255), Color8(60,60,60), Color8(0,80,160)],

		"Eisenach Monarch":[
	Color8(0,40,80),     # Deep Executive Blue (default)
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(60,60,60)     # Graphite Grey
],
"Kuro Persian":[
	Color8(0,110,130),   # Teal Torque (same as Mammoth)
	Color8(255,255,255), # White
	Color8(60,60,60),    # Dark Grey
	Color8(180,20,20)    # Deep Muscle Red
],

	"Mir Cars Transporter":[Color8(0,90,160), Color8(255,255,255), Color8(160,160,160), Color8(0,40,80)],
	"Kuro Vault":[Color8(123,3,35), Color8(255,255,255), Color8(60,60,60), Color8(0,70,120)],
"Schroder D-20":[
	Color8(240,240,240),
	Color8(0,60,120),
	Color8(180,180,180),
	Color8(120,0,0)
],
"Kronstadt Essence":[
	Color8(20,20,20),     # Obsidian Black (default AMG vibe)
	Color8(255,255,255),  # Arctic White
	Color8(180,180,180),  # Iridium Silver
	Color8(0,70,120)      # Cavansite Blue
],
"Schroder Fastback":[
	Color8(180,180,180),   # Silver (default, executive)
	Color8(0,120,200),     # ⭐ Sepang Blue (bright Audi sport color)
	Color8(200,40,40),     # ⭐ Misano Red (deep sporty red)
	Color8(255,140,0)      # ⭐ Samoa Orange (rare Audi exclusive)
],
"Schroder Colosso":[
	Color8(180,180,180),   # Silver (default Audi SUV vibe)
	Color8(255,255,255),   # White
	Color8(60,60,60),      # Executive Graphite
	Color8(0,70,120)       # Deep Blue (Audi signature)
],

"Eisenach Prince":[
	Color8(255,99,71),    # ⭐ Tomato Red (default)
	Color8(185,155,185),  # White
	Color8(60,60,60),     # Dark Grey
	Color8(0,0,0)         # Black
],
	"Berkshire Tempest":[Color8(192,192,192), Color8(255,255,255), Color8(0,80,120), Color8(160,160,160)],
	"Berkshire V12-S":[Color8(46,54,64), Color8(255,255,255), Color8(80,120,160), Color8(160,160,160)],
	"Bartoli Cruiser":[Color8(0,157,192), Color8(255,255,255), Color8(180,180,180), Color8(0,90,160)],
	   
"Schroder Classique Sport":[
	Color8(0,192,192),   # ⭐ Cyan — new signature color
	Color8(255,255,255), # White
	Color8(180,180,180), # Silver
	Color8(200,40,40)    # Red
],
	"Eisenach Bengal":[Color8(113,115,120), Color8(255,255,255), Color8(0,90,180), Color8(180,180,180)],

		"Schroder Atrocity":[
		Color8(255,0,0),    # ⭐ Default — tomato red
		Color8(255,255,255),  # White
		Color8(60,60,60),     # Dark grey
		Color8(0,0,0)         # Black
	],
	"Kestrel Battleaxe":[Color8(180,20,35), Color8(255,255,255), Color8(255,140,0), Color8(200,40,80)],
	"Linetti Shepherd":[Color8(50,220,40), Color8(255,255,255), Color8(255,200,0), Color8(0,160,80)],
	"Brutus Venom":[Color8(255,0,0), Color8(255,255,255), Color8(180,180,180), Color8(0,0,0)],

	"Linetti Terror":[Color8(65,66,76), Color8(255,255,255), Color8(255,200,0), Color8(160,160,160)],
	"Linetti Firestorm":[Color8(225,220,40), Color8(255,255,255), Color8(255,80,0), Color8(200,160,0)],
	"Kestrel Guillotine":[Color8(120,0,180), Color8(255,255,255), Color8(200,160,255), Color8(60,0,90)],
	"Mir Cars Raptor":[Color8(225,20,40), Color8(255,255,255), Color8(160,160,160), Color8(0,40,80)]
}

func _ready() -> void:
	load_color()

	if GameMode.game_mode != "Club Cups":
		selected_class = ""   # clear ONLY

	all_cars = get_unlocked_cars()


func on_car_selected(car_name: String) -> void:
	selected_car_name = car_name

	if GameMode.game_mode == "Club Cups":
		selected_class = ChampionshipState.active_cup
	else:
		selected_class = get_class_of_car(car_name)

	print("Car selected:", car_name, "→ class:", selected_class)



func on_game_mode_changed(new_mode: String) -> void:
	selected_class = ""
	print("GameMode switched to", new_mode, "→ class cleared")

func save_color() -> void:
	var f: FileAccess = FileAccess.open("user://car_color.save", FileAccess.WRITE)
	if f:
		f.store_line("%s,%s,%s,%s" % [selected_color.r, selected_color.g, selected_color.b, selected_color.a])
		f.close()


func load_color() -> void:
	if FileAccess.file_exists("user://car_color.save"):
		var f: FileAccess = FileAccess.open("user://car_color.save", FileAccess.READ)
		if f:
			var parts: PackedStringArray = f.get_line().split(",")
			if parts.size() == 4:
				selected_color = Color(
					parts[0].to_float(),
					parts[1].to_float(),
					parts[2].to_float(),
					parts[3].to_float()
				)
			f.close()


func pick_ai_car_path() -> String:
	if GameMode.game_mode != "Club Cups":
		if selected_class == "" and selected_car_name != "":
			selected_class = get_class_of_car(selected_car_name)

		var list: Array[String] = class_lists.get(selected_class, [])
		if list.is_empty():
			print("AI ERROR: Class", selected_class, "has no cars")
			return selected_car

		var chosen: String = list[randi() % list.size()]
		selected_ai_car_name = chosen
		return car_scene_paths.get(chosen, selected_car)

	var cup_id: String = ChampionshipState.active_cup
	var filtered: Array[String] = ClubCups.get_available_cars(cup_id)

	if filtered.is_empty():
		return selected_car

	var chosen_cup: String = filtered[randi() % filtered.size()]
	selected_ai_car_name = chosen_cup
	return car_scene_paths.get(chosen_cup, selected_car)



func get_ai_paths_for_class(_unused: Variant) -> Array[String]:
	var result: Array[String] = []

	if GameMode.game_mode != "Club Cups":
		if selected_class == "" and selected_car_name != "":
			selected_class = get_class_of_car(selected_car_name)

		var list: Array = class_lists.get(selected_class, [])
		if list.is_empty():
			print("AI ERROR: Class", selected_class, "has no cars, returning empty AI list")
			return []

		for i in range(7):
			var car_name: String = list[randi() % list.size()]
			result.append(car_scene_paths.get(car_name, selected_car))

		return result

	var cup_id: String = ChampionshipState.active_cup
	var filtered: Array[String] = ClubCups.get_available_cars(cup_id)

	if filtered.is_empty():
		for i in range(7):
			result.append(selected_car)
		return result

	for i in range(7):
		var car_name_cup: String = filtered[randi() % filtered.size()]
		result.append(car_scene_paths.get(car_name_cup, selected_car))

	return result


func get_radar_target_speed() -> int:
	return radar_target_speeds.get(selected_class, 180)


func get_unlocked_cars() -> Array:
	var result: Array = []
	for car in all_cars:
		if car.category in RoadChallengeManager.unlocked_categories:
			result.append(car)
	return result


func apply_championship_class(cup_id: String) -> void:
	# Club Cups → class is exactly the cup ID
	selected_class = cup_id
	print("Championship class applied:", selected_class)


func get_ai_list_for_car(car_name: String) -> Array[String]:
	if GameMode.game_mode == "Club Cups":
		return class_lists.get(ChampionshipState.active_cup, [])

	for key: String in class_lists.keys():
		var cars_in_group: Array[String] = class_lists[key]
		if car_name in cars_in_group:
			return cars_in_group

	return []


func apply_auto_class_if_not_club() -> void:
	if GameMode.game_mode == "Club Cups":
		return

	if selected_class == "" and selected_car_name != "":
		selected_class = get_class_of_car(selected_car_name)



func get_class_of_car(car_name: String) -> String:
	for class_id: String in class_lists.keys():
		var cars: Array = class_lists[class_id]
		if car_name in cars:
			return class_id
	return ""


func reset_class_if_not_club() -> void:
	if GameMode.game_mode != "Club Cups":
		selected_class = ""
