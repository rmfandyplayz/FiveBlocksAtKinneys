extends Node3D
class_name PlayerLaptop

## script for player laptop behaviors. also gives information on-demand,[br]
## such as which screen is the laptop on.


@export var susScreens : Array[CompressedTexture2D] = []
@export var nonSusScreens : Array[CompressedTexture2D] = []
@onready var laptopScreen : TextureRect = $SubViewport/OnScreenGUI/Display

var currentlySus : bool = false

func GetRandElement(arr: Array) -> CompressedTexture2D:
	if arr.is_empty():
		return null
	return arr[randi() % arr.size()]

# amongus reference
func IsLaptopSus() -> bool:
	return currentlySus 
	# this function is basically uselss
	# my subconcious say this is roblox and public does not exist
	# so here it is (realistically, just read `currentlySus`)

func _onSwitchScreenPressed() -> void:
	#print("pressed")
	currentlySus = not currentlySus
	var laptopImage : CompressedTexture2D = null
	
	if currentlySus:
		laptopImage = GetRandElement(susScreens)
	else:
		laptopImage = GetRandElement(nonSusScreens)
	laptopScreen.texture = laptopImage

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwitchScreen"):
		_onSwitchScreenPressed()
