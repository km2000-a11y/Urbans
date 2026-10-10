extends Node

var selected_car: String = ""          # scene path
var selected_car_name: String = ""     # car name string

var selected_ai_car: String = ""       # scene path
var selected_ai_car_name: String = ""  # car name string
var dealership_mode:bool=false
# Cars.gd
var garage_mode := false
var selected_color: Color = Color.WHITE
var selected_class: String = ""
var all_cars: Array = []
var manual_class_clear := false
var unlocked_cars: Dictionary = {}   # car_name -> { "unlocked": bool, "unlock_source": String }
var unlocked_save_path := "user://unlocked_cars.json"
var player_money: int = 0
var upgrades: Dictionary = {}   # car_name -> { weight, engine, steering, brakes }
var upgrades_save_path := "user://car_upgrades.json"
var money_save_path := "user://money.save"



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
		"Straeda Volant",
		"Kuro Zephyr",
		"Eisenach Bengal",
	],

	"muscle": [
		"Mir Cars Hutch",
		"Brutus Viper"
	],

	"urban": [
			"Mir Cars Blazer",
		"Berkshire Blunt",
		"Kuro Serenity",
		"Kestrel Speedster",
			"Kestrel Seabird",
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
		"Linetti Shepherd",
		"Brutus Venom",
		"Berkshire Tempest",
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
		"Zenith Horizon",
	],
	"businessman_racers":[
	"Kuro Vault",
	"Schroder Suppressor",
	"Strandberg Turbo",
	"Brutus Prince"
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
	"Straeda Volant",
	"Schroder Atrix Q32",
	"Colossus Titan Max",
	"Kestrel Speedster",
	"Kestrel Touring",
	"Brutus Prince",
	"Berkshire Blunt",
	"Brutus Stingray",
	"Zenith Horizon",
	"Kuro Serenity",
	"Brutus Viper",
	"Kuro Vault",
	"Strandberg Turbo",
	"Schroder Colosso",
	"Mir Cars Transporter",
	"Schroder Suppressor",

	"Kestrel Seabird",
	"Colossus Behemoth",
	"Schroder Classique Sport",
	"Eisenach Bengal",
	"Mir Cars Nightwolf",
	"Kuro Zephyr"
],
"berkshire_cup":[
	"Berkshire Blunt",
	"Berkshire Tempest",
	"Berkshire V12-S"
],
"drop_top_challenge":[
	"Schroder Atrix Q32",
	"Kestrel Speedster",
	"Berkshire Blunt",
],
"low_displacement_challenge":[
		"Kestrel Seabird",
		"Kuro Zephyr",
		"Schroder Classique Sport",
		"Straeda Volant",
		"Strandberg Turbo"
		
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
		"Kestrel Speedster",
		"Berkshire Tempest",
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"grand_touring": [
		"Kuro Serenity",
		"Berkshire Blunt",
		"Berkshire Tempest",
		"Berkshire V12-S"
	],
	"stingray_competition":[
		"Brutus Stingray"
	],
	"schroder_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Suppressor",
		"Schroder Classique Sport",
		
	],
	"gentleman_racers":[
		"Berkshire Blunt",
		"Kestrel Speedster",
		"Berkshire V12-S",
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
				"Schroder Suppressor",
		"Eisenach Bengal",
		"Mir Cars Blazer",



	],
		"kestrel_max":[
		"Kestrel Touring",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],
		"v12_engines":[
		"Berkshire V12-S",
		"Linetti Firestorm",
		"Berkshire Tempest",
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
	"Mir Cars Regent":"res://Scenes/gs300.tscn",
	"Eisenach Prince":"res://Scenes/bmw_m5_e39.tscn",
		"Mir Cars Blazer":"res://Scenes/c43.tscn",	
	"Schroder Classique Sport":"res://Scenes/audi_rs3.tscn",

	"Brutus Viper":"res://Scenes/gt500.tscn",
	"Mir Cars Hutch":"res://Scenes/chevelle_ss.tscn",
	"Mir Cars Crawler":"res://Scenes/volvo_xc90.tscn",
	"Eisenach Escorter":"res://Scenes/bmw_x5.tscn",

	"Eisenach Monarch":"res://Scenes/bmw_745.tscn",
	"Mir Cars Transporter":"res://Scenes/audi_a8.tscn",
	"Kuro Vault":"res://Scenes/lexus_ls430.tscn",
	"Schroder Suppressor":"res://Scenes/audi_a4.tscn",
	"Schroder D-20":"res://Scenes/audi_a3.tscn",
		"Kuro Serenity":"res://Scenes/lexus_sc.tscn",
		"Kronstadt Fortress":"res://Scenes/s600.tscn",
			"Eisenach Goblin":"res://Scenes/bmw_1m.tscn",
			"Straeda Volant":"res://Scenes/new_beetle.tscn",


	"Schroder Atrix Sport":"res://Scenes/audi_tt_rs.tscn",
	"Bartoli Cruiser":"res://Scenes/granturismo.tscn",
	"Berkshire V12-S":"res://Scenes/aston_db9.tscn",
	"Berkshire Tempest":"res://Scenes/vanquish.tscn",
	"Eisenach Black Panda":"res://Scenes/bmw_330d.tscn",
	"Kuro Persian":"res://Scenes/lexus_gs430.tscn",
	"Kronstadt Crest":"res://Scenes/slk.tscn",


	"Schroder Atrocity":"res://Scenes/audi_s6.tscn",
	"Kestrel Battleaxe":"res://Scenes/sagaris.tscn",
	"Linetti Shepherd":"res://Scenes/gallardo.tscn",
	"Brutus Venom":"res://Scenes/dodge_viper.tscn",
	"Berkshire Mocha":"res://Scenes/jaguar_s_type.tscn",
	"Kestrel Touring":"res://Scenes/tvr_cerbera.tscn",
	"Eisenach Roadstar":"res://Scenes/bmw_z8.tscn",


	"Brutus Prince":"res://Scenes/lincoln_ls.tscn",
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
	"suv": 160,
	"compact": 185,
	"track_cars": 300,
	"muscle": 200,
	"urban": 200,
	"sedans": 195,
	"sport": 210,
	"sport_racing": 250,
	"supercars": 270,
	"special": 230
}

