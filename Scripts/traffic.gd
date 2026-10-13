extends CharacterBody3D

@export var base_speed: float = 18.0
var current_speed: float = 18.0
@export var turn_speed: float = 4.0

@export var front_ray_length: float = 30.0

const GRAVITY := 30.0

var dodge_timer: float = 0.0
var dodge_dir: float = 0.0
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
		dodge_timer = 1.2
		stuck_timer = 0.0

	# --- EVASION SWERVE ---
	if dodge_timer > 0.0:
		dodge_timer -= delta
		rotation.y += dodge_dir * turn_speed * delta
		current_speed = move_toward(current_speed, base_speed * 0.6, delta * 8.0)
	else:
		# Only look for new obstacles if we aren't currently dodging
		var front_query := PhysicsRayQueryParameters3D.create(origin, origin + forward * front_ray_length)
		front_query.exclude = [get_rid()]
		var front_hit: Dictionary = space.intersect_ray(front_query)

		if not front_hit.is_empty():
			var hit_collider = front_hit.get("collider")
			var hit_pos = front_hit.get("position", origin)
			var dist := origin.distance_to(hit_pos)

			if hit_collider and (hit_collider is CharacterBody3D or hit_collider is RigidBody3D):
				
				# Fan-out diagonal rays to find gaps
				var left_dir = (forward - right * 1.5).normalized()
				var right_dir = (forward + right * 1.5).normalized()

				var left_query := PhysicsRayQueryParameters3D.create(origin, origin + left_dir * 18.0)
				left_query.exclude = [get_rid()]
				var left_hit := space.intersect_ray(left_query)

				var right_query := PhysicsRayQueryParameters3D.create(origin, origin + right_dir * 18.0)
				right_query.exclude = [get_rid()]
				var right_hit := space.intersect_ray(right_query)

				var left_clear = left_hit.is_empty()
				var right_clear = right_hit.is_empty()

				# Trigger dodge ONLY if timer is finished (prevents infinite spinning loops)
				if left_clear and right_clear and dodge_timer <= 0.0:
					dodge_dir = lane_bias
					dodge_timer = 1.2
				elif left_clear and not right_clear and dodge_timer <= 0.0:
					dodge_dir = -1.0
					dodge_timer = 1.2
				elif right_clear and not left_clear and dodge_timer <= 0.0:
					dodge_dir = 1.0
					dodge_timer = 1.2
				else:
					# Both blocked: maintain smooth spacing buffer
					if dist < 8.0:
						current_speed = move_toward(current_speed, 0.0, delta * 20.0)
					else:
						current_speed = move_toward(current_speed, base_speed * 0.3, delta * 10.0)
			else:
				current_speed = move_toward(current_speed, 0.0, delta * 15.0)
		else:
			current_speed = move_toward(current_speed, base_speed, delta * 6.0)
			dodge_timer = 0.0

	# Smooth physics movement
	var target_velocity := -transform.basis.z * current_speed
	velocity.x = lerp(velocity.x, target_velocity.x, delta * 8.0)
	velocity.z = lerp(velocity.z, target_velocity.z, delta * 8.0)

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = -0.01

	move_and_slide()
