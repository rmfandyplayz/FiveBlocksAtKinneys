extends Node

## a global script for the game scene that will control certain things, and has some 
## utility functions that any script within the game can use

static var movementNodeParent : Node

func _ready() -> void:
	movementNodeParent = get_node("/root/Block1/MovementNodes")


static func GetAllMovementNodes() -> Array[Node]:
	return movementNodeParent.get_children()
