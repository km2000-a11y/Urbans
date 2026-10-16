extends CharacterBody3D

@export var base_speed := 18.0
@export var turn_speed := 3.0
@export var waypoint_reach_distance := 8.0
@export var front_ray_length := 25.0

const GRAVITY := 30.0

var current_speed := 18.0

var current_wp := 0
var waypoints : Array = []

var target_steer := 0.0
var current_steer := 0.0

func set_waypoints(root: Node) -> void:
	waypoints.clear()

	for child in root.get_children():
		if child is Node3D:
			waypoints.append(child)

func _physics_process(delta):

	if waypoints.is_empty():
		return

	var space := get_world_3d().direct_space_state

	var wp : Node3D = waypoints[current_wp]

	var to_wp : Vector3 = wp.global_position - global_position
	to_wp.y = 0.0

	if to_wp.length() < waypoint_reach_distance:
		current_wp += 1

		if current_wp >= waypoints.size():
			current_wp = 0

		wp = waypoints[current_wp]

	to_wp = (wp.global_position - global_position).normalized()

	var forward := -transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var angle := forward.signed_angle_to(to_wp, Vector3.UP)

	target_steer = clamp(angle, -0.25, 0.25)

	var origin := global_position + Vector3.UP * 0.5

	var ray := PhysicsRayQueryParameters3D.create(
		origin,
		origin + forward * front_ray_length
	)

	ray.exclude = [get_rid()]

	var hit := space.intersect_ray(ray)

	if not hit.is_empty():

		var dist := origin.distance_to(hit.position)

		if hit.collider is CarController:

			if dist < 10.0:
				current_speed = move_toward(
					current_speed,
					base_speed * 0.8,
					delta * 2.0
				)

				target_steer += 0.08

			else:
				current_speed = move_toward(
					current_speed,
					base_speed,
					delta * 1.5
				)

		else:
			current_speed = move_toward(
				current_speed,
				0.0,
				delta * 4.0
			)

	else:

		current_speed = move_toward(
			current_speed,
			base_speed,
			delta * 1.0
		)

	current_steer = move_toward(
		current_steer,
		target_steer,
		turn_speed * delta
	)

	rotation.y += current_steer * delta * turn_speed

	var target_velocity := -transform.basis.z * current_speed

	velocity.x = lerp(
		velocity.x,
		target_velocity.x,
		delta * 4.0
	)

	velocity.z = lerp(
		velocity.z,
		target_velocity.z,
		delta * 4.0
	)

	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = -0.01

	move_and_slide()
