class_name CarController
extends CharacterBody3D
var wall_recovery_timer := 0.0
var stability_values := {

	# ===== CERTIFIABLY INSANE =====

	"Kestrel Battleaxe": 0.005,     # Sagaris
	"Kestrel Guillotine": 0.010,    # T440R
	"Kestrel Speedster": 0.020,     # Morgan Aero 8
	"Kestrel Seabird": 0.080,       # Exige

	# ===== DANGEROUS =====

	"Brutus Venom": 0.20,
	"Mir Cars Raptor": 0.35,
	"Brutus Thunderbolt": 0.45,

	# ===== SPORTS CARS =====

	"Brutus Stingray": 0.70,
	"Zenith Horizon": 0.80,
	"Bartoli Cruiser": 0.90,

	# ===== NORMAL =====

	"Eisenach Bengal": 1.00,
	"Strandberg Turbo": 1.00,
	"Brutus Goblin": 1.00,

	# ===== GT =====

	"Berkshire Blunt": 1.60,
	"Berkshire Falcon":1.60,
	"Berkshire V12-S": 1.80,
	"Berkshire Tempest": 2.00,
	"Schroder Classique Sport": 2.20,

	# ===== AWD =====

	"Linetti Shepherd": 3.00,
	"Linetti Terror": 3.50,

	# ===== BOATS =====

	"Kuro Vault": 5.00,
	"Mir Cars Blazer": 4.00,

	# ===== SUVS =====

	"Schroder Colosso": 6.00,
	"Mir Cars Nightwolf": 7.00,
	"Colossus Behemoth": 10.00,
	"Colossus Titan Max": 20.00
}
var stability_factor:=1.0
const GRAVITY := 30.0
const ENGINE_BRAKE := 0.5
const DRAG := 0.035
const HARD_LIMIT_KMH := 400.0
const HARD_LIMIT := HARD_LIMIT_KMH / 3.6
var display_hp := 0.0
var display_weight := 0.0
var ai_dodge_timer:=0.0
var ai_dodge_dir:=0.0
var stuck_time := 0.0
var race_finished := false
var clean_drive_timer := 0.0
var oversteer_factor := 1.0
const CLEAN_DRIVE_TIME := 15.0
var unstuck_time := 0.0
var unstucking := false
var nitro_bottles := 4
var max_nitro_bottles := 5
var oversteer_values := {

	# ===== HOMICIDAL =====

	"Kestrel Battleaxe": 25.0,     # Sagaris
	"Kestrel Guillotine": 20.0,    # T440R
	"Kestrel Speedster": 15.0,     # Morgan

	# ===== VERY BAD IDEA =====

	"Kestrel Seabird": 8.0,
	"Brutus Venom": 8.0,

	# ===== SPICY =====

	"Brutus Thunderbolt": 6.0,
	"Mir Cars Raptor": 4.0,
	"Brutus Stingray": 3.0,
	"Zenith Horizon": 2.0,

	# ===== NORMAL =====

	"Eisenach Bengal": 1.0,
	"Bartoli Cruiser": 1.0,
	"Strandberg Turbo": 0.8,

	# ===== STABLE =====

	"Berkshire Blunt": 0.5,
	"Berkshire Falcon":0.5,
	"Berkshire V12-S": 0.4,
	"Berkshire Tempest": 0.4,

	# ===== AWD =====

	"Schroder Classique Sport": 0.15,
	"Linetti Shepherd": 0.10,
	"Linetti Terror": 0.05,

	# ===== BIG CARS =====

	"Kuro Vault": 0.01,
	"Mir Cars Blazer": 0.01,

	# ===== SUVS =====

	"Schroder Colosso": 0.0,
	"Mir Cars Nightwolf": 0.0,
	"Colossus Behemoth": 0.0,
	"Colossus Titan Max": 0.0
}

var drift_charge_timer := 0.0
var nitro_burn_timer := 0.0

const NITRO_CHARGE_TIME := 5.0    # 5 sec drift = 1 bottle
const NITRO_BURN_TIME := 4.0      # 1 bottle lasts 4 sec
var position_label: Label3D = null
var engine_pitch_smoothed := 1.0
var engine_volume_smoothed := -24.0
var engine_time := 0.0
var race_position: int = 1
# --- ROLE FLAGS ---
var is_ai: bool = false
var waypoint_root: Node3D = null
var waypoints: Array[Node] = []
var current_wp: int = 0
var hard_frozen := false
static var used_ai_names: Array[String] = []

func get_unique_ai_name() -> String:
	if used_ai_names.is_empty():
		used_ai_names = ai_names.duplicate()

	var idx := randi() % used_ai_names.size()
	var name := used_ai_names[idx]
	used_ai_names.remove_at(idx)

	return name
var speed_samples := []
var avg_speed := 0.0
var distance_travelled:=0.0
var finished_time: int = -1
var reversing: bool = false
var reverse_speed_limit := 40.0 / 3.6  # 40 km/h in m/s
var has_turbo := false
# --- ENGINE AUDIO PROFILE VARIABLES ---
@export_category("Engine Audio Profile")
@export var audio_base_pitch: float = 1.0       # Starting pitch scale for the engine
@export var audio_pitch_range: float = 1.8      # How much the pitch climbs across RPM range
@export var audio_volume_offset: float = 0.0    # Fine-tunes individual car loudness (in dB)
@export var audio_character_type: int = 0       # 0 = Normal/Standard, 1 = Deep V8/Diesel Growl, 2 = High-Rev VTEC/Exotic
@onready var front_left := $ModelRoot/WheelHolder
@onready var rear_left := $ModelRoot/WheelHolder3

var wheelbase := 2.5
@export var sync_velocity: Vector3
@export var sync_transform: Transform3D
# --- AUDIO NODES ---
@onready var RevPlayer = $RevPlayer
@onready var BrakePlayer = $BrakePlayer
@onready var CrashPlayer = $CrashPlayer
@onready var SkidPlayer = $SkidPlayer
var TurboPlayer: AudioStreamPlayer


# --- SFX PRELOADS ---
const PETROL_AUDIO = preload("res://SFX/petrol.mp3")
const DIESEL_AUDIO = preload("res://SFX/diesel.mp3")
const TURBO_AUDIO = preload("res://SFX/turbo.mp3")
const CRASH_AUDIO = preload("res://SFX/crash.mp3")

# Assign preloads to streams automatically
var petrol_stream: AudioStream = PETROL_AUDIO
var diesel_stream: AudioStream = DIESEL_AUDIO
var turbo_stream: AudioStream = TURBO_AUDIO
var crash_stream: AudioStream = CRASH_AUDIO


# --- AI INPUT ---
var ai_throttle: float = 0.0
var ai_brake: float = 0.0
var ai_steer: float = 0.0
static var ai_names := [
	"David", "Takashi", "Ricco", "Chris", "Petar", "Nina",
	"Steve", "Linus", "Chris", "Jesse", "Dimitri", "Mirko","Jared","Kyle","Victor","Vincent",
	"Abdullah", "Will", "Jimmy M.", "Gandi", "Tiffany", "Hoff", "Jake", "Britney","Laura","Francesca","Looping","Alex","Math","Sam","Gordon"
]

