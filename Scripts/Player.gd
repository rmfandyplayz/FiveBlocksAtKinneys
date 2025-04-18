extends Node3D

signal turningCamera(turnDuration : float, turnDirection : int)
signal switchCameraMode # switch between looking at computer/looking up

@export var gameUI : CanvasLayer

@export var camera : Camera3D
@export var cameraTurnSeconds : float # how long does it take for the camera to turn





func _on_game_ui_turn_camera(direction : int) -> void:
	if(direction == 1): # left
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, camera.rotation_degrees.y + 90, camera.rotation_degrees.z), cameraTurnSeconds)
		turningCamera.emit(cameraTurnSeconds, direction)
	elif(direction == 2): # right
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, camera.rotation_degrees.y - 90, camera.rotation_degrees.z), cameraTurnSeconds)
		turningCamera.emit(cameraTurnSeconds, direction)
	elif(direction == 3): # up
		pass
	elif(direction == 4): # down
		pass
