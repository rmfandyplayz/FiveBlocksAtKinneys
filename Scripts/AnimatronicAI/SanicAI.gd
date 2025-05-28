extends BaseTAAI
class_name SanicAI

@export_group("AI Modules")
@export var eyesightModule : Module_EyeSight
@export var transformModule : Module_Transform

func _ready() -> void:
	eyesightModule.SetScreenObject(%PlayerLaptop)
	print(eyesightModule.CanSeeScreen(self))
