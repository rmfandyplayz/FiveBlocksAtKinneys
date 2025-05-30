extends Node

## a global script for the game scene that will control certain things, and has some 
## utility functions that any script within the game can use

static var movementNodeParent : Node # the node that holds all MovevementNodes

@export var availableAnimatronics : Array[BaseAnimatronicAI] ## a list of animatronics that will be spawned this game


func _ready() -> void:
	movementNodeParent = get_node("/root/Game/MovementNodes")
	
	for animatronic : BaseAnimatronicAI in availableAnimatronics:
		animatronic.SpawnAnimatronic()



static func GetAllMovementNodes() -> Array[Node]:
	return movementNodeParent.get_children()
	
