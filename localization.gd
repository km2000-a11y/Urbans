extends Node

var LANG: String = "en"

signal language_changed

var TEXT := {
	"en": {
		"road_challenge": "Road Challenge",
		"free_race": "Free Race",
		"career_mode": "Career Mode",
		"multi_device": "Multi-Device Play",
		"normal_race": "Normal Race",
		"radar_race": "Radar Race",
		"duel": "Duel",
		"elimination": "Elimination",
		"cop_chase": "Cop Chase",
		"language_options": "Language Options",
		"colossus": "Colossus Cup",
		"street_tuners": "Street Tuners",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Engines",
		"zenith_competition": "Zenith Competition",
		"businessman_racers": "Businessman Racers",
		"speedster_tournament": "Speedster Tournament",
		"kuro_cup": "Kuro Cup",
		"all_wheel_grip": "All-Wheel Grip",
		"eisenach_cup": "Eisenach Cup",
		"under_400_hp": "Under 400 HP",
		"stingray_competition": "Stingray Competition",
		"schroder_cup": "Schroder Cup",
		"gentleman_racers": "Gentleman Racers",
		"japanese_cup": "Japanese Cup",
		"german_cup": "German Cup",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "V12 Engines",
		"supercars": "Supercars",
		"track_cars": "Track Cars",
		"sport_racing": "Sport Racing",
		"special_class": "Special",
		"suv_class": "4x4 SUV",
		"compact_class": "Compact Cars",
		"muscle_class": "Muscle Cars",
		"executive_class": "Executive Cars",
		"urban_performance_class": "Urban Performance Cars",
		"sport_coupe_class": "Sport Coupe",
		"sport_racing_class": "Sports Racing Cars",
		"supercars_class": "Supercars",
		"track_class": "Track Cars",
		"buy": "BUY",
		"balance": "BALANCE",
		"price": "PRICE",
		"already_owned": "ALREADY OWNED!",
		"insufficient_cash": "INSUFFICIENT CASH!",
		"select_car": "Select Car",
		"play": "Play",
		"quit": "Quit",
		"resume": "Resume",
		"retry": "Retry",
		"volume": "Volume",
		"upgrades": "Upgrades",
		"car_dealership": "Car Dealership",
		"you_win": "YOU WIN!",
		"you_lose": "YOU LOSE!",
		"hp": "HP",
		"weight": "Weight",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Top Speed",
		"engine": "Engine",
		"italy": "Italy",
		"uk": "UK",
		"sweden": "Sweden",
		"back": "Back",
		"executive_cars": "Executive Cars",
		"urban_performance_cars": "Urban Performance Cars",
		"sport_coupe": "Sport Coupe",

		"aspiration": "Aspiration",
		"torque": "Torque",
		"transmission": "Transmission",
		"country": "Country",
		"kmh": "km/h",
		"s": "s",
		"usa": "USA",
		"germany": "Germany",
		"japan": "Japan",
		"four_wheel_drive": "Four-Wheel Drive",
		"rear_wheel_drive": "Rear-Wheel Drive",
		"front_wheel_drive": "Front-Wheel Drive",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Compact Cars",
		"muscle_cars": "Muscle Cars"
	},

	"fr": {
		"road_challenge": "Défi Routier",
		"free_race": "Course Libre",
		"career_mode": "Mode Carrière",
		"multi_device": "Jeu Multi-Appareils",
		"normal_race": "Course Normale",
		"radar_race": "Course Radar",
		"duel": "Duel",
		"elimination": "Élimination",
		"cop_chase": "Course Police",
		"language_options": "Options de langue",
		"colossus": "Coupe Colossus",
		"street_tuners": "Préparateurs de Rue",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "Moteurs V6",
		"zenith_competition": "Compétition Zenith",
		"businessman_racers": "Pilotes d’Affaires",
		"speedster_tournament": "Tournoi Speedster",
		"kuro_cup": "Coupe Kuro",
		"all_wheel_grip": "Adhérence Intégrale",
		"eisenach_cup": "Coupe Eisenach",
		"under_400_hp": "Moins de 400 ch",
		"stingray_competition": "Compétition Stingray",
		"schroder_cup": "Coupe Schröder",
		"gentleman_racers": "Gentlemen Racers",
		"japanese_cup": "Coupe Japonaise",
		"german_cup": "Coupe Allemande",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "Moteurs V12",
		"supercars": "Supercars",
		"italy": "Italie",
		"uk": "Royaume-Uni",
		"sweden": "Suède",
		"back": "Retour",
		"executive": "Voitures de Direction",
		"urban_performance": "Performance Urbaine",
		"sport_coupe": "Coupé Sport",

		"track_cars": "Voitures de Circuit",
		"sport_racing": "Course Sportive",
		"special_class": "Spécial",
		"suv_class": "4x4 SUV",
		"compact_class": "Voitures Compactes",
		"muscle_class": "Muscle",
		"executive_cars": "Voitures de Direction",
		"urban_performance_cars": "Performance Urbaine",
		"sport_coupe_class": "Coupé Sport",
		"sport_racing_class": "Course Sportive",
		"supercars_class": "Supercars",
		"track_class": "Voitures de Circuit",
		"buy": "ACHETER",
		"balance": "SOLDE",
		"price": "PRIX",
		"already_owned": "DÉJÀ ACHETÉ !",
		"insufficient_cash": "ARGENT INSUFFISANT !",
		"select_car": "Choisir une voiture",
		"play": "Jouer",
		"quit": "Quitter",
		"resume": "Continuer",
		"retry": "Recommencer",
		"volume": "Volume",
		"upgrades": "Améliorations",
		"car_dealership": "Concessionnaire",
		"you_win": "VOUS GAGNEZ !",
		"you_lose": "VOUS PERDEZ !",
		"hp": "Puissance",
		"weight": "Poids",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Vitesse max",
		"engine": "Moteur",
		"aspiration": "Aspiration",
		"torque": "Couple",
		"transmission": "Transmission",
		"country": "Pays",
		"kmh": "km/h",
		"s": "s",
		"usa": "États-Unis",
		"germany": "Allemagne",
		"japan": "Japon",
		"four_wheel_drive": "Quatre roues motrices",
		"rear_wheel_drive": "Propulsion",
		"front_wheel_drive": "Traction",
		"4x4_suv": "SUV 4x4",
		"compact_cars": "Voitures compactes",
		"muscle_cars": "Muscle Cars"
	},

	"de": {
		"road_challenge": "Straßen-Herausforderung",
		"free_race": "Freies Rennen",
		"career_mode": "Karrieremodus",
		"multi_device": "Mehrgeräte Spiel",
		"normal_race": "Normales Rennen",
		"radar_race": "Radarrennen",
		"duel": "Duell",
		"elimination": "Eliminierung",
		"cop_chase": "Polizeijagd",
		"language_options": "Spracheinstellungen",
		"colossus": "Colossus-Pokal",
		"street_tuners": "Street Tuners",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6-Motoren",
		"zenith_competition": "Zenith-Wettbewerb",
		"businessman_racers": "Geschäftsleute-Racer",
		"speedster_tournament": "Speedster-Turnier",
		"kuro_cup": "Kuro-Pokal",
		"all_wheel_grip": "Allrad-Grip",
		"eisenach_cup": "Eisenach-Pokal",
		"italy": "Italien",
		"uk": "Vereinigtes Königreich",
		"sweden": "Schweden",
		"back": "Zurück",
		"executive": "Obere Mittelklasse",
		"urban_performance": "Urban Performance",
		"sport_coupe": "Sportcoupé",

		"under_400_hp": "Unter 400 PS",
		"stingray_competition": "Stingray-Wettbewerb",
		"schroder_cup": "Schröder-Pokal",
		"gentleman_racers": "Gentleman-Racer",
		"japanese_cup": "Japan-Pokal",
		"german_cup": "Deutschland-Pokal",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "V12-Motoren",
		"supercars": "Supercars",
		"track_cars": "Track Cars",
		"sport_racing": "Sport Racing",
		"special_class": "Spezial",
		"suv_class": "4x4 SUV",
		"compact_class": "Kompaktwagen",
		"muscle_class": "Muscle",
		"executive_cars": "Obere Mittelklasse",
		"urban_performance_cars": "Urban Performance",
		"sport_coupe_class": "Sportcoupé",
		"sport_racing_class": "Sport Racing",
		"supercars_class": "Supercars",
		"track_class": "Track Cars",
		"buy": "KAUFEN",
		"balance": "GUTHABEN",
		"price": "PREIS",
		"already_owned": "BEREITS GEKAUFT!",
		"insufficient_cash": "ZU WENIG GELD!",
		"select_car": "Auto auswählen",
		"play": "Spielen",
		"quit": "Beenden",
		"resume": "Fortsetzen",
		"retry": "Erneut versuchen",
		"volume": "Lautstärke",
		"upgrades": "Upgrades",
		"car_dealership": "Autohaus",
		"you_win": "DU GEWINNST!",
		"you_lose": "DU VERLIERST!",
		"hp": "PS",
		"weight": "Gewicht",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Höchstgeschwindigkeit",
		"engine": "Motor",
		"aspiration": "Aufladung",
		"torque": "Drehmoment",
		"transmission": "Getriebe",
		"country": "Land",
		"kmh": "km/h",
		"s": "s",
		"usa": "USA",
		"germany": "Deutschland",
		"japan": "Japan",
		"four_wheel_drive": "Allradantrieb",
		"rear_wheel_drive": "Hinterradantrieb",
		"front_wheel_drive": "Vorderradantrieb",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompaktwagen",
		"muscle_cars": "Muscle-Cars"
	},

	"ru": {
		"road_challenge": "Дорожный вызов",
		"free_race": "Свободная гонка",
		"career_mode": "Карьерный режим",
		"multi_device": "Мульти-устройственная игра",
		"normal_race": "Обычная гонка",
		"radar_race": "Радарная гонка",
		"duel": "Дуэль",
		"elimination": "Элиминация",
		"cop_chase": "Погоня полиции",
		"language_options": "Языковые настройки",
		"colossus": "Кубок Colossus",
		"street_tuners": "Уличные тюнеры",
		"muscle_hustle": "Muscle Hustle",
		"italy": "Италия",
		"uk": "Великобритания",
		"sweden": "Швеция",
		"back": "Назад",
		"special": "Особый",
		"executive": "Представительские авто",
		"urban_performance": "Городская производительность",
		"sport_coupe": "Спортивное купе",

		"v6_engines": "Двигатели V6",
		"zenith_competition": "Соревнование Zenith",
		"businessman_racers": "Гонщики-бизнесмены",
		"speedster_tournament": "Турнир Speedster",
		"kuro_cup": "Кубок Kuro",
		"all_wheel_grip": "Полный привод",
		"eisenach_cup": "Кубок Eisenach",
		"under_400_hp": "До 400 л.с.",
		"stingray_competition": "Соревнование Stingray",
		"schroder_cup": "Кубок Schröder",
		"gentleman_racers": "Гонщики-джентльмены",
		"japanese_cup": "Японский кубок",
		"german_cup": "Немецкий кубок",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "Двигатели V12",
		"supercars": "Суперкары",
		"track_cars": "Трековые машины",
		"sport_racing": "Спортивные гонки",
		"special_class": "Особый",
		"suv_class": "4x4 SUV",
		"compact_class": "Компактные автомобили",
		"muscle_class": "Muscle",
		"executive_cars": "Представительские авто",
		"urban_performance_cars": "Городская производительность",
		"sport_coupe_class": "Спортивное купе",
		"sport_racing_class": "Спортивные гонки",
		"supercars_class": "Суперкары",
		"track_class": "Трековые машины",
		"buy": "КУПИТЬ",
		"balance": "БАЛАНС",
		"price": "ЦЕНА",
		"already_owned": "УЖЕ КУПЛЕНО!",
		"insufficient_cash": "НЕДОСТАТОЧНО ДЕНЕГ!",
		"select_car": "Выбор машины",
		"play": "Играть",
		"quit": "Выйти",
		"resume": "Продолжить",
		"retry": "Повторить",
		"volume": "Громкость",
		"upgrades": "Улучшения",
		"car_dealership": "Автосалон",
		"you_win": "ВЫ ПОБЕДИЛИ!",
		"you_lose": "ВЫ ПРОИГРАЛИ!",
		"hp": "Л.с.",
		"weight": "Вес",
		"zero_to_hundred": "0–100 км/ч",
		"top_speed": "Макс. скорость",
		"engine": "Двигатель",
		"aspiration": "Наддув",
		"torque": "Крутящий момент",
		"transmission": "Трансмиссия",
		"country": "Страна",
		"kmh": "км/ч",
		"s": "с",
		"usa": "США",
		"germany": "Германия",
		"japan": "Япония",
		"four_wheel_drive": "Полный привод",
		"rear_wheel_drive": "Задний привод",
		"front_wheel_drive": "Передний привод",
		"4x4_suv": "Внедорожник 4x4",
		"compact_cars": "Компактные",
		"muscle_cars": "Масл-кары"
	},

	"sh": {
		"road_challenge": "Drumski Izazov",
		"free_race": "Slobodna Trka",
		"career_mode": "Karijerni Mod",
		"multi_device": "Više Uređaja",
		"normal_race": "Normalna Trka",
		"radar_race": "Radar Trka",
		"duel": "Duel",
		"elimination": "Eliminacija",
		"cop_chase": "Policijska Potjera",
		"language_options": "Jezičke opcije",
		"colossus": "Colossus Kup",
		"street_tuners": "Street Tuners",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Motori",
		"zenith_competition": "Zenith Takmičenje",
		"businessman_racers": "Biznismeni Trkači",
		"speedster_tournament": "Speedster Turnir",
		"kuro_cup": "Kuro Kup",
		"all_wheel_grip": "Pogon na sve točkove",
		"eisenach_cup": "Eisenach Kup",
		"italy": "Italija",
		"uk": "Ujedinjeno Kraljevstvo",
		"sweden": "Švedska",
		"back": "Nazad",

		"special": "Specijal",
		"executive": "Poslovna Vozila",
		"urban_performance": "Urbana Performansa",
		"sport_coupe": "Sportski Kupe",

		"under_400_hp": "Ispod 400 HP",
		"stingray_competition": "Stingray Takmičenje",
		"schroder_cup": "Schröder Kup",
		"gentleman_racers": "Gentleman Trkači",
		"japanese_cup": "Japanski Kup",
		"german_cup": "Njemački Kup",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "V12 Motori",
		"supercars": "Superautomobili",
		"track_cars": "Trkaći Automobili",
		"sport_racing": "Sportske Trke",
		"special_class": "Specijal",
		"suv_class": "4x4 SUV",
		"compact_class": "Kompaktna Vozila",
		"muscle_class": "Muscle",
		"executive_cars": "Poslovna Vozila",
		"urban_performance_cars": "Urbana Performansa",
		"sport_coupe_class": "Sportski Kupe",
		"sport_racing_class": "Sportske Trke",
		"supercars_class": "Superautomobili",
		"track_class": "Trkaći Automobili",
		"buy": "KUPI",
		"balance": "STANJE",
		"price": "CENA",
		"already_owned": "VEĆ KUPOVANO!",
		"insufficient_cash": "NEDOVOLJNO NOVCA!",
		"select_car": "Izbor vozila",
		"play": "Igraj",
		"quit": "Izlaz",
		"resume": "Nastavi",
		"retry": "Pokušaj ponovo",
		"volume": "Zvuk",
		"upgrades": "Nadogradnje",
		"car_dealership": "Auto Kuća",
		"you_win": "POBJEDA!",
		"you_lose": "PORAZ!",
		"hp": "HP",
		"weight": "Težina",
		"zero_to_hundred": "0–100 km/h",
		"top_speed": "Maksimalna brzina",
		"engine": "Motor",
		"aspiration": "Aspiracija",
		"torque": "Obrtni moment",
		"transmission": "Transmisija",
		"country": "Država",
		"kmh": "km/h",
		"s": "s",
		"usa": "SAD",
		"germany": "Njemačka",
		"japan": "Japan",
		"four_wheel_drive": "Pogon na sve točkove",
		"rear_wheel_drive": "Zadnji pogon",
		"front_wheel_drive": "Prednji pogon",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompaktna vozila",
		"muscle_cars": "Muscle automobili"
	},

	"tr": {
		"road_challenge": "Yol Mücadelesi",
		"free_race": "Serbest Yarış",
		"career_mode": "Kariyer Modu",
		"multi_device": "Çoklu Cihaz",
		"normal_race": "Normal Yarış",
		"radar_race": "Radar Yarışı",
		"duel": "Düello",
		"elimination": "Eleme",
		"cop_chase": "Polis Takibi",
		"language_options": "Dil Seçenekleri",
		"colossus": "Colossus Kupası",
		"street_tuners": "Sokak Tunerları",
		"muscle_hustle": "Muscle Hustle",
		"v6_engines": "V6 Motorlar",
		"italy": "İtalya",
		"uk": "Birleşik Krallık",
		"sweden": "İsveç",
		"back": "Geri",

		"special": "Özel",
		"executive_class": "Yönetici Arabalar",
		"urban_performance": "Kentsel Performans",
		"sport_coupe": "Spor Coupe",

		"zenith_competition": "Zenith Yarışı",
		"businessman_racers": "İş Adamı Yarışçıları",
		"speedster_tournament": "Speedster Turnuvası",
		"kuro_cup": "Kuro Kupası",
		"all_wheel_grip": "Dört Çeker Tutuş",
		"eisenach_cup": "Eisenach Kupası",
		"under_400_hp": "400 Beygir Altı",
		"stingray_competition": "Stingray Yarışı",
		"schroder_cup": "Schröder Kupası",
		"gentleman_racers": "Centilmen Yarışçılar",
		"japanese_cup": "Japon Kupası",
		"german_cup": "Alman Kupası",
		"kestrel_max": "Kestrel Max",
		"v12_engines": "V12 Motorlar",
		"supercars": "Süper Arabalar",
		"track_cars": "Pist Arabaları",
		"sport_racing": "Spor Yarışları",
		"special_class": "Özel",
		"suv_class": "4x4 SUV",
		"compact_class": "Kompakt Arabalar",
		"muscle_class": "Muscle",
		"executive_cars": "Yönetici Arabalar",
		"urban_performance_cars": "Kentsel Performans",
		"sport_coupe_class": "Spor Coupe",
		"sport_racing_class": "Spor Yarışları",
		"supercars_class": "Süper Arabalar",
		"track_class": "Pist Arabaları",
		"buy": "SATIN AL",
		"balance": "BAKİYE",
		"price": "FİYAT",
		"already_owned": "ZATEN SATIN ALINDI!",
		"insufficient_cash": "YETERSİZ PARA!",
		"select_car": "Araba Seç",
		"play": "Oyna",
		"quit": "Çıkış",
		"resume": "Devam Et",
		"retry": "Tekrar Dene",
		"volume": "Ses",
		"upgrades": "Yükseltmeler",
		"car_dealership": "Araba Bayisi",
		"you_win": "KAZANDIN!",
		"you_lose": "KAYBETTİN!",
		"hp": "Beygir Gücü",
		"weight": "Ağırlık",
		"zero_to_hundred": "0–100 km/sa",
		"top_speed": "Azami Hız",
		"engine": "Motor",
		"aspiration": "Besleme",
		"torque": "Tork",
		"transmission": "Şanzıman",
		"country": "Ülke",
		"kmh": "km/sa",
		"s": "sn",
		"usa": "ABD",
		"germany": "Almanya",
		"japan": "Japonya",
		"four_wheel_drive": "Dört Tekerlekten Çekiş",
		"rear_wheel_drive": "Arkadan İtiş",
		"front_wheel_drive": "Önden Çekiş",
		"4x4_suv": "4x4 SUV",
		"compact_cars": "Kompakt Arabalar",
		"muscle_cars": "Muscle Arabalar"
	}
}


