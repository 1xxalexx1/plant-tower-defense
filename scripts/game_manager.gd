extends Node3D


@export var cam1: Camera3D
@export var cam2: Camera3D
@export var cam3: Camera3D
@export var cam4: Camera3D


enum ActiveCamera {
	CAMERA1,
	CAMERA2,
	CAMERA3,
	CAMERA4
}

var active_camera: ActiveCamera
var temp = true

func _ready() -> void:
	cam1.current = true
	cam2.current = false
	cam3.current = false
	cam4.current = false



func switch_to_camera(cam: ActiveCamera):
	match cam:
		ActiveCamera.CAMERA1: 
			cam1.current = true
			cam2.current = false
			cam3.current = false
			cam4.current = false
		ActiveCamera.CAMERA2: 
			cam1.current = false
			cam2.current = true
			cam3.current = false
			cam4.current = false
		ActiveCamera.CAMERA3: 
			cam1.current = false
			cam2.current = false
			cam3.current = true
			cam4.current = false
		ActiveCamera.CAMERA4: 
			cam1.current = false
			cam2.current = false
			cam3.current = false
			cam4.current = true








func _on_cam_1_pressed() -> void:
	switch_to_camera(ActiveCamera.CAMERA1)

func _on_cam_2_pressed() -> void:
	switch_to_camera(ActiveCamera.CAMERA2)

func _on_cam_3_pressed() -> void:
	switch_to_camera(ActiveCamera.CAMERA3)

func _on_cam_4_pressed() -> void:
	switch_to_camera(ActiveCamera.CAMERA4)



