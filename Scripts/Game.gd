extends Node
class_name Game

## a global script for the game scene that will control certain things, and has some 
## utility functions that any script within the game can use

static var movementNodeParent : Node

func _ready() -> void:
	movementNodeParent = $MovementNodes


static func GetAllMovementNodes():
	return movementNodeParent.get_children()