# --- PLAYER INPUT ---
var throttle_input: float = 0.0
var brake_input: float = 0.0
var steer_input: float = 0.0
# --- CAR STATS ---
var mass := 1200.0
var zero_to_hundred := 7.0
var top_speed_kmh := 200.0
var top_speed := 60.0
var turn_speed := 2.5
var brake_strength := 20.0
var lateral_friction := 1.2
var driver_name: String = "Unknown"
var car_name: String = ""
var has_supercharger :=false





var transmission := "Front wheel drive" # "Front wheel drive", "Rear wheel drive", "Four wheel drive"
var is_diesel := false
var nitro_time: float = 0.0
var nitro_cooldown: float = 0.0
var nitro_active: bool = false
var ai_dodge_bias: float = 1.0

var horsepower := 150.0
var max_rpm := 6500.0
var idle_rpm := 900.0
var rpm := 900.0
var torque := 0.0

var gear_count := 6
var gear_ratios := [3.5, 2.1, 1.5, 1.2, 1.0, 0.82]
var current_speed: float = 0.0
var current_gear := 1
var shift_up_rpm := 6200
var shift_down_rpm := 2000
var total_race_time: int = 0
var traffic_dodge := 0.0
var traffic_detect_distance := 20.0


var acceleration_calc := 0.0
var steering := 0.0

var drifting := false
var drift_factor := 0.0
var boost := false
var nitro_top_speed_multiplier := 1.07

var performance_points := 0
var debug_enabled := true
var handling_type := "balanced"

var controls_enabled: bool = true

@export var spawn_yaw_deg: float = 0.0

@onready var car_model := $ModelRoot
@onready var forward_ref := $ForwardRef
@onready var nitro := $Exhaust/GPUParticles3D

# --- OVERTAKING ---
var ai_overtake_offset: float = 0.0
var ai_overtake_side: float = 0.0 # -1 left, +1 right

func apply_stats() -> void:
	# --- APPLY UPGRADES FIRST (Arcade‑clean behavior) ---
	if GameMode.game_mode == "Club Cups" and Cars.upgrades.has(car_name):
		var u = Cars.upgrades[car_name]
		Cars.load_upgrades()

		# Weight Reduction → improves acceleration + top speed slightly
		if u["weight"] > 0:
			var w = u["weight"]
			mass *= (1.0 - 0.05 * w)                 # lighter car
			zero_to_hundred *= (1.0 - 0.04 * w)     # faster 0–100
			
		# Engine Tune → improves HP + top speed
		if u["engine"] > 0:
			var e = u["engine"]
			horsepower *= (1.0 + 0.06 * e)          # more HP
			top_speed_kmh *= (1.0 + 0.03 * e)       # bigger top speed gain

		# Steering Upgrade → improves handling only
		if u["steering"] > 0:
			var s = u["steering"]
			turn_speed *= (1.0 + 0.08 * s)
			lateral_friction *= (1.0 + 0.05 * s)

		# Brake Upgrade → improves braking only
		if u["brakes"] > 0:
			var b = u["brakes"]
			brake_strength *= (1.0 + 0.10 * b)

	# --- ORIGINAL STATS CALC ---
	acceleration_calc = pow(27.78 / zero_to_hundred, 0.875) * 2.8
	torque = (horsepower * 5252.0) / max_rpm

	if is_diesel:
		torque *= 1.6

	top_speed = top_speed_kmh / 3.6

	performance_points = round(
		(top_speed_kmh * 1.5)
		+ (100.0 / zero_to_hundred)
		+ ((horsepower / mass) * 700.0)
	)

func apply_handling_profile() -> void:
	match handling_type:
		"light_sport":
			turn_speed *= 1.25
			lateral_friction *= 1.15
			brake_strength *= 1.1
			mass *= 0.95
		"heavy_muscle":
			turn_speed *= 0.75
			lateral_friction *= 0.85
			brake_strength *= 0.9
			mass *= 1.15
		"luxury_boat":
			turn_speed *= 0.65
			lateral_friction *= 0.8
			brake_strength *= 0.85
			mass *= 1.2
		"awd_grip":
			turn_speed *= 1.05
			lateral_friction *= 1.2
			brake_strength *= 1.1
		"fwd_hot_hatch":
			turn_speed *= 1.15
			lateral_friction *= 1.05
		"supercar":
			turn_speed *= 1.2
			lateral_friction *= 1.3
			brake_strength *= 1.25
			mass *= 0.9
		"balanced":
			pass
var generator_playback: AudioStreamGeneratorPlayback = null
var procedural_generator: AudioStreamGenerator = null
var phase: float = 0.0
# Change this at the top if your old RevPlayer was a node variable, 
# we will now override it safely as a standard AudioStreamPlayer object:

func _ready() -> void:
	# Add this so cars don't block each other via Godot's rigid physics walls
	# --- CAR-TO-CAR COLLISION EXCEPTION ---
	# Automatically tell Godot's physics engine to ignore default solid-wall blocking 
	# between all CarControllers so our custom script can handle the speed math instead.
	var root := get_tree().current_scene
	if root:
		_find_and_add_car_exceptions(root)
	wheelbase = front_left.global_position.distance_to(
	rear_left.global_position
)
	oversteer_factor = oversteer_values.get(
		car_name,
		1.0
	)
	# SUVs
	match car_name:
		"Colossus Titan Max":
			audio_character_type = 1 # American Muscle

		"Colossus Behemoth":
			audio_character_type = 1

		"Schroder Colosso":
			audio_character_type = 6 # Diesel

		"Mir Cars Nightwolf":
			audio_character_type = 0 # Lexus Luxury


		# Compacts

		"Straeda Volant":
			audio_character_type = 3 # Turbo Compact

		"Schroder Atrix Q32":
			audio_character_type = 3

		"Eisenach Bengal":
			audio_character_type = 10 # BMW M

		"Zenith Horizon":
			audio_character_type = 2 # Japanese Exotic


		# Muscle

		"Brutus Viper":
			audio_character_type = 1

		"Mir Cars Hutch":
			audio_character_type = 1


		# Executive

		"Strandberg Turbo":
			audio_character_type = 3
		"Brutus Goblin":
			audio_character_type = 3

		"Kuro Vault":
			audio_character_type = 0 # Lexus V8

		"Zenith Prince":
			audio_character_type = 0

		"Schroder Suppressor":
			audio_character_type = 6


		# Urban Performance

		"Kuro Serenity":
			audio_character_type = 0

		"Kestrel Seabird":
			audio_character_type = 2

		"Kestrel Speedster":
			audio_character_type = 1

		"Mir Cars Blazer":
			audio_character_type = 7 # AMG

		"Berkshire Blunt":
			audio_character_type = 4 # Jaguar SC


		# Sport Coupe

		"Schroder Classique Sport":
			audio_character_type = 3

		"Berkshire Tempest":
			audio_character_type = 8 # Aston V12

		"Brutus Stingray":
			audio_character_type = 1

		"Berkshire V12-S":
			audio_character_type = 8
		"Bartoli Cruiser":
			audio_character_type = 9


		# Sport Racing

		"Kestrel Battleaxe":
			audio_character_type = 5 # TVR

		"Brutus Venom":
			audio_character_type = 11 # Viper V10

		"Linetti Shepherd":
			audio_character_type = 2


		# Supercars

		"Kestrel Guillotine":
			audio_character_type = 5

		"Linetti Firestorm":
			audio_character_type = 2

		"Mir Cars Raptor":
			audio_character_type = 12 # Saleen

		"Linetti Terror":
			audio_character_type = 2


		# Track Cars

		"Bartoli Track Cruiser":
			audio_character_type = 9 # Maserati

		"Brutus Thunderbolt":
			audio_character_type = 1

		"Mir Cars Athletic C70":
			audio_character_type = 2


		# Special

		"Bartoli Cruiser Interceptor":
			audio_character_type = 9 # Maserati
	# --- REV PLAYER SETUP ---
	# --- REV PLAYER SETUP ---
	if RevPlayer:
		# Choose the correct bus for this car's engine type.
		setup_engine_bus()

		# Set the engine recording.
		RevPlayer.stream = diesel_stream if is_diesel else petrol_stream

		# Start the engine.
		RevPlayer.play()

	# --- TURBO PLAYER SETUP ---
	if turbo_stream:
		TurboPlayer = AudioStreamPlayer.new()
		TurboPlayer.name = "TurboPlayer"
		TurboPlayer.stream = turbo_stream
		TurboPlayer.bus = "Master"
		add_child(TurboPlayer)

	# --- CRASH SETUP ---
	if crash_stream and CrashPlayer: 
		CrashPlayer.stream = crash_stream

	apply_stats()
	apply_handling_profile()

	nitro.hide()
	floor_stop_on_slope = false

	if is_ai:
		if used_ai_names.is_empty():
			used_ai_names = ai_names.duplicate()
		var idx := randi() % used_ai_names.size()
		driver_name = used_ai_names[idx]
		used_ai_names.remove_at(idx)
	else:
		driver_name = "Player"

		add_child(position_label)
		position_label.hide()
				