var car_colors = {

# SUV

"Colossus Titan Max":[
	Color8(255,0,0),
	Color8(255,255,0),
	Color8(0,0,0)
],

"Colossus Behemoth":[
	Color8(255,255,0),
	Color8(255,0,0),
	Color8(0,0,0)
],

"Schroder Colosso":[
	Color8(180,180,180),
	Color8(255,255,255),
	Color8(60,60,60),
	Color8(0,70,120),
	Color8(0,60,20),
	Color8(120,0,0)
],

"Mir Cars Nightwolf":[
	Color8(0,0,192),
	Color8(255,255,255),
	Color8(64,64,64),
	Color8(0,80,160),
	Color8(20,20,20)
],

# COMPACT

"Kuro Zephyr":[
	Color8(240,240,240),
	Color8(120,20,20),
	Color8(0,110,130),
	Color8(70,70,70),
	Color8(255,140,0),
	Color8(255,255,255)
],

"Straeda Volant":[
	Color8(132, 132, 132), # Default Grey
Color8(0, 0, 0), # Black
Color8(220, 20, 60), # Crimson Red
Color8(255, 255, 255), # White
Color8(0, 80, 180), # Deep Blue
Color8(0, 150, 80), # Cyber Green
Color8(255, 210, 0), # Sunflower Yellow
Color8(255, 160, 200) # Pink
],

"Schroder Atrix Q32":[
	Color8(192,192,192),
	Color8(255,255,255),
	Color8(140,0,255),
	Color8(0,120,160),
	Color8(200,40,40),
	Color8(20,20,20),
	Color8(255,140,0),
	Color8(255,215,0)
],

"Eisenach Bengal":[
	Color8(255,255,255),
	Color8(255,99,71),
	Color8(185,155,185),
	Color8(60,60,60),
	Color8(0,0,0),
	Color8(0,90,180),
	Color8(255,200,0)
],

"Zenith Horizon":[
	Color8(255,116,49),
	Color8(255,255,255),
	Color8(0,90,180),
	Color8(180,180,180),
	Color8(20,20,20),
	Color8(200,40,40),
	Color8(120,0,180),
	Color8(255,215,0)
],

# MUSCLE

"Brutus Viper":[
	Color8(0,0,128),
	Color8(255,255,255),
	Color8(200,200,200),
	Color8(160,0,0),
	Color8(0,0,0),
	Color8(255,140,0),
	Color8(255,215,0),
	Color8(0,70,40)
],

"Mir Cars Hutch":[
	Color8(228,31,36),
	Color8(255,255,255),
	Color8(160,160,160),
	Color8(0,40,120),
	Color8(20,20,20),
	Color8(255,140,0)
],

# URBAN

"Kuro Serenity":[
	Color8(20,40,60),
	Color8(255,255,255),
	Color8(180,180,180),
	Color8(60,60,60),
	Color8(0,0,0),
	Color8(90,70,50)
],

"Kestrel Seabird":[
	Color8(50,205,50),
	Color8(255,80,20),
	Color8(255,255,255),
	Color8(255,200,0),
	Color8(0,120,200),
	Color8(200,40,40),
	Color8(20,20,20),
	Color8(180,180,180),
	Color8(140,0,255),
	Color8(0,70,40)
],

"Kestrel Speedster":[
	Color8(180,180,180),
	Color8(255,255,255),
	Color8(20,20,20),
	Color8(0,70,40),
	Color8(0,90,180),
	Color8(255,140,0),
	Color8(255,220,0),
	Color8(90,90,90)
],

"Brutus Stingray":[
	Color8(255,255,0),
	Color8(255,0,0),
	Color8(180,180,180),
	Color8(0,0,0)
],

"Berkshire Blunt":[
	Color8(0,66,37),
	Color8(173,69,67),
	Color8(180,180,180),
	Color8(172,213,243),
	Color8(0,0,0),
	Color8(255,255,255),
	Color8(120,0,0),
	Color8(90,70,50),
	Color8(40,40,80),
	Color8(160,160,160)
],

# EXECUTIVE

"Strandberg Turbo":[
	Color8(133,82,141),
	Color8(255,255,255),
	Color8(60,60,60),
	Color8(0,80,160),
	Color8(180,180,180),
	Color8(200,40,40)
],

"Mir Cars Regent":[
	Color8(20,40,60),
	Color8(225,225,220),
	Color8(110,120,140),
	Color8(90,70,50)
],

"Kuro Vault":[
	Color8(123,3,35),
	Color8(255,255,255),
	Color8(60,60,60),
	Color8(0,70,120),
	Color8(180,180,180),
	Color8(20,40,60)
],

"Berkshire Prince":[
	Color8(0,0,0),
	Color8(255,255,255),
	Color8(180,180,180),
	Color8(0,40,80),
	Color8(0,60,20)
],

"Schroder Suppressor":[
	Color8(75,78,71),
	Color8(180,180,180),
	Color8(60,60,60),
	Color8(0,70,120),
	Color8(255,255,255)
],

# SPORT COUPE

"Schroder Classique Sport":[
	Color8(0,192,192),
	Color8(255,255,255),
	Color8(180,180,180),
	Color8(200,40,40),
	Color8(20,20,20),
	Color8(0,70,120),
	Color8(255,140,0),
	Color8(255,215,0)
],

"Eisenach Roadstar": [
	Color8(192, 192, 192), # Silver (default)
	Color8(255, 255, 255), # White
	Color8(15, 15, 15),    # Black
	Color8(25, 70, 180),   # Interlagos Blue
	Color8(190, 20, 30),   # Imola Red
	Color8(0, 140, 90)     # Deep Emerald Green
],
"Mir Cars Blazer": [
	Color8(15, 15, 15),    # Obsidian Black (default)
	Color8(192, 192, 192), # Brilliant Silver
	Color8(255, 255, 255), # Polar White
	Color8(55, 75, 145),   # Tanzanite Blue
	Color8(20, 65, 35),    # Designo Green
	Color8(120, 20, 20)    # Designo Red
],

"Berkshire V12-S":[
	Color8(46,54,64),
	Color8(255,255,255),
	Color8(80,120,160),
	Color8(160,160,160),
	Color8(0,0,0),
	Color8(120,0,0)
],

"Kestrel Touring":[
	Color8(255,54,35),
	Color8(160,40,200),
	Color8(120,255,40),
	Color8(255,90,20),
	Color8(255,255,255),
	Color8(20,20,20),
	Color8(255,215,0),
	Color8(0,90,180),
	Color8(180,180,180),
	Color8(120,0,0)
],

# SPORT RACING

"Kestrel Battleaxe":[
	Color8(180,20,35),
	Color8(255,255,255),
	Color8(255,140,0),
	Color8(200,40,80),
	Color8(120,255,40),
	Color8(160,40,200),
	Color8(20,20,20),
	Color8(255,215,0),
	Color8(0,90,180),
	Color8(180,180,180)
],

"Berkshire Tempest":[
	Color8(192,192,192),
	Color8(255,255,255),
	Color8(0,80,120),
	Color8(160,160,160),
	Color8(0,0,0),
	Color8(120,0,0)
],

"Brutus Venom":[
	Color8(255,0,0),
	Color8(255,255,255),
	Color8(180,180,180),
	Color8(0,0,0),
	Color8(0,40,120),
	Color8(255,140,0),
	Color8(255,215,0),
	Color8(140,0,255)
],

"Linetti Shepherd":[
	Color8(50,220,40),
	Color8(255,255,255),
	Color8(255,200,0),
	Color8(0,160,80),
	Color8(255,120,0),
	Color8(20,20,20),
	Color8(255,215,0),
	Color8(180,180,180),
	Color8(0,90,180),
	Color8(200,40,40)
],

# SUPERCARS

"Kestrel Guillotine":[
	Color8(120,0,180),
	Color8(255,255,255),
	Color8(200,160,255),
	Color8(60,0,90),
	Color8(255,120,0),
	Color8(20,20,20),
	Color8(255,215,0),
	Color8(0,90,180),
	Color8(180,180,180),
	Color8(200,40,40)
],

"Linetti Firestorm":[
	Color8(225,220,40),
	Color8(255,255,255),
	Color8(255,80,0),
	Color8(200,160,0),
	Color8(200,20,20),
	Color8(20,20,20),
	Color8(180,180,180),
	Color8(0,90,180),
	Color8(140,0,255),
	Color8(0,70,40)
],

"Mir Cars Raptor":[
	Color8(225,20,40),
	Color8(255,255,255),
	Color8(160,160,160),
	Color8(0,40,80),
	Color8(0,0,0),
	Color8(0,90,180),
],

"Linetti Terror":[
	Color8(65,66,76),
	Color8(255,255,255),
	Color8(255,200,0),
	Color8(160,160,160),
	Color8(255,120,0),
	Color8(200,20,20),
	Color8(20,20,20),
	Color8(140,0,255),
	Color8(0,90,180),
	Color8(0,70,40)
],

# TRACK

"Bartoli Track Cruiser":[
	Color8(0,157,192),
	Color8(255,255,255),
	Color8(180,180,180),
	Color8(0,90,160)
],

"Brutus Thunderbolt":[
	Color8(255,0,0),
	Color8(255,255,255),
	Color8(60,60,60),
	Color8(0,40,120)
],

"Mir Cars Athletic C70":[
	Color8(255,80,20),
	Color8(255,255,255),
	Color8(60,60,60),
	Color8(0,90,160),
	Color8(255,215,0),
	Color8(140,0,255),
	Color8(200,40,40),
	Color8(20,20,20)
]

}

