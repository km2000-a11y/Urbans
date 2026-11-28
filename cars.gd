extends Node

var selected_car: String = ""          # scene path
var selected_car_name: String = ""     # car name string
var selected_body_kit := 0
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

	# MAIN CLASSES

	"suv": [
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Schroder Colosso",
		"Mir Cars Nightwolf"
	],

	"compact": [
		"Straeda Volant",
		"Eisenach Bengal",
		"Schroder Atrix Q32",
		"Zenith Horizon"
	],

	"muscle": [
		"Brutus Viper",
		"Mir Cars Hutch"
	],

	"torque_monsters":[
		"Kronstadt Regent",
		"Schroder Suppressor",
		"Eisenach Monarch",
		"Berkshire Mocha"
	],

	"sedans": [
		"Mir Cars Goblin",
		"Strandberg Turbo",
		"Kuro Vault",
		"Schroder Prince",
		"Zenith Touring"
	],

	"urban": [
		"Kronstadt Atrocity",
		"Brutus Stingray",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt"
	],

	"sport": [
		"Bartoli Cruiser",
		"Brutus Dragster",
		"Berkshire V12-S",
		"Strandberg Predator"
	],

	"sport_racing": [
		"Brutus Venom",
		"Berkshire Tempest",
		"Kestrel Battleaxe",
		"Linetti Shepherd"
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
		"Brutus Sheriff"
	],

	# CHAMPIONSHIP CLASSES

	"v6_engines":[
		"Schroder Atrix Q32",
		"Schroder Suppressor",
		"Berkshire Mocha",
		"Kronstadt Atrocity",
		"Schroder Colosso",
		"Zenith Touring",
		"Zenith Horizon"
	],

	"zenith_competition":[
		"Zenith Horizon",
		"Zenith Touring"
	],

	"businessman_racers":[
		"Strandberg Turbo",
		"Kuro Vault",
		"Kronstadt Regent",
		"Strandberg Predator",
		"Schroder Prince",
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
		"Eisenach Monarch",
		"Berkshire Mocha",
		"Kronstadt Regent",
		"Schroder Suppressor"
	],

	"all_wheel_grip":[
		"Schroder Atrix Q32",
		"Schroder Suppressor",
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Berkshire Mocha",
		"Schroder Prince",
		"Mir Cars Nightwolf",
		"Schroder Colosso"
	],

	"urban_performance_cars":[
		"Kronstadt Atrocity",
		"Brutus Stingray",
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt"
	],

	"eisenach_cup":[
		"Eisenach Bengal",
		"Eisenach Monarch"
	],

	"v8_fury":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Kuro Vault",
		"Mir Cars Goblin",
		"Eisenach Monarch",
		"Strandberg Predator",
		"Bartoli Cruiser",
		"Brutus Dragster",
		"Brutus Stingray",
		"Brutus Venom"
	],

	"berkshire_cup":[
		"Berkshire Blunt",
		"Berkshire Mocha",
		"Berkshire V12-S",
		"Berkshire Tempest"
	],

	"drop_top_challenge":[
		"Straeda Volant",
		"Schroder Atrix Q32",
		"Kestrel Speedster",
		"Brutus Stingray",
		"Kronstadt Atrocity"
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

		"Kronstadt Regent",
		"Schroder Suppressor",
		"Eisenach Monarch",
		"Berkshire Mocha",

		"Mir Cars Goblin",
		"Strandberg Turbo",
		"Kuro Vault",
		"Schroder Prince",
		"Zenith Touring",

		"Kronstadt Atrocity",
		"Brutus Stingray",
		"Kestrel Seabird",
		"Kestrel Speedster",

		"Bartoli Cruiser",
		"Brutus Dragster",
		"Berkshire V12-S"
	],

	"low_displacement_challenge":[
		"Straeda Volant",
		"Strandberg Turbo",
		"Kestrel Seabird"
	],

	"swedish_cup":[
		"Strandberg Turbo",
		"Strandberg Predator"
	],

	"gentleman_racers":[
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Brutus Stingray",
		"Strandberg Predator",
		"Bartoli Cruiser",
		"Berkshire Mocha",
		"Berkshire Tempest"
	],

	"american_thunder":[
		"Brutus Viper",
		"Mir Cars Hutch",
		"Brutus Dragster",
		"Colossus Titan Max",
		"Colossus Behemoth",
		"Mir Cars Goblin",
		"Brutus Stingray",
		"Brutus Venom",
		"Brutus Thunderbolt"
	],

	"british_invasion":[
		"Kestrel Seabird",
		"Kestrel Speedster",
		"Berkshire Blunt",
		"Berkshire Mocha",
		"Berkshire V12-S",
		"Berkshire Tempest",
		"Kestrel Battleaxe",
		"Kestrel Guillotine"
	],

	"grand_touring":[
		"Bartoli Cruiser",
		"Brutus Dragster",
		"Berkshire Blunt",
		"Berkshire V12-S",
		"Berkshire Tempest"
	],

	"german_cup":[
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Suppressor",
		"Eisenach Monarch",
		"Eisenach Bengal",
		"Kronstadt Regent",
		"Kronstadt Atrocity",
		"Schroder Prince"
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
		"Kuro Vault",
		"Mir Cars Nightwolf",

		# GERMANY
		"Schroder Atrix Q32",
		"Schroder Colosso",
		"Schroder Suppressor",
		"Eisenach Monarch",
		"Eisenach Bengal",
		"Kronstadt Atrocity"
	],
	"colin_tribute":[
	"Kestrel Seabird"
],