# --- BULLETPROOF RESTART HANDLER ---
func _on_rev_finished() -> void:
	if RevPlayer and RevPlayer.stream:
		RevPlayer.play()	
func update_gears(speed_kmh: float) -> void:
	if rpm > shift_up_rpm and current_gear < gear_count:
		current_gear += 1
		rpm *= 0.6

	if rpm < shift_down_rpm and current_gear > 1:
		current_gear -= 1
		rpm *= 1.3

	current_gear = clamp(current_gear, 1, gear_count)

func _physics_process(delta: float) -> void:
	if is_ai:
		update_position_label()
	if race_finished:
		velocity = velocity.move_toward(
			Vector3.ZERO,
			brake_strength * 2.0 * delta
		)

		move_and_slide()

		if velocity.length() < 0.5:
			velocity = Vector3.ZERO

		return
	if is_multiplayer_authority():
		sync_velocity = velocity
		sync_transform = global_transform
	if not is_multiplayer_authority():
		velocity = sync_velocity
		global_transform = sync_transform
		return
	speed_samples.append(current_speed)
	if speed_samples.size() > 60: # last 1 second
		speed_samples.pop_front()

	var sum := 0.0
	for s in speed_samples:
		sum += s
	avg_speed = sum / speed_samples.size()

	if not controls_enabled:
		if not is_on_floor():
			velocity.y -= GRAVITY * delta
		move_and_slide()
		velocity.y = -0.01
		return

	# --- UPDATE WAYPOINT FIRST ---
	# --- UPDATE WAYPOINT FIRST ---
	update_waypoint()
	# Smooth the distance to prevent jitter


	if is_ai:
		_update_ai_inputs(delta)
		throttle_input = ai_throttle
		brake_input = ai_brake
		steer_input = ai_steer
	else:
		throttle_input = Input.get_action_strength("accelerate")
		brake_input = Input.get_action_strength("brake")
		steer_input = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	# --- REVERSE TOGGLE ---
		if not is_ai:
			if Input.is_action_just_pressed("reverse"):
				reversing = not reversing
				if reversing:
					current_gear = -1
				else:
					current_gear = 1

	_drive(delta, throttle_input, brake_input, steer_input)
	total_race_time += int(delta * 1000)
	
	if hard_frozen:
		velocity = Vector3.ZERO
		return
	# Track distance travelled
	distance_travelled += velocity.length() * delta







