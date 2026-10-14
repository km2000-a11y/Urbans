class_name CarController
extends CharacterBody3D

const GRAVITY := 30.0
const ENGINE_BRAKE := 0.5
const DRAG := 0.1
const HARD_LIMIT_KMH := 400.0
const HARD_LIMIT := HARD_LIMIT_KMH / 3.6
var display_hp := 0.0
var display_weight := 0.0
var ai_dodge_timer:=0.0
var ai_dodge_dir:=0.0
var stuck_time := 0.0
var race_finished := false
var unstuck_time := 0.0
var unstucking := false

# --- ROLE FLAGS ---
var is_ai: bool = false
var waypoint_root: Node3D = null
var waypoints: Array[Node] = []
var current_wp: int = 0
var hard_frozen := false
static var used_ai_names := []
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

@export var sync_velocity: Vector3
@export var sync_transform: Transform3D
# --- AUDIO NODES ---
@onready var RevPlayer = $RevPlayer
@onready var BrakePlayer = $BrakePlayer
@onready var CrashPlayer = $CrashPlayer
@onready var SkidPlayer = $SkidPlayer
var TurboPlayer: AudioStreamPlayer
var custom_rev_player: AudioStreamPlayer = null

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
	"Steve", "Linus", "Chris", "Jesse", "Dimitri", "Mirko","Jared","Kyle","Victor",
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
	match Cars.selected_car:
				
				# =============================================
				# 4x4 SUV (Deep, heavy, sluggish low-end torque)
				# =============================================
				# =============================================
				# 4x4 SUV (Fixed to prevent popping/stretching artifacts)
				# =============================================
				# =============================================
		# 4x4 SUV
		# =============================================

		"Colossus Titan Max": # Hummer H1
			audio_base_pitch = 0.65
			audio_pitch_range = 1.10
			audio_character_type = 1
			audio_volume_offset = 2.4

		"Colossus Behemoth": # Hummer H2
			audio_base_pitch = 0.75
			audio_pitch_range = 1.25
			audio_character_type = 1
			audio_volume_offset = 2.0

		"Schroder Colosso": # Audi Q7 3.0 TDI
			audio_base_pitch = 0.78
			audio_pitch_range = 1.05
			audio_character_type = 1
			audio_volume_offset = 0.3

		"Mir Cars Nightwolf": # Lexus LX470
			audio_base_pitch = 0.90
			audio_pitch_range = 1.25
			audio_character_type = 0
			audio_volume_offset = 0.5

		# =============================================
		# Compact Cars
		# =============================================

		"Kuro Zephyr": # Lexus IS250
			audio_base_pitch = 1.05
			audio_pitch_range = 1.65
			audio_character_type = 0
			audio_volume_offset = -0.5

		"Straeda Volant": # Beetle Turbo S
			audio_base_pitch = 1.15
			audio_pitch_range = 1.80
			audio_character_type = 0
			audio_volume_offset = 0.0

		"Schroder Atrix Q32": # TT 3.2
			audio_base_pitch = 1.00
			audio_pitch_range = 1.75
			audio_character_type = 2
			audio_volume_offset = 0.0

		"Eisenach Bengal": # BMW 130i
			audio_base_pitch = 1.20
			audio_pitch_range = 2.00
			audio_character_type = 2
			audio_volume_offset = 0.2

		"Zenith Horizon": # 350Z
			audio_base_pitch = 1.10
			audio_pitch_range = 1.90
			audio_character_type = 2
			audio_volume_offset = 0.4

		# =============================================
		# Muscle
		# =============================================

		"Brutus Viper": # Shelby GT500
			audio_base_pitch = 0.68
			audio_pitch_range = 1.30
			audio_character_type = 1
			audio_volume_offset = 1.5

		"Mir Cars Hutch": # Chevelle SS
			audio_base_pitch = 0.73
			audio_pitch_range = 1.38
			audio_character_type = 1
			audio_volume_offset = 1.2

		# =============================================
		# Executive
		# =============================================

		"Strandberg Turbo": # Volvo S60R
			audio_base_pitch = 1.00
			audio_pitch_range = 1.55
			audio_character_type = 0
			audio_volume_offset = -0.2

		"Kuro Vault": # LS430
			audio_base_pitch = 0.82
			audio_pitch_range = 1.20
			audio_character_type = 0
			audio_volume_offset = -0.8

		"Zenith Prince": # Infiniti M35
			audio_base_pitch = 1.12
			audio_pitch_range = 1.85
			audio_character_type = 2
			audio_volume_offset = 0.2

		"Schroder Suppressor": # A4 TDI
			audio_base_pitch = 0.74
			audio_pitch_range = 1.10
			audio_character_type = 1
			audio_volume_offset = -0.4

		# =============================================
		# Urban Performance
		# =============================================

		"Kuro Serenity": # SC400
			audio_base_pitch = 0.92
			audio_pitch_range = 1.45
			audio_character_type = 0
			audio_volume_offset = -0.1

		"Berkshire Falcon": # XK8
			audio_base_pitch = 1.00
			audio_pitch_range = 1.65
			audio_character_type = 0
			audio_volume_offset = 0.0

		"Berkshire Blunt": # XKR
			audio_base_pitch = 0.82
			audio_pitch_range = 1.50
			audio_character_type = 1
			audio_volume_offset = 0.7

		"Kestrel Seabird": # Exige
			audio_base_pitch = 1.25
			audio_pitch_range = 2.10
			audio_character_type = 2
			audio_volume_offset = 0.0

		"Kestrel Speedster": # Aero 8
			audio_base_pitch = 0.88
			audio_pitch_range = 1.55
			audio_character_type = 1
			audio_volume_offset = 0.8

		"Kronstadt Blazer": # C32 AMG
			audio_base_pitch = 0.86
			audio_pitch_range = 1.55
			audio_character_type = 1
			audio_volume_offset = 0.8

		# =============================================
		# Sport Coupe
		# =============================================

		"Schroder Classique Sport":
			audio_base_pitch = 1.15
			audio_pitch_range = 1.95
			audio_character_type = 2
			audio_volume_offset = 0.3

		"Brutus Stingray": # C6
			audio_base_pitch = 0.78
			audio_pitch_range = 1.45
			audio_character_type = 1
			audio_volume_offset = 1.1

		"Berkshire V12-S": # DB9
			audio_base_pitch = 0.95
			audio_pitch_range = 1.90
			audio_character_type = 2
			audio_volume_offset = 0.8

		"Kestrel Touring": # Cerbera
			audio_base_pitch = 1.22
			audio_pitch_range = 2.20
			audio_character_type = 2
			audio_volume_offset = 0.7

		# =============================================
		# Sport Racing
		# =============================================

		"Kestrel Battleaxe": # Sagaris
			audio_base_pitch = 1.28
			audio_pitch_range = 2.25
			audio_character_type = 2
			audio_volume_offset = 0.8

		"Berkshire Tempest": # Vanquish S
			audio_base_pitch = 0.90
			audio_pitch_range = 1.85
			audio_character_type = 2
			audio_volume_offset = 0.9

		"Brutus Venom": # Viper RT10
			audio_base_pitch = 0.65
			audio_pitch_range = 1.35
			audio_character_type = 1
			audio_volume_offset = 1.8

		"Linetti Shepherd": # Gallardo
			audio_base_pitch = 1.30
			audio_pitch_range = 2.25
			audio_character_type = 2
			audio_volume_offset = 0.6

		# =============================================
		# Supercars
		# =============================================

		"Kestrel Guillotine": # T440R
			audio_base_pitch = 1.25
			audio_pitch_range = 2.20
			audio_character_type = 2
			audio_volume_offset = 0.7

		"Linetti Firestorm": # Diablo
			audio_base_pitch = 1.20
			audio_pitch_range = 2.10
			audio_character_type = 2
			audio_volume_offset = 0.9

		"Mir Cars Raptor": # Saleen S7
			audio_base_pitch = 0.72
			audio_pitch_range = 1.60
			audio_character_type = 1
			audio_volume_offset = 1.4

		"Linetti Terror": # Murcielago
			audio_base_pitch = 1.35
			audio_pitch_range = 2.35
			audio_character_type = 2
			audio_volume_offset = 1.1

		# =============================================
		# Track Cars
		# =============================================

		"Bartoli Track Cruiser": # MC12
			audio_base_pitch = 1.32
			audio_pitch_range = 2.40
			audio_character_type = 2
			audio_volume_offset = 1.1

		"Brutus Thunderbolt": # Cobra Concept
			audio_base_pitch = 0.62
			audio_pitch_range = 1.25
			audio_character_type = 1
			audio_volume_offset = 1.8

		"Mir Cars Athletic C70": # Zonda
			audio_base_pitch = 1.40
			audio_pitch_range = 2.50
			audio_character_type = 2
			audio_volume_offset = 1.3

		# =============================================
		# Fallback / Default
		# =============================================
		_:
			audio_base_pitch = 1.0
			audio_pitch_range = 1.8
			audio_character_type = 0
			audio_volume_offset = 0.0
	custom_rev_player.volume_db = -10.0  # Changed from 0.0 to -5.0
	# --- REV PLAYER SETUP ---
	if RevPlayer:
		RevPlayer.stream = diesel_stream if is_diesel else petrol_stream
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

	if not is_ai:
		# Player is holding NOS
		if Input.is_action_pressed("nos"):
			# Only allow nitro if not cooling down
			if nitro_cooldown <= 0.0:
				nitrous = true
		else:
			nitrous = false

		# --- NITRO TIMER SYSTEM ---
		if nitrous:
			nitro_time += delta
			nitro_active = true

			# If nitro exceeds 4 seconds, block it
			if nitro_time >= 4.0:
				nitro_active = false
				nitro_cooldown = 8.0  # start cooldown
		else:
			nitro_active = false

		# Count down cooldown
		if nitro_cooldown > 0.0:
			nitro_cooldown -= delta

		# Reset nitro timer ONLY when cooldown is finished
		if nitro_cooldown <= 0.0 and not nitro_active:
			nitro_time = 0.0



	var target_drift := 0.0
	if drift_input:
		target_drift = 1.0

	drift_factor = lerp(drift_factor, target_drift, delta * 6.0)
	drifting = drift_factor > 0.1
	if drifting:
		if not SkidPlayer.playing:
			SkidPlayer.play()
		else:
			if SkidPlayer.playing:
				SkidPlayer.stop()
	steering = lerp(steering, steer, delta * 6.0)

	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var right := transform.basis.x.normalized()

	var sideways_speed := velocity.dot(right)
	sideways_speed = lerp(sideways_speed, 0.0, delta * 8.0)

	var speed := velocity.length()
	var speed_kmh := speed * 3.6
	var throttle_steer := 0.0

	# --- CAR ORIENTATION ---
	if not drifting:
		rotate_y(steering * turn_speed * delta)
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

	# --- COLLISION HANDLING (SEAMS + RIGIDBODIES) ---
	# --- COLLISION HANDLING (SEAM-PROOF + WALL SCRAPE + PROPS) ---
	for i in range(get_slide_collision_count()):
		var col := get_slide_collision(i)
		var other := col.get_collider()
		if not (other is CarController):
			if velocity.length() > 8.0:
				if not CrashPlayer.playing:
					CrashPlayer.play()
		if other is CarController:

			var other_car := other as CarController

			var my_forward := -transform.basis.z
			my_forward.y = 0.0
			my_forward = my_forward.normalized()

			var other_forward := -other_car.transform.basis.z
			other_forward.y = 0.0
			other_forward = other_forward.normalized()

			var to_other := (other_car.global_position - global_position).normalized()

			# We are behind them
			var behind_them := other_forward.dot(-to_other) > 0.5

			# Both cars travelling roughly same direction
			var same_direction := my_forward.dot(other_forward) > 0.7

			var rear_end := behind_them and same_direction

			if rear_end:
				# --- MASS-BASED MOMENTUM RETENTION ---
				# Heavier cars lose less speed. mass_ratio compares our mass to the victim's mass.
				# If we are much heavier, our speed reduction multiplier is much closer to 1.0 (no slowdown).
				var mass_ratio :float= mass / max(other_car.mass, 1.0)
				var speed_retention :float= clamp(0.7 + (mass_ratio - 1.0) * 0.15, 0.7, 0.98)

				# Keep a high percentage of speed based on weight
				var flat := Vector3(velocity.x, 0.0, velocity.z)

				if flat.length() > 0.0:
					flat *= speed_retention

					velocity.x = flat.x
					velocity.z = flat.z

				# Push victim forward more forcefully if we are heavy
				var push_power :float= clamp(0.25 * mass_ratio, 0.1, 0.6)
				other_car.velocity += my_forward * flat.length() * push_power

			else:

				var hit_dir := (other_car.global_position - global_position).normalized()
				hit_dir.y = 0.0

				var mass_ratio: float = mass / max(other_car.mass, 1.0)
				mass_ratio = clamp(mass_ratio, 0.5, 2.0)

				var shove_force := velocity.length() * mass_ratio * 0.08

				other_car.velocity += hit_dir * shove_force
			var hit_dir := (other_car.global_position - global_position).normalized()
			
		# Raw normal
		var n := col.get_normal()
		n.y = 0.0
		n = n.normalized()

		# --- PROP PUSH (RigidBody3D) ---
		# --- COLLISION HANDLING (SEAM-PROOF + WALL SCRAPE + PROPS) ---
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
		var wheel_rpm: float = speed_kmh * gear_ratios[current_gear - 1] * 35.0
		rpm = lerp(rpm, wheel_rpm, delta * 4.0)

	rpm = clamp(rpm, idle_rpm, max_rpm)
	update_gears(speed_kmh)
	var rpm_ratio := rpm / max_rpm

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
	if RevPlayer:
		if not RevPlayer.playing:
			RevPlayer.play()
			
		var is_idling := accel == 0.0 and rpm_ratio < 0.15
		var is_cruising_high_speed := rpm_ratio > 0.7 and accel < 0.3
		var is_pinned_at_top_speed := rpm_ratio > 0.9 and accel > 0.8
		var load_factor :float= lerp(0.3, 1.0, accel)
		
		# ==========================================
		# 1. CHARACTER-BASED DISTINCT PITCH PROFILES
		# ==========================================
		var target_pitch := audio_base_pitch + (rpm_ratio * audio_pitch_range)
		
		match audio_character_type:
			1: # Deep V8 / Muscle / Diesel: Heavy low-end, sluggish pitch climb, aggressive cam shake under heavy load
				target_pitch = audio_base_pitch + (rpm_ratio * audio_pitch_range * 0.65)
				if accel > 0.7:
					target_pitch += sin(Time.get_ticks_msec() * 0.03) * 0.04 # Simulates a pulsing muscle car rumble
					
			2: # High-Rev Exotic / Supercar: Lazy low end, but aggressively screams and explodes in pitch past mid-RPM
				if rpm_ratio > 0.5:
					target_pitch += (rpm_ratio - 0.5) * 1.2
				else:
					target_pitch *= 0.85
					
			_: # Type 0: Normal / Standard Car (Linear, balanced pitch response)
				target_pitch = audio_base_pitch + (rpm_ratio * audio_pitch_range)

		# State-based pitch overrides
		if is_pinned_at_top_speed:
			target_pitch = audio_base_pitch + audio_pitch_range
		elif is_cruising_high_speed:
			target_pitch = audio_base_pitch + (audio_pitch_range * 0.5)
			
		target_pitch = clamp(target_pitch, 0.5, 2.5)
		
		# ==========================================
		# 2. CHARACTER-BASED DISTINCT VOLUME MAPPING
		# ==========================================
		var base_db :float= lerp(-26.0, -10.0, rpm_ratio * load_factor) + audio_volume_offset
		
		match audio_character_type:
			1: # Muscle cars are louder and punchier on throttle transients
				base_db += (accel * 3.5)
			2: # Exotics are quieter at low speed/idle, but deafeningly loud at high RPM scream
				base_db = lerp(-30.0, -4.0, pow(rpm_ratio, 2.0)) + audio_volume_offset
			_:
				pass

		if is_pinned_at_top_speed:
			base_db = -5.0 + audio_volume_offset
		elif is_cruising_high_speed:
			base_db -= 6.0
			
		if is_idling:
			# Different idle breathing patterns per type
			var idle_pulse := sin(Time.get_ticks_msec() * 0.001 * (12.0 if audio_character_type == 1 else 6.0))
			base_db = -18.0 + audio_volume_offset + (idle_pulse * (1.5 if audio_character_type == 1 else 0.8))
			target_pitch = audio_base_pitch * (0.9 if audio_character_type == 1 else 1.0)
			
		# ==========================================
		# 3. MECHANICAL MODIFIERS & FINAL APPLICATION
		# ==========================================
		var gear_load_modifier := float(gear_count - current_gear) * 0.2 * accel
		var nitro_boost := 2.5 if nitrous else 0.0
		var induction_db := 2.0 if (has_turbo or has_supercharger) and accel > 0.4 else 0.0
		
		var target_db :float= base_db + gear_load_modifier + nitro_boost + induction_db
		target_db = clamp(target_db, -30.0, -2.0)
		
		# Apply smoothly to the single RevPlayer
		RevPlayer.pitch_scale = lerp(RevPlayer.pitch_scale, target_pitch, delta * 6.0)
		RevPlayer.volume_db = lerp(RevPlayer.volume_db, target_db, delta * 6.0)
	var torque_factor := rpm / max_rpm
	

	# --- DRIVETRAIN ---
	var traction_factor := 1.0
	var launch_grip := 1.0

		# --- DRIVETRAIN BEHAVIOR FLAVOR ---
	if transmission == "Front wheel drive":
		# More understeer, stable, safe
		lateral_friction = lerp(lateral_friction, 1.05, delta * 2.0)
		steering *= 0.95  # slightly calmer steering
	elif transmission == "Rear wheel drive":
		# More oversteer, playful
		lateral_friction = lerp(lateral_friction, 0.95, delta * 2.0)
		var yaw_boost :float= clamp(speed_kmh / 120.0, 0.0, 1.0)
		velocity = velocity.rotated(Vector3.UP, steering * yaw_boost * 0.12 * delta)
	elif transmission == "Four wheel drive":
		# More grip, more stability
		lateral_friction = lerp(lateral_friction, 1.15, delta * 2.0)
		steering *= 1.05



	var accel_force := 0.0

	if accel > 0.0:
		if reversing:
			# --- REVERSE MOVEMENT ---
			var rev_force := acceleration_calc * 0.35   # MUCH WEAKER
			velocity -= forward * rev_force * delta

			# Cap reverse speed
			var flat_rev := Vector3(velocity.x, 0, velocity.z)
			if flat_rev.length() > reverse_speed_limit:
				flat_rev = flat_rev.normalized() * reverse_speed_limit
			velocity.x = flat_rev.x
			velocity.z = flat_rev.z

		else:
			# --- FORWARD MOVEMENT ---
			var launch_boost := 1.0
			if current_gear == 1:
				launch_boost = 1.25

			accel_force = acceleration_calc * torque_factor * traction_factor * launch_boost * launch_grip
			velocity += forward * accel_force * delta
			accel_force = acceleration_calc * torque_factor * traction_factor * launch_boost * launch_grip

			if is_diesel:
				if speed_kmh > 50.0 and speed_kmh < 160.0:
					accel_force *= 1.35

	else:
		var flat := Vector3(velocity.x, 0, velocity.z)
		var brake_power := ENGINE_BRAKE
		if drifting:
			brake_power = ENGINE_BRAKE * 0.05
		flat = flat.move_toward(Vector3.ZERO, brake_power * delta)
		velocity.x = flat.x
		velocity.z = flat.z

	if nitrous:
		nitro.show()
		nitro_top_speed_multiplier = 1.08 # Smaller top speed boost (5% over limit)
		
		# Gentle, smooth push forward (scaled down from 1.08 to 0.4)
		var nitro_force := acceleration_calc * 0.4
		velocity += forward * nitro_force * delta
	else:
		nitro.hide()
		nitro_top_speed_multiplier = 1.0

	if brake > 0.1:
		var brake_force := brake_strength * (mass / 1200.0) * 1.4
		velocity = velocity.move_toward(Vector3.ZERO, brake_force * delta)
		if not BrakePlayer.playing:
			BrakePlayer.play()

	velocity -= velocity * DRAG * delta

	var flat2 := Vector3(velocity.x, 0, velocity.z)
	var current_top_speed := top_speed
	if nitrous:
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