func _ready() -> void:
	load_color()
	load_unlocked_cars()
	load_money()
	initialize_upgrades()
	load_upgrades()
	if GameMode.game_mode != "Club Cups":
		selected_class = ""
	all_cars = get_unlocked_cars()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset_progress"):
		reset_all_progress()

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
	randomize()
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
	var filtered: Array

	if cup_id == "under_400_hp":
		# 🔥 Use full shuffled pool instead of static subset
		filtered = class_lists["under_400_hp"].duplicate()
		filtered.shuffle()
		print("DEBUG: Shuffled under_400_hp list:", filtered)
	else:
		filtered = ClubCups.get_available_cars(cup_id)

	if filtered.is_empty():
		for i in range(7):
			result.append(selected_car)
		return result

	# ✅ Cycle through shuffled list → guarantees variety
	for i in range(min(7, filtered.size())):
		var car_name_cup: String = filtered[i]
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
func save_unlocked_cars() -> void:
	var file = FileAccess.open(unlocked_save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(unlocked_cars))
		file.close()
		print("Unlocked cars saved")

func load_unlocked_cars() -> void:
	if not FileAccess.file_exists(unlocked_save_path):
		print("No unlocked cars save found, starting fresh")
		# Always unlock starter car
		unlocked_cars["Colossus Behemoth"] = { "unlocked": true, "unlock_source": "starter" }
		save_unlocked_cars()
		return

	var file = FileAccess.open(unlocked_save_path, FileAccess.READ)
	if file:
		var text = file.get_as_text()
		var data = JSON.parse_string(text)
		if typeof(data) == TYPE_DICTIONARY:
			unlocked_cars = data
		file.close()

	# Ensure starter car is always present
	if not unlocked_cars.has("Colossus Behemoth"):
		unlocked_cars["Colossus Behemoth"] = { "unlocked": true, "unlock_source": "starter" }
		save_unlocked_cars()

	print("Unlocked cars loaded:", unlocked_cars.keys())