func _drive(delta: float, accel: float, brake: float, steer: float) -> void:
	
	var drift_input := false
	var nitrous := false

	if not is_ai:
		if Input.is_action_pressed("drift"):
			drift_input = true

	# BOTTLE-BASED NITRO

	if not is_ai:

		if Input.is_action_just_pressed("nos"):

			# Turn OFF nitro and keep remaining bottle time
			if nitro_active:

				nitro_active = false

			# Turn ON nitro if we have bottles
			elif nitro_bottles > 0:

				nitro_active = true

				# Only start a fresh bottle if not already partially used
				if nitro_burn_timer <= 0.0:
					nitro_burn_timer = NITRO_BURN_TIME

		if nitro_active:

			nitro_burn_timer -= delta

			if nitro_burn_timer <= 0.0:
				nitro_active = false
				nitro_bottles -= 1


	var target_drift := 0.0
	if drift_input:
		target_drift = 1.0
	if not nitro_active and not drifting and accel > 0.1:
		clean_drive_timer += delta

		if clean_drive_timer >= CLEAN_DRIVE_TIME:
			clean_drive_timer = 0.0

			if nitro_bottles < max_nitro_bottles:
				nitro_bottles += 1
	else:
			clean_drive_timer = 0.0
	drift_factor = lerp(drift_factor, target_drift, delta * 6.0)
	drifting = drift_factor > 0.1
	# DRIFT TO CHARGE NITRO
	if drifting and current_speed > 40.0:
		drift_charge_timer += delta

		if drift_charge_timer >= NITRO_CHARGE_TIME:
			drift_charge_timer = 0.0

			if nitro_bottles < max_nitro_bottles:
				nitro_bottles += 1
	else:
		# Optional: keep progress between drifts
		pass
	if drifting:
		if not SkidPlayer.playing:
			SkidPlayer.play()
		else:
			if SkidPlayer.playing:
				SkidPlayer.stop()
	steering = lerp(
	steering,
	steer,
	delta * 3.5
)

	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var right := transform.basis.x.normalized()

	var sideways_speed := velocity.dot(right)
	sideways_speed = lerp(sideways_speed, 0.0, delta * 8.0)

	var speed := velocity.length()
	var speed_kmh := speed * 3.6
	
	var throttle_steer := 0.0
	var wheelbase_stability :float= clamp(
	wheelbase / 2.7,
	0.80,
	1.35
)

	var wheelbase_agility :float= clamp(
		2.7 / wheelbase,
		0.75,
		1.40
	)
	# --- CAR ORIENTATION ---
	if not drifting:
	
		var steering_factor := wheelbase_agility

		if speed_kmh > 120.0:
			steering_factor *= lerp(
				1.0,
				0.65,
				clamp(
					(speed_kmh - 120.0) / 120.0,
					0.0,
					1.0
				)
			)
		if car_name == "Kestrel Battleaxe":

			if speed_kmh > 180.0:

				rotation.y += randf_range(
					-0.0015,
					0.0015
				)

		elif car_name == "Kestrel Guillotine":

			if speed_kmh > 200.0:

				rotation.y += randf_range(
					-0.0010,
					0.0010
				)
		if car_name == "Kestrel Speedster":

				if abs(steering) > 0.6:

					lateral_friction *= 0.75
		if car_name == "Kestrel Seabird":

			steering_factor *= 1.4
		rotate_y(
			steering
			* turn_speed
			* steering_factor
			* delta
		)

		lateral_friction = 1.2
	
	else:
		var drift_steer := steering * (turn_speed * 0.35)
		rotation.y += drift_steer * delta
		var slip_strength := 2.0 * drift_factor
		var grip :float= clamp(lateral_friction * 0.8, 0.0, 1.0)
		velocity = velocity.rotated(Vector3.UP, throttle_steer * grip * delta)
		lateral_friction = lerp(1.2, 0.12, drift_factor)

	car_model.rotation_degrees.z = lerp(car_model.rotation_degrees.z, -steering * 10.0, delta * 8.0)

	forward = -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	right = transform.basis.x.normalized()

	var wall_block := false
	var wall_scrape := false

	# --- UNIFIED COLLISION HANDLING ---
	# --- UNIFIED COLLISION HANDLING ---
	# --- UNIFIED COLLISION HANDLING ---
	# --- UNIFIED COLLISION HANDLING ---
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()
		
		# Check purely by node type
		if other is CarController:
			var other_car := other as CarController

			var my_forward := -transform.basis.z
			my_forward.y = 0.0
			my_forward = my_forward.normalized()

			var other_forward := -other_car.transform.basis.z
			other_forward.y = 0.0
			other_forward = other_forward.normalized()

			var to_other := (other_car.global_position - global_position).normalized()

			var behind_them := other_forward.dot(-to_other) > 0.5
			var same_direction := my_forward.dot(other_forward) > 0.7
			var rear_end := behind_them and same_direction

			if rear_end:
				# 1. Hitter keeps 65% speed (loses exactly 35%)
				var flat := Vector3(velocity.x, 0.0, velocity.z)
				if flat.length() > 0.0:
					flat *= 0.65
					velocity.x = flat.x
					velocity.z = flat.z
					sync_velocity = velocity

				# 2. Dynamically ignore the blocking collision for a split second 
				#    so Godot doesn't dead-stop your 65% velocity, then reset it.
				add_collision_exception_with(other_car)
				other_car.add_collision_exception_with(self)
				
				get_tree().create_timer(0.2).timeout.connect(func():
					if is_instance_valid(self) and is_instance_valid(other_car):
						remove_collision_exception_with(other_car)
						other_car.remove_collision_exception_with(self)
				)

				# Car being rear-ended is scot-free (no speed penalty, no push)
				continue
			else:
				# Side-swipes / head-ons (normal collision physics & bouncing)
				var hit_dir := (other_car.global_position - global_position).normalized()
				hit_dir.y = 0.0
				var mass_ratio :float= mass / max(other_car.mass, 1.0)

				if mass_ratio < 0.8:
					var bounce_dir := (global_position - other_car.global_position).normalized()
					bounce_dir.y = 0.0
					velocity = bounce_dir * (velocity.length() * 0.5)
				else:
					var speed_retention :float = clamp(
	0.85 + (mass_ratio - 1.0) * 0.08,
	0.75,
	0.98
)
					velocity *= speed_retention
					var shove_force := velocity.length() * mass_ratio * 0.2
					other_car.velocity += hit_dir * shove_force
				
				continue
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()
		
		# Raw normal
		var n := col.get_normal()
		n.y = 0.0
		n = n.normalized()

		# --- PROP PUSH (RigidBody3D) ---
		if other is RigidBody3D:
			var flat_n := Vector3(n.x, 0.0, n.z).normalized()
			var mass_factor :float= clamp(1200.0 / mass, 0.4, 1.0)
			var push_force :float= clamp(velocity.length() * 0.10, 1.0, 5.0) * mass_factor

			var impulse_pos := global_position
			impulse_pos.y -= 0.45

			# Ignore upward normals (ramps)
			if col.get_normal().y <= 0.25:
				other.apply_impulse(-flat_n * push_force, impulse_pos)

			# Stabilize car
			velocity.y = min(velocity.y, 0.0)
			rotation_degrees.x = lerp(rotation_degrees.x, 0.0, delta * 8.0)
			rotation_degrees.z = lerp(rotation_degrees.z, 0.0, delta * 8.0)

			continue

		# --- SEAM FILTER (IGNORE MICRO NORMALS) ---
		if n.length() < 0.45:
			continue

		# Ignore normals pointing upward (floor seams)
		if n.dot(Vector3.UP) > 0.55:
			continue

		# Use the forward/right already computed earlier in _drive()
		var front_dot := forward.dot(n)
		var side_dot := right.dot(n)

		# Ignore normals not facing the car
		if front_dot > -0.45:
			continue

		# Ignore normals not strongly sideways
		if abs(side_dot) < 0.35:
			continue

		# --- REAL WALL DETECTED ---
		if front_dot < -0.85:
			wall_block = true

		if abs(side_dot) > 0.55:
			wall_scrape = true

	# --- RPM & GEARS ---
	#Good
	if speed_kmh < 2.0:
		if accel > 0.1:
			rpm = lerp(rpm, idle_rpm + 2500.0, delta * 2.5)
		else:
			rpm = lerp(rpm, idle_rpm, delta * 3.0)
	else:
		var gear_index: int = clamp(current_gear - 1, 0, gear_ratios.size() - 1)
		var wheel_rpm: float = speed_kmh * gear_ratios[gear_index] * 35.0
		rpm = lerp(rpm, wheel_rpm, delta * 4.0)

	rpm = clamp(rpm, idle_rpm, max_rpm)
	update_gears(speed_kmh)
	var rpm_ratio := rpm / max_rpm
	# --- RPM & GEARS ---
	# --- RPM & GEARS ---
	if reversing:

		rpm = lerp(
			rpm,
			idle_rpm + (speed_kmh * 60.0),
			delta * 4.0
		)

		rpm = clamp(rpm, idle_rpm, 3500.0)

	elif speed_kmh < 2.0:

		if accel > 0.1:
			rpm = lerp(rpm, idle_rpm + 2500.0, delta * 2.5)
		else:
			rpm = lerp(rpm, idle_rpm, delta * 3.0)

	else:

		var gear_index: int = clamp(current_gear - 1, 0, gear_ratios.size() - 1)
		var wheel_rpm: float = speed_kmh * gear_ratios[gear_index] * 35.0
		rpm = lerp(rpm, wheel_rpm, delta * 4.0)
	rpm = clamp(rpm, idle_rpm, max_rpm)
	update_gears(speed_kmh)

	# UPDATE ENGINE AUDIO HERE
	update_engine_audio(delta, accel, speed_kmh)

	# --- CODE REV PLAYER UPDATE ---
	# --- CODE REV PLAYER UPDATE ---
	# --- REV PLAYER UPDATE ---
	# --- REV PLAYER & TURBO BLEND UPDATE ---
	# --- DYNAMIC VOLUME SCALING (RPM, Gearing, Nitro) ---
	# --- REVPLAYER AUDIO UPDATE (RPM, Gearing, Nitro, Turbo, Supercharger) ---
	# --- REVPLAYER AUDIO UPDATE (Music-Friendly Balance) ---
	# --- REVPLAYER AUDIO UPDATE (Realistic Cruise & Hum) ---
	# --- REVPLAYER AUDIO UPDATE (With Idle Rumble) ---
	# --- REVPLAYER AUDIO UPDATE (Crackling Fixed & True Highway Cruise) ---
	# --- REVPLAYER AUDIO UPDATE (For Idle-to-Rev Audio Files) ---
	# --- REVPLAYER AUDIO UPDATE (Handling Full Throttle at Top Speed) ---
	var torque_factor := (
		0.5
		+ sin(rpm_ratio * PI * 0.5) * 0.5
	)

	# --- DRIVETRAIN ---
	# --- DRIVETRAIN ---

	# --- DRIVETRAIN ---

	var traction_factor := 1.0
	var launch_grip := 1.0

	var twitch_factor := 1.0 / (
	stability_factor * stability_factor
)
	if transmission == "Front wheel drive":

		lateral_friction = lerp(
			lateral_friction,
			1.08,
			delta * 2.0
		)

		if speed_kmh > 80.0:
			steering *= lerp(
				1.0,
				0.88,
				clamp(speed_kmh / 250.0, 0.0, 1.0)
			)

		if accel > 0.8 and speed_kmh < 60.0:

			var torque_steer :float= 0.12 * twitch_factor

			if steer > 0.0:
				rotation.y += torque_steer * delta
			else:
				rotation.y -= torque_steer * delta

		if speed_kmh > 100.0:

			var forward_velocity := forward * velocity.dot(forward)

			velocity = velocity.lerp(
				forward_velocity,
				stability_factor * 0.08 * delta
			)

	elif transmission == "Rear wheel drive":

		lateral_friction = lerp(
			lateral_friction,
			0.92,
			delta * 2.0
		)

		var instability :float = clamp(
			1.0 / max(stability_factor, 0.75),
			0.75,
			2.0
		)

		var yaw_boost :float = clamp(
			speed_kmh / 140.0,
			0.0,
			1.0
		)

		# Natural chassis rotation

		velocity = velocity.rotated(
			Vector3.UP,
			steering
			* yaw_boost
			* 0.08
			* delta
		)

		# Power oversteer

		if accel > 0.60 and speed_kmh > 30.0:

			var oversteer_strength :float = (
				accel
				* oversteer_factor
				* instability
			)

			velocity = velocity.rotated(
				Vector3.UP,
				steering
				* oversteer_strength
				* 0.018
				* delta
			)

			lateral_friction *= lerp(
				1.0,
				0.80,
				accel
			)

		# Wheelspin

		if accel > 0.90 and speed_kmh < 50.0:

			var wheelspin :float = clamp(
				horsepower / 800.0,
				0.0,
				0.30
			)

			lateral_friction *= (
				1.0
				- wheelspin
			)

		# Lift-off oversteer

		if accel < 0.15 and speed_kmh > 100.0:

			velocity = velocity.rotated(
				Vector3.UP,
				steering
				* instability
				* 0.025
				* delta
			)

		var forward_velocity := (
			forward
			* velocity.dot(forward)
		)

		# Slower self-correction

		velocity = velocity.lerp(
			forward_velocity,
			stability_factor * 0.03 * delta
		)

		# High-speed stability

		if speed_kmh > 180.0:

			velocity = velocity.lerp(
				forward_velocity,
				0.04 * delta
			)

		# Luxury GT behaviour

		if car_name == "Kuro Vault":

			lateral_friction *= 1.15

			velocity = velocity.lerp(
				forward_velocity,
				0.15 * delta
			)
	
	elif transmission == "Four wheel drive":

		lateral_friction = lerp(
			lateral_friction,
			1.35,
			delta * 4.0
		)

		traction_factor = 1.20
		launch_grip = 1.35

		var yaw_boost :float = clamp(
			speed_kmh / 140.0,
			0.0,
			1.0
		)

		# Much less rotation than RWD
		velocity = velocity.rotated(
			Vector3.UP,
			steering
			* yaw_boost
			* 0.05
			* delta
		)

		# AWD pulls itself straight under throttle
		if accel > 0.5:

			var throttle_grip := (
				forward
				* velocity.dot(forward)
			)

			velocity = velocity.lerp(
				throttle_grip,
				0.30 * delta
			)

		# Massive high-speed stability
		if speed_kmh > 100.0:

			var forward_velocity := (
				forward
				* velocity.dot(forward)
			)

			velocity = velocity.lerp(
				forward_velocity,
				stability_factor * 0.22 * delta
			)

		# Extra corner exit grip
		if accel > 0.8:
			lateral_friction *= 1.15
