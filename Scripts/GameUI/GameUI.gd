extends CanvasLayer

enum cameraDirections
{
	LEFT = 1,
	RIGHT = 2,
	UP = 3,
	DOWN = 4
}

@export var turnCamLeftCntrl : TextureRect
@export var turnCamRightCntrl : TextureRect
@export var turnCamUpCntrl : TextureRect
@export var turnCamDownCntrl : TextureRect

@export var camTurnCooldownTimer : Timer

signal turnCamera(direction : cameraDirections)


func _ready() -> void:
	HideCameraControl(cameraDirections.UP)
	

#these 4 funcs below are the first to detect player mouse hovering over those controls
func _on_look_left() -> void:
	turnCamera.emit(cameraDirections.LEFT)

func _on_look_right() -> void:
	turnCamera.emit(cameraDirections.RIGHT)

func _on_look_down() -> void:
	turnCamera.emit(cameraDirections.DOWN)

func _on_look_up() -> void:
	turnCamera.emit(cameraDirections.UP)



func _on_player_turning_camera(turnDuration: float, turnDirection : int) -> void:
	camTurnCooldownTimer.wait_time = turnDuration
	
	if(turnDirection == cameraDirections.LEFT or turnDirection == cameraDirections.RIGHT):
		DeactivateCameraControl(cameraDirections.LEFT, true)
		
		camTurnCooldownTimer.start()
		await camTurnCooldownTimer.timeout
		
		ActivateCameraControl(cameraDirections.LEFT, true)
	elif(turnDirection == cameraDirections.DOWN):
		DeactivateCameraControl(cameraDirections.LEFT, true)
		HideCameraControl(cameraDirections.LEFT, true)
		
		camTurnCooldownTimer.start()
		await camTurnCooldownTimer.timeout
		
		ActivateCameraControl(cameraDirections.UP)
		ShowCameraControl(cameraDirections.UP)
	elif(turnDirection == cameraDirections.UP):
		DeactivateCameraControl(cameraDirections.LEFT, true)
		HideCameraControl(cameraDirections.LEFT, true)
		
		camTurnCooldownTimer.start()
		await camTurnCooldownTimer.timeout
		
		ActivateCameraControl(cameraDirections.DOWN)
		ShowCameraControl(cameraDirections.DOWN)
		ActivateCameraControl(cameraDirections.LEFT)
		ShowCameraControl(cameraDirections.LEFT)
		ActivateCameraControl(cameraDirections.RIGHT)
		ShowCameraControl(cameraDirections.RIGHT)
		
		
		
#region Camera control stuff

# deactivate = still show it on the screen, but u can't interact
# hide = make the control invisible, aka u can't see it nor interact with it
func DeactivateCameraControl(camera : cameraDirections = cameraDirections.LEFT, deactivateAll : bool = false) -> void:
	if(deactivateAll == true):
		turnCamLeftCntrl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		turnCamLeftCntrl.self_modulate = Color(1, 0, 0, 0.4)
		turnCamRightCntrl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		turnCamRightCntrl.self_modulate = Color(1, 0, 0, 0.4)
		turnCamUpCntrl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		turnCamUpCntrl.self_modulate = Color(1, 0, 0, 0.4)
		turnCamDownCntrl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		turnCamDownCntrl.self_modulate = Color(1, 0, 0, 0.4)
	else:
		var checkedCamera : TextureRect = CheckCameraDirection(camera)
		checkedCamera.mouse_filter = Control.MOUSE_FILTER_IGNORE
		checkedCamera.self_modulate = Color(1, 0, 0, 0.4)
	
func ActivateCameraControl(camera : cameraDirections = cameraDirections.LEFT, activateAll : bool = false) -> void:
	if(activateAll == true):
		turnCamLeftCntrl.mouse_filter = Control.MOUSE_FILTER_PASS
		turnCamLeftCntrl.self_modulate = Color.WHITE
		turnCamRightCntrl.mouse_filter = Control.MOUSE_FILTER_PASS
		turnCamRightCntrl.self_modulate = Color.WHITE
		turnCamUpCntrl.mouse_filter = Control.MOUSE_FILTER_PASS
		turnCamUpCntrl.self_modulate = Color.WHITE
		turnCamDownCntrl.mouse_filter = Control.MOUSE_FILTER_PASS
		turnCamDownCntrl.self_modulate = Color.WHITE
	else:
		var checkedCamera : TextureRect = CheckCameraDirection(camera)
		checkedCamera.mouse_filter = Control.MOUSE_FILTER_PASS
		checkedCamera.self_modulate = Color.WHITE
	
func HideCameraControl(camera : cameraDirections = cameraDirections.LEFT, hideAll : bool = false) -> void:
	if(hideAll == true):
		turnCamLeftCntrl.visible = false
		turnCamRightCntrl.visible = false
		turnCamUpCntrl.visible = false
		turnCamDownCntrl.visible = false
	else:
		var checkedCamera : TextureRect = CheckCameraDirection(camera)
		checkedCamera.visible = false

func ShowCameraControl(camera : cameraDirections = cameraDirections.LEFT, showAll : bool = false) -> void:
	if(showAll == true):
		turnCamLeftCntrl.visible = true
		turnCamRightCntrl.visible = true
		turnCamUpCntrl.visible = true
		turnCamDownCntrl.visible = true
	else:
		var checkedCamera : TextureRect = CheckCameraDirection(camera)
		checkedCamera.visible = true

# helper function for the 4 above functions
func CheckCameraDirection(cameraDirection : cameraDirections) -> TextureRect:
	if(cameraDirection == cameraDirections.LEFT):
		return turnCamLeftCntrl
	elif(cameraDirection == cameraDirections.RIGHT):
		return turnCamRightCntrl
	elif(cameraDirection == cameraDirections.UP):
		return turnCamUpCntrl
	else: # down
		return turnCamDownCntrl

#endregion
