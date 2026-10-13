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

			# Check if the hit collider is a CarController (or in the "car_controller" group)
			var is_target_car = false
			if hit_collider:
				# Option A: If your CarController script uses "class_name CarController"
				if hit_collider is CarController:
					is_target_car = true
				# Option B: Fallback check if you prefer using groups (add your CarController to group "car_controller")
				elif hit_collider.is_in_group("car_controller"):
					is_target_car = true

			if is_target_car or (hit_collider and (hit_collider is CharacterBody3D or hit_collider is RigidBody3D)):
				
				# Fan-out diagonal rays to check for open lanes to swerve into
				var left_dir = (forward - right * 1.2).normalized()
				var right_dir = (forward + right * 1.2).normalized()

				var left_query := PhysicsRayQueryParameters3D.create(origin, origin + left_dir * 22.0)
				left_query.exclude = [get_rid()]
				var left_hit := space.intersect_ray(left_query)

				var right_query := PhysicsRayQueryParameters3D.create(origin, origin + right_dir * 22.0)
				right_query.exclude = [get_rid()]
				var right_hit := space.intersect_ray(right_query)

				var left_clear = left_hit.is_empty()
				var right_clear = right_hit.is_empty()

				# If it's specifically a CarController, make them react more proactively (swerve sooner)
				var urge_to_swerve = is_target_car and dist < 25.0
				var urge_to_brake = dist < 10.0

				if (left_clear and right_clear) or urge_to_swerve:
					# Choose the safer side or use lane bias
					if left_clear and not right_clear:
						dodge_dir = -1.0
					elif right_clear and not left_clear:
						dodge_dir = 1.0
					else:
						dodge_dir = lane_bias
						
					target_steer_angle = dodge_dir * 0.4
					dodge_timer = 1.5
				elif left_clear:
					dodge_dir = -1.0
					target_steer_angle = -0.4
					dodge_timer = 1.5
				elif right_clear:
					dodge_dir = 1.0
					target_steer_angle = 0.4
					dodge_timer = 1.5
				else:
					# Trapped behind the CarController / traffic: brake smoothly
					target_steer_angle = 0.0
					if urge_to_brake:
						current_speed = move_toward(current_speed, 0.0, delta * 20.0)
					else:
						current_speed = move_toward(current_speed, base_speed * 0.3, delta * 10.0)
			else:
				# Static obstacle (walls, barriers)
				target_steer_angle = 0.0
				current_speed = move_toward(current_speed, 0.0, delta * 15.0)
		else:
			# Road clear: straighten out and cruise
			target_steer_angle = 0.0
			current_speed = move_toward(current_speed, base_speed, delta * 6.0)
			dodge_timer = 0.0

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