# Higher stability = calmer
# Lower stability = twitchier


	if speed_kmh > 140.0:

		var stability_strength :float= clamp(
			(wheelbase - 2.4) * 0.15,
			0.0,
			0.25
		)

		velocity = velocity.lerp(
			forward * velocity.dot(forward),
			stability_strength * delta
		)
	wall_recovery_timer = max(
	0.0,
	wall_recovery_timer - delta
)
	if accel > 0.0:

		if wall_block:
			velocity *= 0.9

		if wall_scrape:
			velocity *= 0.95
		if wall_block:
			wall_recovery_timer = 1.0

		if wall_scrape:
			wall_recovery_timer = max(
				wall_recovery_timer,
				0.5
			)

		if nitro_active:

			nitro.show()
			nitro_top_speed_multiplier = 1.10

		else:

			nitro.hide()
			nitro_top_speed_multiplier = 1.0

		var target_speed := top_speed_kmh

		if nitro_active:
			target_speed *= nitro_top_speed_multiplier

		# Base acceleration from 0-100

		var accel_rate :float = (
			100.0
			/ max(zero_to_hundred, 0.1)
		)

		# Turbo

		if has_turbo:

			if rpm_ratio < 0.35:
				accel_rate *= 0.85

			elif rpm_ratio < 0.60:
				accel_rate *= 1.25

			elif rpm_ratio < 0.85:
				accel_rate *= 1.40

			else:
				accel_rate *= 1.10

		# Supercharger

		elif has_supercharger:

			accel_rate *= lerp(
				1.05,
				1.20,
				rpm_ratio
			)

		# N/A

		else:

			accel_rate *= lerp(
				0.95,
				1.10,
				rpm_ratio
			)

		# Drivetrain

		if transmission == "Four wheel drive":
			accel_rate *= 1.06

		elif transmission == "Rear wheel drive":
			accel_rate *= 0.99

		# Diesel

		if is_diesel:

			var diesel_ratio :float= clamp(
				speed_kmh / 160.0,
				0.0,
				1.0
			)

			accel_rate *= lerp(
				0.75,
				1.25,
				sqrt(diesel_ratio)
			)

		# NOS

		if nitro_active:
			accel_rate *= 1.35

		# Build speed naturally

		var speed_ratio :float= clamp(
			speed_kmh / target_speed,
			0.0,
			1.0
		)

		# Only start dying near vmax

		if speed_ratio > 0.85:

			accel_rate *= lerp(
				1.0,
				0.55,
				(speed_ratio - 0.85) / 0.15
			)

		var forward_speed := current_speed

		forward_speed = move_toward(
			forward_speed,
			target_speed,
			accel_rate * 4.0 * delta
		)

		if nitro_active:
			forward_speed += 4.0 * delta

		var desired_speed := forward_speed / 3.6

		var current_forward_speed := velocity.dot(forward)

		var speed_difference := (
			desired_speed
			- current_forward_speed
		)

		var recovery_factor := 0.30

		if wall_recovery_timer > 0.0:

			recovery_factor *= 0.45

		velocity += forward * speed_difference * recovery_factor

	else:

		var flat := Vector3(
			velocity.x,
			0.0,
			velocity.z
		)

		var brake_power := ENGINE_BRAKE

		if drifting:
			brake_power *= 0.05

		flat = flat.move_toward(
			Vector3.ZERO,
			brake_power * delta
		)

		velocity.x = flat.x
		velocity.z = flat.z
	if brake > 0.1:
		# --- WALL COLLISION RESPONSE ---

		if wall_block:

			velocity.x *= 0.95
			velocity.z *= 0.95

		if wall_scrape:

			velocity.x *= 0.99
			velocity.z *= 0.99
		var brake_force := brake_strength * (mass / 1200.0) * 1.4
		velocity = velocity.move_toward(Vector3.ZERO, brake_force * delta)
		if not BrakePlayer.playing:
			BrakePlayer.play()

	if wall_scrape:

		velocity += forward * 10.0 * delta


	var flat2 := Vector3(velocity.x, 0, velocity.z)
	var current_top_speed := top_speed
	if nitro_active:
		current_top_speed = top_speed * nitro_top_speed_multiplier

	if flat2.length() > current_top_speed:
		flat2 = flat2.normalized() * current_top_speed

	velocity.x = flat2.x
	velocity.z = flat2.z

	if not is_ai and controls_enabled:
			Global.speed = SpeedSettings.convert_speed(speed_kmh)
			Global.gear = current_gear
			Global.speed_unit = SpeedSettings.get_unit_label()
			Global.tachometer = rpm # Added digital tachometer tracking
			Global.nitro_bottles = nitro_bottles
			Global.nitro_active = nitro_active
			Global.nitro_timer = nitro_burn_timer

			if reversing:
				Global.gear = -1
			else:
				Global.gear = current_gear

	current_speed = speed_kmh

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = -0.01

	var flat_safe := Vector3(velocity.x, 0, velocity.z)
	if flat_safe.length() > HARD_LIMIT:
		flat_safe = flat_safe.normalized() * HARD_LIMIT
		velocity.x = flat_safe.x
		velocity.z = flat_safe.z

	velocity.y = clamp(velocity.y, -HARD_LIMIT, HARD_LIMIT)
	

	move_and_slide()
	if wall_block:

		var speed_restore :float= max(
			speed_kmh * 0.9,
			top_speed_kmh * 0.5
		)

		velocity = forward * (speed_restore / 3.6)
