extends CharacterBody3D

#consts
@export var SPEED = 10.0
@export var lookahead_distance: float = 3.0

#states
enum State {
	IDLE,
	WAITING_TO_MOVE,
	MOVE
}

var state: State = State.IDLE

#timer
var idle_wait_time: float = 0.1
var idle_timer_count: float = 0

#node refferences
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta

	match state:
		State.IDLE: _on_idle()
		State.WAITING_TO_MOVE: _on_waiting_to_move(delta)
		State.MOVE: _on_move()

	move_and_slide()

func _on_idle():
	velocity = Vector3.ZERO
	idle_timer_count = idle_wait_time
	state = State.WAITING_TO_MOVE

func _on_waiting_to_move(delta: float):
	idle_timer_count -= delta
	if idle_timer_count <= 0.0:
		navigation_agent.target_position = _get_safe_target()
		state = State.MOVE

func _on_move():
	if navigation_agent.is_navigation_finished():
		navigation_agent.target_position = _get_safe_target()
		return

	# set next target early so path is already computed when we arrive
	var dist = global_transform.origin.distance_to(navigation_agent.target_position)
	if dist < lookahead_distance:
		navigation_agent.target_position = _get_safe_target()

	var current_position = global_transform.origin
	var next_position = navigation_agent.get_next_path_position()
	var direction = (next_position - current_position).normalized()
	var new_velocity = direction * SPEED
	new_velocity.y = velocity.y  # preserve gravity
	velocity = velocity.lerp(new_velocity, 0.25)

func _on_navigation_agent_3d_target_reached() -> void:
	navigation_agent.target_position = _get_safe_target()

func _get_safe_target() -> Vector3:
	var target = get_new_target_location()
	var nav_map = navigation_agent.get_navigation_map()
	return NavigationServer3D.map_get_closest_point(nav_map, target)

func get_new_target_location() -> Vector3:
	var offset_x = randf_range(0.5, 10.0) * (-1 if randf() < 0.5 else 1)
	var offset_z = randf_range(0.5, 10.0) * (-1 if randf() < 0.5 else 1)
	return global_transform.origin + Vector3(offset_x, 0, offset_z)

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.lerp(safe_velocity, 0.1)
