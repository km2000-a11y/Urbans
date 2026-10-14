extends CharacterBody3D

@export var base_speed: float = 18.0
var current_speed: float = 18.0
@export var turn_speed: float = 4.0
@export var front_ray_length: float = 30.0

const GRAVITY := 30.0

var dodge_timer: float = 0.0
var dodge_dir: float = 0.0
var current_steer_angle: float = 0.0
var target_steer_angle: float = 0.0
var stuck_timer: float = 0.0
var lane_bias: float = 0.0

func _ready() -> void:
	lane_bias = 1.0 if randf() > 0.5 else -1.0

func _physics_process(delta: float) -> void:
	var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state

	var forward: Vector3 = -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	
	var right: Vector3 = transform.basis.x
	right.y = 0.0
	right = right.normalized()

	var origin: Vector3 = global_position + Vector3.UP * 0.5

	# --- ANTI-STUCK SYSTEM ---
	if current_speed < 1.0:
		stuck_timer += delta
	else:
		stuck_timer = 0.0

	if stuck_timer > 1.5 and dodge_timer <= 0.0:
		dodge_dir = lane_bias
		target_steer_angle = dodge_dir * 0.4
		dodge_timer = 1.5
		stuck_timer = 0.0

	# --- COMMUTER DRIVING & CARCONTROLLER EVASION ---
	if dodge_timer > 0.0:
		dodge_timer -= delta
		current_speed = move_toward(current_speed, base_speed * 0.7, delta * 8.0)
	else:
		var front_query := PhysicsRayQueryParameters3D.create(origin, origin + forward * front_ray_length)
		front_query.exclude = [get_rid()]
		var front_hit: Dictionary = space.intersect_ray(front_query)

		if not front_hit.is_empty():
			var hit_collider = front_hit.get("collider")
			var hit_pos = front_hit.get("position", origin)

			var dist := origin.distance_to(hit_pos)

			if hit_collider is CarController:

				# Far away? Ignore it.
				if dist > 20.0:
					target_steer_angle = 0.0
					current_speed = move_toward(
						current_speed,
						base_speed,
						delta * 4.0
					)

				# Racer approaching but still safely ahead
				elif dist > 12.0:
					current_speed = move_toward(
						current_speed,
						base_speed * 0.6,
						delta * 4.0
					)

					target_steer_angle = lane_bias * 0.15

				else:
					# OH CRAP MOVE OVER
					dodge_dir = lane_bias

					target_steer_angle = dodge_dir * 0.35

					current_speed = move_toward(
						current_speed,
						base_speed * 0.5,
						delta * 8.0
					)

					dodge_timer = 1.0

			else:
				# Static obstacle
				current_speed = move_toward(
					current_speed,
					0.0,
					delta * 10.0
				)

				target_steer_angle = 0.0

		else:
			target_steer_angle = 0.0

			current_speed = move_toward(
				current_speed,
				base_speed,
				delta * 4.0
			)
	# Smooth steering interpolation
	current_steer_angle = move_toward(current_steer_angle, target_steer_angle, turn_speed * delta)
	rotation.y += current_steer_angle * delta * turn_speed

	# Smooth physics movement
	var target_velocity := -transform.basis.z * current_speed
	velocity.x = lerp(velocity.x, target_velocity.x, delta * 8.0)
	velocity.z = lerp(velocity.z, target_velocity.z, delta * 8.0)

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = -0.01

	move_and_slide()
