extends Node3D
class_name PlayerLaptop

## script for player laptop behaviors. also gives information on-demand,[br]
## such as which screen is the laptop on.

@export var susScreens : Array[CompressedTexture2D] = []
@export var nonSusScreens : Array[CompressedTexture2D] = []
@onready var laptopScreen : TextureRect = $SubViewport/OnScreenGUI/Display

var CurrentlySus : bool = false

func getRandElement(arr: Array) -> CompressedTexture2D:
	if arr.is_empty():
		return null
	return arr[randi() % arr.size()]

func  isLaptopSus() -> bool :
	return CurrentlySus 
	# this function is basically uselss
	# my subconcious say this is roblox and public does not exist
	# so here it is (realistically, just read `CurrentlySus`)

func onSwitchScreenPressed() -> void:
	#print("pressed")
	CurrentlySus = not CurrentlySus
	var laptopImage : CompressedTexture2D = null
	if CurrentlySus :
		laptopImage = getRandElement(susScreens)
	else :
		laptopImage = getRandElement(nonSusScreens)
	laptopScreen.texture = laptopImage

func  _process(delta: float) -> void:
	if Input.is_action_just_pressed("SwitchScreen") :
		onSwitchScreenPressed()