func _ready() -> void:
	normalize_dictionary()
	load_language()
# Normalize ANY input into a predictable format
func normalize_key(key: String) -> String:
	var k := key.strip_edges().to_lower()
	k = k.replace(" ", "_")
	k = k.replace("-", "_")
	k = k.replace(".", "_")
	while k.find("__") != -1:
		k = k.replace("__", "_")
	return k

# Find best matching key inside a language dictionary
func find_best_key(lang: String, key: String) -> String:
	var lower := normalize_key(key)

	# Exact match
	if TEXT[lang].has(lower):
		return lower

	# Prefix match (e.g. "career_mode_label" → "career_mode")
	for k in TEXT[lang].keys():
		if lower.begins_with(k):
			return k

	# Word match (e.g. "CAREER MODE" → "club_cups")
	var words := lower.split("_")
	for k in TEXT[lang].keys():
		var kw :PackedStringArray= k.split("_")
		for w in words:
			if w in kw:
				return k

	return ""

# Main translation function
func translate(key: String) -> String:
	var best := find_best_key(LANG, key)
	if best != "":
		return TEXT[LANG][best]

	# fallback to English best match
	var best_en := find_best_key("en", key)
	if best_en != "":
		return TEXT["en"][best_en]

	# IMPORTANT: return key BUT normalized for future matching
	return key

func set_language(code: String) -> void:
	if TEXT.has(code):
		LANG = code
		save_language()

		# Apply font
		if Engine.has_singleton("UiTheme"):
			UiTheme.apply_language_font(LANG)

		# Refresh all UI text
		refresh_ui()

func save_language() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("language", "current", LANG)
	cfg.save("user://settings.cfg")

func load_language() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://settings.cfg") == OK:
		var saved: String = cfg.get_value("language", "current", "en")
		if TEXT.has(saved):
			LANG = saved

	if Engine.has_singleton("UiTheme"):
		UiTheme.apply_language_font(LANG)
func refresh_ui(node: Node = null) -> void:
	if node == null:
		node = get_tree().root

	for child in node.get_children():

		if child is Label or child is Button or child is RichTextLabel:

			# Store original English text ONCE
			if not child.has_meta("original_text"):
				child.set_meta("original_text", child.text)

			var original := str(child.get_meta("original_text"))
			child.text = translate(original)

		refresh_ui(child)
func normalize_dictionary() -> void:
	for lang in TEXT.keys():
		var new_dict := {}
		for key in TEXT[lang].keys():
			var norm := normalize_key(key)
			new_dict[norm] = TEXT[lang][key]
		TEXT[lang] = new_dict