func set_waypoints(root: Node3D) -> void:
	waypoint_root = root
	waypoints = root.get_children()
	waypoints.sort_custom(_ai_sort_wp)
	current_wp = 0
	current_wp = _find_closest_waypoint()

	

func _ai_sort_wp(a: Node, b: Node) -> bool:
	var na_str := a.name.strip_edges().to_upper()
	var nb_str := b.name.strip_edges().to_upper()

	if na_str.begins_with("WP"):
		na_str = na_str.substr(2)
	if nb_str.begins_with("WP"):
		nb_str = nb_str.substr(2)

	var na := int(na_str) if na_str.is_valid_int() else 99999
	var nb := int(nb_str) if nb_str.is_valid_int() else 99999

	return na < nb

func _update_ai_inputs(delta: float) -> void:
	if waypoints.is_empty():
		ai_throttle = 0.0
		ai_brake = 1.0
		ai_steer = 0.0
		return

	var wp := waypoints[current_wp] as Node3D
	var target := wp.global_position
	var to_wp := target - global_position
	var dist := to_wp.length()

	if dist < 6.0:
		current_wp = (current_wp + 1) % waypoints.size()

	var dir := to_wp.normalized()
	var forward := -transform.basis.z
	forward = forward.normalized()

	var dot := forward.dot(dir)
	if dot < -0.4:
		current_wp = (current_wp + 1) % waypoints.size()
		return

	# Scan traffic with persistent dodge memory
	traffic_dodge = _check_traffic(delta)

	var angle := forward.signed_angle_to(dir, Vector3.UP)
	
	# --- AGGRESSIVE OVERTAKE & DODGE OVERRIDE ---
	if traffic_dodge != 0.0:
		# Steer sharply away from the obstacle, but FORCE forward throttle
		ai_steer = clamp(traffic_dodge * 2.5, -1.0, 1.0) 
		ai_throttle = 1.0       # Keep full forward throttle
		ai_brake = 0.0          # Absolutely no braking or reversing
	else:
		ai_steer = clamp(angle * 2.0, -1.0, 1.0)
		ai_throttle = 1.0
		ai_brake = 0.0
		if abs(angle) > 0.7:
			ai_brake = 0.15
	if avg_speed < 5.0:
		stuck_time += delta
	else:
		stuck_time = 0.0

	if stuck_time > 2.0 and not unstucking:
		unstucking = true
		unstuck_time = 1.5
		reversing = true
		stuck_time = 0.0

	if unstucking:
		unstuck_time -= delta

		ai_throttle = 1.0
		ai_brake = 0.0

		if traffic_dodge != 0.0:
			ai_steer = -traffic_dodge
		else:
			ai_steer = randf_range(-1.0, 1.0)

		if unstuck_time <= 0.0:
			unstucking = false
			reversing = false

		return
			
func update_waypoint():
	if is_ai:
		_update_ai_waypoint()
	else:
		_update_player_waypoint()

func _find_nearest_car() -> CarController:
	var nearest: CarController = null
	var best_dist := 99999.0

	for body in get_tree().get_nodes_in_group("cars"):
		if body == self:
			continue
		if not (body is CarController):
			continue

		var cc := body as CarController
		var d := cc.global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			nearest = cc

	return nearest


func _find_closest_waypoint() -> int:
	var best := 0
	var best_dist := 999999.0
	for i in range(waypoints.size()):
		var d :int= waypoints[i].global_position.distance_to(global_position)
		if d < best_dist:
			best_dist = d
			best = i
	return best

func _update_player_waypoint():
	if waypoints.is_empty():
		return

	var wp := waypoints[current_wp] as Node3D

	var to_wp := wp.global_position - global_position
	to_wp.y = 0.0

	var dist := to_wp.length()

	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var dir := to_wp.normalized()
	var dot := forward.dot(dir)

	# Normal hit
	if dist < 12.0:
		current_wp = (current_wp + 1) % waypoints.size()
		return

	# Forgiveness: waypoint passed behind car
	if dot < -0.3:
		current_wp = (current_wp + 1) % waypoints.size()
		return

