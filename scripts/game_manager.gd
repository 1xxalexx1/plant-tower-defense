extends Node3D

@export var cameras: Array[Camera3D] = []

var active_index: int = 0

func _ready() -> void:
	switch_to_camera(3)

func switch_to_camera(index: int) -> void:
	if index < 0 or index >= cameras.size():
		return
	for cam in cameras:
		cam.current = false
	cameras[index].current = true
	active_index = index

func _on_cam_1_pressed() -> void:
	switch_to_camera(0)

func _on_cam_2_pressed() -> void:
	switch_to_camera(1)

func _on_cam_3_pressed() -> void:
	switch_to_camera(2)

func _on_cam_4_pressed() -> void:
	switch_to_camera(3)

func _on_cam_5_pressed() -> void:
	switch_to_camera(4)