func unlock_car(car_name: String, source: String = "manual") -> void:
	if not unlocked_cars.has(car_name):
		unlocked_cars[car_name] = { "unlocked": true, "unlock_source": source }
		save_unlocked_cars()
		print("Car unlocked:", car_name, "via", source)
func save_money() -> void:
	var f = FileAccess.open(money_save_path, FileAccess.WRITE)
	if f:
		f.store_line(str(player_money))
		f.close()
		print("Money saved:", player_money)

func load_money() -> void:
	if FileAccess.file_exists(money_save_path):
		var f = FileAccess.open(money_save_path, FileAccess.READ)
		if f:
			player_money = int(f.get_line())
			f.close()
	else:
		# Default starting balance
		player_money = 0
		save_money()
	print("Money loaded:", player_money)
func add_money(amount: int) -> void:
	player_money += amount
	save_money()
	print("Money added:", amount, "→ Balance:", player_money)

func spend_money(amount: int) -> bool:
	if player_money < amount:
		print("Not enough money! Balance:", player_money)
		return false
	player_money -= amount
	save_money()
	print("Money spent:", amount, "→ Balance:", player_money)
	return true
func enable_dealership_mode() -> void:
	dealership_mode = true
	print("Dealership mode enabled")

func disable_dealership_mode() -> void:
	dealership_mode = false
	print("Dealership mode disabled")