func _update_ai_waypoint():
	if waypoints.is_empty():
		return

	var wp := waypoints[current_wp] as Node3D
	var to_wp := wp.global_position - global_position
	to_wp.y = 0.0

	var dist := to_wp.length()

	# Skip waypoint if too close
	if dist < 8.0:
		current_wp = (current_wp + 1) % waypoints.size()
		return

	var dir := to_wp.normalized()
	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var dot := forward.dot(dir)

	# If waypoint is behind the car, skip it
	if dot < -0.2:
		current_wp = (current_wp + 1) % waypoints.size()
		return


func distance_to_finish_line(lapline: Node3D) -> float:
	return global_position.distance_to(lapline.global_position)
	
func distance_to_next_wp() -> float:
	if waypoints.is_empty():
		return 0.0

	var wp := waypoints[current_wp] as Node3D
	return global_position.distance_to(wp.global_position)
func distance_travelled_in_current_lap() -> float:
	if waypoints.is_empty():
		return 0.0

	# Compute full lap length
	var lap_dist: float = 0.0
	for i in range(waypoints.size()):
		var a: Vector3 = waypoints[i].global_position
		var b: Vector3 = waypoints[(i + 1) % waypoints.size()].global_position
		lap_dist += a.distance_to(b)

	# Distance covered so far in this lap
	var dist: float = 0.0
	for i in range(current_wp):
		var a: Vector3 = waypoints[i].global_position
		var b: Vector3 = waypoints[(i + 1) % waypoints.size()].global_position
		dist += a.distance_to(b)

	# Add partial segment from car to next waypoint
	var next_wp := waypoints[current_wp] as Node3D
	dist += global_position.distance_to(next_wp.global_position)

	# Clamp to lap length
	return clamp(dist, 0.0, lap_dist)

func _check_traffic(delta: float) -> float:
	var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var right := transform.basis.x.normalized()
	
	# Raise the origin slightly above the car body to prevent false self-hits
	var origin := global_position + Vector3.UP * 0.8
	
	# 1. Cast a wider, longer check ahead (look 25 meters out)
	var front_query := PhysicsRayQueryParameters3D.create(origin, origin + forward * 25.0)
	front_query.exclude = [get_rid()]
	var hit := space.intersect_ray(front_query)
	
	if not hit.is_empty():
		var collider = hit.get("collider")
		
		# Check if we are looking at another car (Traffic or AI)
		if collider and (collider is CharacterBody3D) and collider != self:
			
			# Check left and right clearance to see which escape route is open
			var left_origin = origin - right * 1.5
			var right_origin = origin + right * 1.5
			
			var left_query := PhysicsRayQueryParameters3D.create(left_origin, left_origin + forward * 15.0)
			left_query.exclude = [get_rid()]
			var left_hit := space.intersect_ray(left_query)
			
			var right_query := PhysicsRayQueryParameters3D.create(right_origin, right_origin + forward * 15.0)
			right_query.exclude = [get_rid()]
			var right_hit := space.intersect_ray(right_query)
			
			var left_clear = left_hit.is_empty()
			var right_clear = right_hit.is_empty()
			
			# Steer toward whichever side is actually clear!
			if left_clear and not right_clear:
				return -1.0 # Steer Left safely
			elif right_clear and not left_clear:
				return 1.0  # Steer Right safely
			elif left_clear and right_clear:
				# Both open? Check where the car is relative to us and go opposite
				var to_other = collider.global_position - global_position
				var side_dot = right.dot(to_other.normalized())
				return -1.0 if side_dot >= 0.0 else 1.0
			else:
				# Both sides blocked, default to a safe side instead of freezing/reversing
				return 1.0
				
	return 0.0 # Path completely clear, no dodge needed
	if not hit.is_empty():
		var collider = hit["collider"]

		if collider is StaticBody3D:
			var normal : Vector3 = hit["normal"]

			# Ignore roads, hills and ramps
			if normal.y > 0.25:
				return 0.0

			var left_query := PhysicsRayQueryParameters3D.create(
				origin,
				origin - right * 4.0 + forward * 8.0
			)
			left_query.exclude = [get_rid()]

			var right_query := PhysicsRayQueryParameters3D.create(
				origin,
				origin + right * 4.0 + forward * 8.0
			)
			right_query.exclude = [get_rid()]

			var left_hit := space.intersect_ray(left_query)
			var right_hit := space.intersect_ray(right_query)

			var left_clear := true
			var right_clear := true

			if not left_hit.is_empty():
				var left_normal : Vector3 = left_hit["normal"]

				if left_normal.y < 0.25:
					left_clear = false

			if not right_hit.is_empty():
				var right_normal : Vector3 = right_hit["normal"]

				if right_normal.y < 0.25:
					right_clear = false

			if left_clear and not right_clear:
				return -1.0

			if right_clear and not left_clear:
				return 1.0

			if left_clear and right_clear:
				if randf() < 0.5:
					return -1.0
				else:
					return 1.0

			return 0.0
func update_position_label() -> void:
	if not is_ai:
		return
	ensure_position_label()
	if position_label == null:
		return

	var show_label :bool= (
		Modes.mode == "Normal Race"
		or Modes.mode == "Duel"
		or Modes.mode == "Elimination"
	)

	position_label.visible = show_label

	if not show_label:
		return

	position_label.text = get_position_text()
func get_position_text() -> String:
	match race_position:
		1:
			return "1st"
		2:
			return "2nd"
		3:
			return "3rd"
		_:
			return str(race_position) + "th"
func ensure_position_label():
	if position_label != null:
		return

	position_label = Label3D.new()
	position_label.name = "PositionLabel"
	position_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	position_label.position = Vector3(0, 4.0, 0)
	position_label.pixel_size = 0.02
	position_label.modulate = Color.YELLOW
	position_label.text = "1st"

	add_child(position_label)


