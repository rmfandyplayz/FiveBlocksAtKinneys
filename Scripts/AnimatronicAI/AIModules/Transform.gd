extends Node
class_name Module_Transform

## Script (module) that allows the animatronic to perform transformations of ANY form

var listOfAllMovementNodes : Array[Node]
var possibleMoveNodes : Array[MovementNode] ## a list of possible nodes that the animatronic may decide to move to

var currentMoveNode : MovementNode ## the current movement node the animatronic is sitting on

@export_group("Actions & Stuff")
## chance for animatronic to [b]MOVE[/b] per [code]actionOpportunity[/code].[br]
##if this % chance doesn't hit, the animatronic will [b]rotate[/b] instead.
@export var actionMoveChance : float

## returns a rotation of either +90 or -90 degrees
func RotateRandomly(currentRotation : int) -> int:
	var rotationRandom : int = randi_range(1, 2)

	if(rotationRandom == 1):
		return(currentRotation + 90)
	else:
		return(currentRotation - 90)


## returns a random movement node that the animatronic can move to[br]
## if the animatronic is stuck and can't move anywhere, it will return a random available move node on the map
func MoveRandomly() -> MovementNode:
	var stuck : bool = true
	possibleMoveNodes = GetPossibleMoveNodes()
	
	for i in len(possibleMoveNodes):
		var randomMoveNode : MovementNode = possibleMoveNodes.pick_random()
		
		if(randomMoveNode.GetOccupationStatus() == false):
			stuck = false
			return randomMoveNode
		else: # node is occupied and we need to remove it from the list of possibilities
			possibleMoveNodes.erase(randomMoveNode)
	
	#if the loop doesn't return, it means there are no possible places to move to
	#in this case, the animatronic will teleport to a random, unoccupied location on the map
	if(stuck == true):
		return TeleportToRandomLocation(false)
			
	# it should NOT return null. the code should always return something.
	push_error(get_path(), " function MoveRandomly() returned null when it should've returned a MovementNode for whatever tf reason.")
	return null


## returns a random movement node of the entire map that the animatronic can move to
## if [code]mustBeFairSpawn[/code] is enabled, it will only return random movement nodes where [code]fairSpawn[/code] is enabled
func TeleportToRandomLocation(mustBeFairSpawn : bool = false) -> MovementNode:
	listOfAllMovementNodes = GameManager.GetAllMovementNodes()
	
	for i in len(listOfAllMovementNodes):
		var randomStuckMoveNode : MovementNode = listOfAllMovementNodes.pick_random()
		
		if(randomStuckMoveNode.GetOccupationStatus() == false): # must be unoccupied
			if(mustBeFairSpawn == true): # does an extra check if that unoccupied move node is also a fair spawn
				if(randomStuckMoveNode.GetFairSpawn() == true):
					return randomStuckMoveNode
			else:
				return randomStuckMoveNode
		else: # node is occupied; remove it from list of possibilities
			listOfAllMovementNodes.erase(randomStuckMoveNode)
	
	push_error(get_path(), " function TeleportToRandomLocation() returned null when it should've returned a MovementNode...")
	return null

func SetCurrentMoveNode(newMoveNode : MovementNode) -> void:
	currentMoveNode = newMoveNode

func GetCurrentMoveNode() -> MovementNode:
	return currentMoveNode

func GetPossibleMoveNodes() -> Array[MovementNode]:
	return currentMoveNode.GetAvailableMoveNodes()