"speedster_tournament":[
	"Kestrel Speedster"
],

"stingray_competition":[
	"Brutus Stingray"
],
}
var car_scene_paths = {
	"Colossus Titan Max":"res://Scenes/hummer_h1.tscn",
	"Colossus Behemoth":"res://Scenes/hummer_h2.tscn",
	"Berkshire Mocha":"res://Scenes/jaguar_s_type.tscn",
	"Mir Cars Nightwolf":"res://Scenes/lexus_lx470.tscn",
	"Straeda Pitbull":"res://Scenes/vw_touareg_v10.tscn",

	"Schroder Atrix Q32":"res://Scenes/audi_tt.tscn",

	"Zenith Horizon":"res://Scenes/nissan_350z.tscn",
	"Straeda G25":"res://Scenes/golf_v_gti.tscn",
	"Schroder D-20":"res://Scenes/audi_a3.tscn",
	"Mir Cars Crawler":"res://Scenes/volvo_xc90.tscn",
	"Eisenach Escorter":"res://Scenes/bmw_x5.tscn",
	"Kronstadt Regent":"res://Scenes/e320.tscn",


	"Kestrel Seabird":"res://Scenes/lotus_exige_s.tscn",
	"Eisenach Roadstar":"res://Scenes/bmw_z8.tscn",
	"Brutus Stingray":"res://Scenes/cadillac_cts.tscn",
	"Kuro Zephyr V6":"res://Scenes/lexus_is350.tscn",
	"Kestrel Speedster":"res://Scenes/morgan_aero_8.tscn",
	"Berkshire Blunt":"res://Scenes/jaguar_xkr.tscn",
	"Brutus Viper":"res://Scenes/gt500.tscn",
	"Mir Cars Hutch":"res://Scenes/chevelle_ss.tscn",
	"Schroder Colosso":"res://Scenes/audi_q7.tscn",
	"Eisenach Black Panda":"res://Scenes/bmw_330d.tscn",
	"Eisenach Bengal":"res://Scenes/bmw_135.tscn",
	"Schroder Prince":"res://Scenes/passat.tscn",
	"Mir Cars Athletic C70":"res://Scenes/zonda.tscn",
	"Bartoli Track Cruiser":"res://Scenes/mc12.tscn",
	"Brutus Thunderbolt":"res://Scenes/ford_cobra.tscn",
	"Eisenach Monarch":"res://Scenes/bmw_745.tscn",
	"Straeda Volant":"res://Scenes/cooper_s.tscn",
	"Strandberg Predator":"res://Scenes/cls55.tscn",
	"Bartoli Cruiser":"res://Scenes/4200_gt.tscn",
	"Kronstadt Atrocity":"res://Scenes/sl_65.tscn",

	"Mir Cars Transporter":"res://Scenes/audi_a8.tscn",
	"Berkshire Falcon":"res://Scenes/xk8.tscn",
	"Kuro Vault":"res://Scenes/lexus_ls430.tscn",
	"Kronstadt Crest":"res://Scenes/slk.tscn",
	"Zenith Prince":"res://Scenes/q45.tscn",
	"Strandberg Pilot":"res://Scenes/saab_95.tscn",
	"Berkshire V12-S":"res://Scenes/aston_db9.tscn",
	"Berkshire Tempest":"res://Scenes/vanquish.tscn",
	"Brutus Dragster":"res://Scenes/pontiac_gto.tscn",
	"Mir Cars Regent":"res://Scenes/gs300.tscn",
	"Strandberg Turbo":"res://Scenes/volvo_s60r.tscn",
	"Kuro Serenity":"res://Scenes/lexus_sc.tscn",
	"Eisenach Goblin":"res://Scenes/bmw_1m.tscn",
	"Mir Cars Goblin":"res://Scenes/ford_mondeo.tscn",


	"Schroder Atrocity":"res://Scenes/audi_s6.tscn",
	"Kestrel Battleaxe":"res://Scenes/sagaris.tscn",
	"Linetti Shepherd":"res://Scenes/gallardo.tscn",
	"Brutus Venom":"res://Scenes/corvette_z06.tscn",
	"Kuro Persian":"res://Scenes/lexus_gs430.tscn",
	"Kronstadt Fortress":"res://Scenes/s600.tscn",
	"Zenith Touring":"res://Scenes/infiniti_g35.tscn",

	"Linetti Terror":"res://Scenes/murcielago.tscn",
	"Linetti Firestorm":"res://Scenes/diablo_road.tscn",
	"Kestrel Guillotine":"res://Scenes/tvr_tuscan.tscn",
	"Mir Cars Raptor":"res://Scenes/saleen_s7.tscn",
	"Kuro Zephyr":"res://Scenes/lexus_is250.tscn",
	"Schroder Suppressor":"res://Scenes/audi_a4.tscn",
	"Schroder Fastback":"res://Scenes/audi_a5_tdi.tscn",
	"Mir Cars Blazer":"res://Scenes/sl500.tscn",
	"Kestrel Touring":"res://Scenes/tvr_cerbera.tscn"

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
	Color8(132, 132, 132), # Classic Grey (Default)
	Color8(20, 20, 20),    # Midnight Black
	Color8(245, 245, 245), # Cream White
	Color8(200, 30, 50),   # Chili Red
	Color8(25, 70, 180),   # Electric Blue
	Color8(20, 120, 70),   # British Racing Green
	Color8(255, 200, 0),   # Sunny Yellow
	Color8(255, 160, 200), # Rose Pink
	Color8(190, 150, 90),  # Mocha Brown
	Color8(140, 40, 180)   # Velvet Purple
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
"Schroder Prince": [
	Color8(0, 0, 50),      # Midnight Blue (default)
	Color8(185, 185, 175), # Reflex Silver
	Color8(25, 25, 25),    # Black Magic Pearl
	Color8(40, 65, 105),   # Indigo Blue
	Color8(90, 95, 90),    # Platinum Grey
	Color8(65, 75, 65),    # Dark Forest Green
	Color8(125, 115, 105), # Mocha Beige
	Color8(245, 245, 240)  # Alpine White
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
"Zenith Touring":[
	Color8(255,255,255),  # White (default)
	Color8(20,20,20),     # Black
	Color8(192,192,192),  # Silver
	Color8(90,90,90),     # Gunmetal
	Color8(25,35,80),     # Midnight Blue
	Color8(120,20,20),    # Burgundy
	Color8(145,145,125),  # Champagne
	Color8(0,66,37)       # Emerald Green
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
"Berkshire Mocha":[
	Color8(139,69,19),    # Mocha Brown (default)
	Color8(0,0,0),        # Black
	Color8(255,255,255),  # White
	Color8(192,192,192),  # Silver
	Color8(25,35,80),     # Sapphire Blue
	Color8(110,20,20),    # Burgundy Red
	Color8(0,66,37),      # British Racing Green
	Color8(90,90,90),     # Gunmetal Grey
	Color8(145,145,125),  # Willow Green
	Color8(220,200,170)   # Champagne Gold
],
"Bartoli Cruiser":[
	Color8(0,157,196),
	Color8(180,180,180),
	Color8(255,255,255),
	Color8(20,20,20),
	Color8(120,0,0),
	Color8(0,70,120),
	Color8(90,90,90)
],

# EXECUTIVE

"Strandberg Turbo":[
	Color8(133,82,141),    # Aubergine (default)
	Color8(255,220,70),    # Cream Yellow
	Color8(255,255,255),   # White
	Color8(183,0,0),       # Deep Red
	Color8(28,74,135),     # Dark Blue
	Color8(180,180,180)    # Silver
],
"Mir Cars Goblin":[
	Color8(20,20,20),     # Black
	Color8(255,255,255),  # White
	Color8(180,180,180),  # Silver
	Color8(60,80,130),    # Executive Blue
	Color8(120,30,30),    # Burgundy Red
	Color8(90,100,80)     # Sage Green
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

"Zenith Prince":[
	Color8(0,0,0),        # Black (default)
	Color8(255,255,255),  # White
	Color8(128,128,128),  # Silver
	Color8(25,35,80),     # Midnight Blue
	Color8(80,20,20)      # Burgundy
],



"Schroder Suppressor":[
	Color8(75,78,71),
	Color8(180,180,180),
	Color8(60,60,60),
	Color8(0,70,120),
	Color8(255,255,255)
],

# SPORT COUPE

"Strandberg Pilot":[

	Color8(0,192,192),    # Turquoise Pearl (default)

	Color8(255,255,255),  # Polar White

	Color8(190,190,190),  # Silver Metallic

	Color8(120,20,20),    # Burgundy Red

	Color8(20,20,20),     # Black Sapphire

	Color8(0,50,110),     # Nautic Blue

	Color8(110,70,140),   # Volvo Purple

	Color8(140,140,160)   # Blue Grey Metallic

],

"Eisenach Roadstar":[
	Color8(199,55,47),     # Crimson Red (default)
	Color8(192,192,192),   # Titanium Silver
	Color8(255,255,255),   # Alpine White
	Color8(15,15,15),      # Sapphire Black
	Color8(25,35,80),      # Monaco Blue
	Color8(0,66,37),       # Oxford Green
	Color8(145,145,125),   # Champagne Beige
	Color8(90,70,50)       # Sepang Bronze
],
"Eisenach Monarch":[
	Color8(0,0,80),        # Orient Blue (default)
	Color8(0,0,0),         # Black
	Color8(255,255,255),   # White
	Color8(192,192,192),   # Titanium Silver
	Color8(80,80,80),      # Graphite
	Color8(120,20,20),     # Burgundy
	Color8(0,66,37),       # Oxford Green
	Color8(145,145,125)    # Champagne
],

"Berkshire V12-S":[
	Color8(46,54,64),
	Color8(255,255,255),
	Color8(80,120,160),
	Color8(160,160,160),
	Color8(0,0,0),
	Color8(120,0,0)
],
"Strandberg Sovereign":[

	Color8(255,255,255), # Ice White (default)

	Color8(20,20,20),    # Black Sapphire

	Color8(190,190,190), # Silver Metallic

	Color8(60,60,60),    # Dark Grey

	Color8(0,40,100),    # Nautic Blue

	Color8(125,80,165),  # Volvo Purple

	Color8(120,20,20),   # Burgundy

	Color8(160,180,200)  # Ice Blue Metallic

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
"Berkshire Falcon":[
	Color8(0,66,37),
	Color8(232,214,179),  # Platinum Silver (default)
	Color8(180,180,180),   # Champagne Gold
	Color8(25,35,80),     # Sapphire Blue
	Color8(110,20,20),    # Bordeaux Red
	Color8(255,248,220),  # Ivory White
	Color8(70,70,70),     # Anthracite Grey
	Color8(0,0,0),        # Black
	Color8(48, 78, 58),
	Color8(145,145,125)   # Willow Green Metallic
],
"Mir Cars Blazer": [
	Color8(15, 15, 15),    # Obsidian Black (default)
	Color8(192, 192, 192), # Brilliant Silver
	Color8(255, 255, 255), # Polar White
	Color8(55, 75, 145),   # Tanzanite Blue
	Color8(20, 65, 35),    # Designo Green
	Color8(120, 20, 20)    # Designo Red
],
"Kronstadt Regent": [
	Color8(255, 255, 255), # Polar White
	Color8(12, 12, 12),   # Obsidian Black
	Color8(190, 190, 190),# Brilliant Silver
	Color8(120, 120, 120),# Flint Grey
	Color8(30, 35, 55),   # Midnight Blue
	Color8(15, 45, 25),   # Emerald Green
	Color8(115, 105, 85), # Travertine Beige
	Color8(80, 20, 20),   # Bordeaux Red
	Color8(55, 55, 70),   # Blue Black
	Color8(140, 145, 150) # Titanium Grey
],


# SUPERCARS
"Kestrel Guillotine":[
	Color8(120,0,180),     # Default TVR purple
	Color8(255,255,255),   # Crystal white
	Color8(255,220,40),    # Metallic yellow
	Color8(255,140,0),     # Volcano orange
	Color8(220,0,0),       # Rosso red
	Color8(0,170,255),     # Electric blue
	Color8(0,255,180),     # Chameleon turquoise
	Color8(40,40,40),      # Anthracite
	Color8(255,105,180),   # TVR pink madness
	Color8(180,255,120)    # Lime green
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
],
"Kronstadt Atrocity": [
	Color8(192,192,192),  # Brilliant Silver (default)
	Color8(15,15,15),     # Obsidian Black
	Color8(255,255,255),  # Polar White
	Color8(160,20,20)     # AMG Crimson Red
],

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
	var real_class := get_class_of_car(selected_car_name)

	# convert championship IDs to main classes if needed
	if real_class in radar_target_speeds:
		return radar_target_speeds[real_class]

	return 180

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
func apply_bodykit(car: Node, car_name: String):
	if car == null:
		return

	var saved_kit := get_body_kit(car_name)

	await get_tree().process_frame

	if !is_instance_valid(car):
		return

	var kit1 = car.get_node_or_null("ModelRoot/BodyKit1")
	var kit2 = car.get_node_or_null("ModelRoot/BodyKit2")

	if kit1 == null and kit2 == null:
		return

	if kit1:
		kit1.visible = saved_kit == 1

	if kit2:
		kit2.visible = saved_kit == 2
func get_body_kit(car_name: String) -> int:

	if not unlocked_cars.has(car_name):
		return 0

	return unlocked_cars[car_name].get(
		"body_kit",
		0
	)
