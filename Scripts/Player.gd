extends Node3D

signal turningCamera(turnDuration : float, turnDirection : int)
signal switchCameraMode # switch between looking at computer/looking up

@export_group("References")
@export var gameUI : CanvasLayer
@export var camera : Camera3D

@export_group("Camera Stuff")
@export var cameraTurnSeconds : float ## How long does it take for the camera to turn?
@export var currentCameraDirection : int = 0 ##0 = Looking down at computer, 1 = looking up forward, 2 = up looking left, 3 = looking behind, 4 = looking right.
@export_custom(PROPERTY_HINT_RANGE, "-360,360,or_greater,or_less,degrees") var defaultCamAngle : Vector3
@export_custom(PROPERTY_HINT_RANGE, "-360,360,or_greater,or_less,degrees") var lookDownCamAngle : Vector3
@export_custom(PROPERTY_HINT_RANGE, "30,90,or_greater,or_less,degrees") var lookDownCameraFOV : float
var initialCameraFOV


func _ready() -> void:
	initialCameraFOV = camera.fov


func _on_game_ui_turn_camera(direction : int) -> void:
	if(direction == 1): # turn left
		print("turn left (-90)")
		if(camera.rotation_degrees.y + 90 > 180):
			print("+90 > 180")
			create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, -(camera.rotation_degrees.y - 90), camera.rotation_degrees.z), cameraTurnSeconds)
		else:
			create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, camera.rotation_degrees.y + 90, camera.rotation_degrees.z), cameraTurnSeconds)

	elif(direction == 2): # turn right
		print("turn right (-90)")
		if(camera.rotation_degrees.y - 90 < -180):
			print("-90 < -180")
			create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, -(camera.rotation_degrees.y + 90), camera.rotation_degrees.z), cameraTurnSeconds)
		else:	
			create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", Vector3(camera.rotation_degrees.x, camera.rotation_degrees.y - 90, camera.rotation_degrees.z), cameraTurnSeconds)
	
	elif(direction == 3): # look up
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "fov", initialCameraFOV, cameraTurnSeconds)
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", defaultCamAngle, cameraTurnSeconds)
	elif(direction == 4): # look down
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "rotation_degrees", lookDownCamAngle, cameraTurnSeconds)
		create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART).tween_property(camera, "fov", lookDownCameraFOV, cameraTurnSeconds)
	
	
	turningCamera.emit(cameraTurnSeconds, direction)
	await get_tree().create_timer(cameraTurnSeconds).timeout
