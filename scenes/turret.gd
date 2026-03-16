extends Node3D

var t = 0.0
var initial_rotation_y = 0.0

@export var raycast_reference: RayCast3D
@export var enemy_reference: CharacterBody3D

var targetting: bool = false

func _ready() -> void:
	initial_rotation_y = rotation.y

func _process(delta: float) -> void:
	if raycast_reference.get_collider() == CharacterBody3D:
		targetting = true

	if targetting == false:
		t += delta * 0.7
		rotation.y = initial_rotation_y + sin(t) * (PI/2)

	if targetting == true:
		look_at(enemy_reference.position)