func update_engine_audio(delta: float, accel: float, speed_kmh: float) -> void:
	if not is_instance_valid(RevPlayer):
		return

	if not RevPlayer.playing:
		RevPlayer.play()

	engine_time += delta

	var rpm_ratio: float = clamp(
		(rpm - idle_rpm) / max(max_rpm - idle_rpm, 1.0),
		0.0,
		1.0
	)

	var load: float = clamp(accel, 0.0, 1.0)
	var curve: float = rpm_ratio
	var pitch_range: float = 0.8
	var throttle_response: float = 0.2
	var idle_db: float = -25.0
	var load_db: float = -8.0
	var rumble: float = 0.0
	var rumble_speed: float = 10.0
	var rasp: float = 0.0
	var rasp_speed: float = 30.0

	# Each family has its own RPM curve and sound behavior.
	match audio_character_type:

			0: # Luxury V8 (LS400, LX470)

				curve = pow(rpm_ratio, 1.8)
				pitch_range = 0.25
				throttle_response = 0.06

				idle_db = -32.0
				load_db = -16.0

				rumble = 0.002
				rumble_speed = 2.5

				rasp = 0.0
				rasp_speed = 0.0

			1: # American Muscle V8 (GT500, Chevelle, Cobra)

				curve = pow(rpm_ratio, 0.75)
				pitch_range = 0.70
				throttle_response = 0.25

				idle_db = -18.0
				load_db = -4.0

				rumble = 0.050
				rumble_speed = 6.0

				rasp = 0.010
				rasp_speed = 22.0

			2: # High Rev Exotic (Gallardo, Diablo, Murcielago, Zonda)

				curve = pow(rpm_ratio, 2.20)
				pitch_range = 1.90
				throttle_response = 0.45

				idle_db = -26.0
				load_db = -2.0

				rumble = 0.005
				rumble_speed = 10.0

				rasp = 0.040
				rasp_speed = 58.0

			3: # Turbo Four (TT, Mini, Volvo)

				curve = pow(rpm_ratio, 1.25)
				pitch_range = 1.45
				throttle_response = 0.65

				idle_db = -24.0
				load_db = -5.0

				rumble = 0.012
				rumble_speed = 16.0

				rasp = 0.025
				rasp_speed = 65.0

			4: # Supercharged Jaguar (XKR)

				curve = pow(rpm_ratio, 1.35)
				pitch_range = 1.00
				throttle_response = 0.35

				idle_db = -22.0
				load_db = -3.0

				rumble = 0.010
				rumble_speed = 12.0

				rasp = 0.030
				rasp_speed = 35.0

			5: # TVR (Tuscan, Sagaris)

				curve = pow(rpm_ratio, 1.45)
				pitch_range = 2.10
				throttle_response = 0.80

				idle_db = -16.0
				load_db = -1.0

				rumble = 0.070
				rumble_speed = 22.0

				rasp = 0.055
				rasp_speed = 75.0

			6: # Diesel

				curve = pow(rpm_ratio, 0.55)
				pitch_range = 0.35
				throttle_response = 0.12

				idle_db = -12.0
				load_db = 0.0

				rumble = 0.060
				rumble_speed = 4.0

				rasp = 0.0
				rasp_speed = 0.0

			7: # AMG V8

				curve = pow(rpm_ratio, 1.0)
				pitch_range = 0.90
				throttle_response = 0.38

				idle_db = -20.0
				load_db = -2.0

				rumble = 0.025
				rumble_speed = 10.0

				rasp = 0.015
				rasp_speed = 34.0

			8: # Aston Martin V12 (DB9, Vanquish)

				curve = pow(rpm_ratio, 1.8)
				pitch_range = 1.40
				throttle_response = 0.30

				idle_db = -27.0
				load_db = -3.0

				rumble = 0.003
				rumble_speed = 5.0

				rasp = 0.015
				rasp_speed = 32.0

			9: # Maserati V8

				curve = pow(rpm_ratio, 1.45)
				pitch_range = 1.20
				throttle_response = 0.40

				idle_db = -22.0
				load_db = -3.0

				rumble = 0.018
				rumble_speed = 11.0

				rasp = 0.028
				rasp_speed = 42.0

			10: # BMW Performance Six (130i)

				curve = pow(rpm_ratio, 1.35)
				pitch_range = 1.55
				throttle_response = 0.55

				idle_db = -22.0
				load_db = -4.0

				rumble = 0.008
				rumble_speed = 14.0

				rasp = 0.020
				rasp_speed = 48.0

			11: # Viper V10

				curve = pow(rpm_ratio, 0.85)
				pitch_range = 0.60
				throttle_response = 0.30

				idle_db = -15.0
				load_db = 0.0

				rumble = 0.080
				rumble_speed = 5.0

				rasp = 0.010
				rasp_speed = 20.0

			12: # Saleen S7

				curve = pow(rpm_ratio, 1.60)
				pitch_range = 1.75
				throttle_response = 0.50

				idle_db = -21.0
				load_db = -1.0

				rumble = 0.008
				rumble_speed = 13.0

				rasp = 0.035
				rasp_speed = 55.0
	var target_pitch: float = audio_base_pitch * (
		0.75 + curve * pitch_range
	)

	# Throttle changes the pitch more aggressively under load.
	target_pitch += load * throttle_response * (0.35 + rpm_ratio)

	# Individual mechanical character.
	target_pitch += sin(engine_time * rumble_speed) * rumble * rpm_ratio
	target_pitch += sin(engine_time * rasp_speed) * rasp * rpm_ratio

	# Forced induction.
	
	# Engines relax slightly when the throttle is released.
	if load < 0.05:
		target_pitch -= rpm_ratio * 0.07

	target_pitch = clamp(target_pitch, 0.55, 3.0)

	var target_db: float = lerp(idle_db, load_db, load)
	target_db += rpm_ratio * 3.0
	target_db += audio_volume_offset
	if has_turbo:
		target_pitch += pow(rpm_ratio, 2.0) * load * 0.35
		target_db += rpm_ratio * load * 3.0

	if has_supercharger:
		target_pitch += rpm_ratio * 0.30
		target_db += rpm_ratio * 2.0

	# Distinct idle behavior.
	if speed_kmh < 2.0 and load < 0.05:
		target_db = idle_db + audio_volume_offset
		target_pitch = audio_base_pitch * (
			0.94 if audio_character_type == 1
			or audio_character_type == 11
			else 1.0
		)

	# Turbo and supercharger increase load loudness.
	if load > 0.2 and has_turbo:
		target_db += 1.5

	if load > 0.2 and has_supercharger:
		target_db += 2.0

	engine_pitch_smoothed = lerp(
		engine_pitch_smoothed,
		target_pitch,
		1.0 - exp(-delta * 5.0)
	)

	engine_volume_smoothed = lerp(
		engine_volume_smoothed,
		target_db,
		1.0 - exp(-delta * 7.0)
	)

	RevPlayer.pitch_scale = engine_pitch_smoothed
	if not is_diesel: 
		RevPlayer.volume_db = clamp(engine_volume_smoothed-1.5, -40.0, 0.0)
	else:RevPlayer.volume_db = clamp(engine_volume_smoothed+3.0, -40.0, 0.0)
		
func setup_engine_bus() -> void:
	if not is_instance_valid(RevPlayer):
		return

	var bus_names := {
		0: "Engine_Luxury",
		1: "Engine_Muscle",
		2: "Engine_Exotic",
		3: "Engine_Turbo",
		4: "Engine_Supercharged",
		5: "Engine_TVR",
		6: "Engine_Diesel",
		7: "Engine_AMG",
		8: "Engine_V12",
		9: "Engine_Maserati",
		10: "Engine_BMW_M",
		11: "Engine_Viper",
		12: "Engine_Saleen"
	}

	var bus_name: String = bus_names.get(
		audio_character_type,
		"Engine_Luxury"
	)

	var bus_index := AudioServer.get_bus_index(bus_name)

	if bus_index == -1:
		push_warning("Missing audio bus: " + bus_name)
		RevPlayer.bus = "Master"
		return

	RevPlayer.bus = bus_name
func _find_and_add_car_exceptions(node: Node) -> void:
	for child in node.get_children():
		if child is CarController and child != self:
			add_collision_exception_with(child)
		# Recursively search sub-nodes in case cars are nested under tracks, holders, etc.
		if child.get_child_count() > 0:
			_find_and_add_car_exceptions(child)
