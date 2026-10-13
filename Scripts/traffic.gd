extends CharacterBody3D

@export var speed: float = 18.0
@export var turn_speed: float = 1.5

@export var front_ray_length: float = 8.0
@export var side_ray_length: float = 6.0

func _physics_process(delta: float) -> void:

	var space: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state

	var forward: Vector3 = -transform.basis.z
	var right: Vector3 = transform.basis.x

	var origin: Vector3 = global_position + Vector3.UP

	# FRONT RAY

	var front_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(
		origin,
		origin + forward * front_ray_length
	)

	front_query.exclude = [get_rid()]

	var front_hit: Dictionary = space.intersect_ray(front_query)

	# LEFT RAY

	var left_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(
		origin,
		origin + (forward - right).normalized() * side_ray_length
	)

	left_query.exclude = [get_rid()]

	var left_hit: Dictionary = space.intersect_ray(left_query)

	# RIGHT RAY

	var right_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(
		origin,
		origin + (forward + right).normalized() * side_ray_length
	)

	right_query.exclude = [get_rid()]

	var right_hit: Dictionary = space.intersect_ray(right_query)

	if not front_hit.is_empty():

		var left_clear: bool = left_hit.is_empty()
		var right_clear: bool = right_hit.is_empty()

		if left_clear:

			rotation.y += turn_speed * delta

		elif right_clear:

			rotation.y -= turn_speed * delta

		else:

			speed = 5.0

	else:

		speed = 18.0

	velocity = -transform.basis.z * speed

	move_and_slide()