func reset_all_progress():
	# Reset unlocked cars
	Cars.unlocked_cars.clear()
	Cars.unlocked_cars["Colossus Behemoth"] = { "unlocked": true, "unlock_source": "starter" }
	Cars.save_unlocked_cars()
	Cars.upgrades.clear()
	Cars.initialize_upgrades()
	Cars.save_upgrades()
	# Reset money
	Cars.player_money = 0
	Cars.save_money()

	# Reset Club Cups career
	ClubCups.current_stage = 0
	ClubCups.unlocked_cups = ["colossus"]
	ClubCups.career_progress.clear()
	ClubCups.save_progress()

	# Reset Road Challenge
	RoadChallengeSave.unlocked.clear()
	RoadChallengeSave.progress.clear()
	RoadChallengeSave.save_progress()

	print("🔥 ALL PROGRESS RESET — Fresh start!")
func initialize_upgrades():
	for car_name in car_scene_paths.keys():
		if not upgrades.has(car_name):
			upgrades[car_name] = {
				"weight": 0,
				"engine": 0,
				"steering": 0,
				"brakes": 0
			}
func save_upgrades():
	var file := FileAccess.open(upgrades_save_path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(upgrades))
		file.close()
		print("Upgrades saved")
func load_upgrades():
	if not FileAccess.file_exists(upgrades_save_path):
		print("No upgrade save found, starting fresh")
		save_upgrades()
		return

	var file := FileAccess.open(upgrades_save_path, FileAccess.READ)
	if file:
		var text := file.get_as_text()
		var data :Dictionary= JSON.parse_string(text)
		if typeof(data) == TYPE_DICTIONARY:
			upgrades = data
		file.close()

	print("Upgrades loaded:", upgrades.keys())
func get_radar_target_speed_formatted() -> String:
	var target_kmh :int= radar_target_speeds.get(selected_class, 180)

	if SpeedSettings.SPEED_UNIT.to_lower() == "mph":
		var mph := int(target_kmh * 0.621371)
		return "%d mph" % mph
	else:
		return "%d km/h" % target_kmh
