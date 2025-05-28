extends Node3D
class_name BaseAnimatronicAI

## The base class that all forms of AI should inherit from. Contains crucial
## info for all subsequent animatronic scripts.

@export var temp_spawnLocation : MovementNode ## REMOVE LATER

@export var aggressionLevel : float ## acts as a multiplier to things like [code]actionOpportunity[/code] and [code]timeBetweenActionOpportunities[/code]

@export_group("Movement Nodes")
var possibleMoveNodes : Array[MovementNode] ## a list of possible nodes that the animatronic may decide to move to
var currentMoveNode : MovementNode ## the current movement node the animatronic is sitting on

@export_group("Action Opportunities")
@export var actionOpportunity : float ## % chance for animatronic to do something each [code]timeBetweenActionOpportunities[/code]
@export var timeBetweenActionOpportunities : float ## some amount of seconds between each [code]actionOpportunity[/code]


## sets the position of the animatronic to the input movementNode's position[br]
func SetAnimatronicPosition(movementNode : MovementNode) -> void:
	position = movementNode.position
	currentMoveNode = movementNode

func GetPossibleMoveNodes() -> Array[MovementNode]:
	return currentMoveNode.GetAvailableMoveNodes()
