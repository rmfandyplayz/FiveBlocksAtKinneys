extends BaseTAAI
class_name SanicAI

## the AI script specific to sanic

@export_group("AI Modules")
@export var eyesightModule : Module_EyeSight
@export var transformModule : Module_Transform

func _ready() -> void:
	eyesightModule.SetScreenObject(%PlayerLaptop)
	actionOpportunityTimer.wait_time = timeBetweenActionOpportunities

## spawns the animatronic onto a random fairSpawn movement node and activates its AI
func SpawnAnimatronic() -> void:
	var randTpPos : MovementNode = transformModule.TeleportToRandomLocation(true)
	rotation.y = transformModule.RotateRandomly(rotation.y)
	
	transformModule.SetCurrentMoveNode(randTpPos)
	position = randTpPos.position
	
	ActivateAI()


func _on_action_opportunity_timer_timeout() -> void:
	var actionRandomNum : float = randf_range(0, 100)
	
	if(actionRandomNum <= transformModule.actionMoveChance):
		var newMoveNode : MovementNode = transformModule.MoveRandomly()
		position = newMoveNode.position
		transformModule.SetCurrentMoveNode(newMoveNode)
	elif(actionRandomNum > transformModule.actionMoveChance):
		rotation.y = transformModule.RotateRandomly(rotation.y)
		
	if(eyesightModule.CanSeeScreen(self)):
		if(%PlayerLaptop.IsLaptopSus() == true):
			print("lose")
			get_tree().change_scene_to_file("res://Scenes/TestScene.tscn")
			return
		else:
			print("safe")
	
	actionOpportunityTimer.start()
