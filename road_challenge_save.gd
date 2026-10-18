extends Node

var save_path := "user://road_challenge.json"

# ============================================================
# STARTING UNLOCKS
# ============================================================

var unlocked := {
	"suv": true,
	"compact": true,
	"muscle": true,

	"sedans": false,
	"urban": false,
	"sport": false,
	"sport_racing": false,
	"supercars": false,
	"track_cars": false
}

# ============================================================
# PROGRESS
# ============================================================

var progress := {
	"sedans": 0,
	"urban": 0,
	"sport": 0,
	"sport_racing": 0,
	"supercars": 0,
	"track_cars": 0
}

const CLASS_ORDER := [
	"sedans",
	"urban",
	"sport",
	"sport_racing",
	"supercars",
	"track_cars"
]

# ============================================================
# SAVE / LOAD
# ============================================================

func save_progress():

	var data := {
		"unlocked": unlocked,
		"progress": progress
	}

	var file := FileAccess.open(save_path, FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_progress():

	if not FileAccess.file_exists(save_path):
		save_progress()
		return

	var file := FileAccess.open(save_path, FileAccess.READ)

	if not file:
		return

	var text := file.get_as_text()

	file.close()

	var data = JSON.parse_string(text)

	if typeof(data) != TYPE_DICTIONARY:
		return

	if data.has("unlocked"):
		unlocked = data["unlocked"]

	if data.has("progress"):
		progress = data["progress"]

# ============================================================
# CHALLENGE REQUIREMENTS
# ============================================================

func get_required_races(class_id: String) -> int:

	if class_id == "sedans":
		return 2

	return 3

# ============================================================
# REGISTER WIN
# NORMAL RACE ONLY
# ============================================================

func register_win(class_id: String):

	if not progress.has(class_id):
		return

	progress[class_id] += 1

	var required := get_required_races(class_id)

	print(
		class_id,
		" Progress: ",
		progress[class_id],
		"/",
		required
	)

	if progress[class_id] >= required:
		unlock_next_class(class_id)

	save_progress()

# ============================================================
# UNLOCK NEXT CLASS
# ============================================================

func unlock_next_class(class_id: String):

	var idx := CLASS_ORDER.find(class_id)

	if idx == -1:
		return

	if idx >= CLASS_ORDER.size() - 1:
		return

	var next_class :String= CLASS_ORDER[idx + 1]

	if unlocked.get(next_class, false):
		return

	unlocked[next_class] = true

	print("UNLOCKED CLASS: ", next_class)

	save_progress()

# ============================================================
# DEBUG
# ============================================================

func reset_progress():

	unlocked = {
		"suv": true,
		"compact": true,
		"muscle": true,

		"sedans": false,
		"urban": false,
		"sport": false,
		"sport_racing": false,
		"supercars": false,
		"track_cars": false
	}

	progress = {
		"sedans": 0,
		"urban": 0,
		"sport": 0,
		"sport_racing": 0,
		"supercars": 0,
		"track_cars": 0
	}

	save_progress()

	print("Road Challenge reset")
