extends BaseAnimatronicAI
class_name Module_Transform

## Script (module) that allows the animatronic to perform random transformations

var listOfAllMovementNodes : Array[Node]

## chance for animatronic to [b]MOVE[/b] per [code]actionOpportunity[/code].[br]
##if this % chance doesn't hit, the animatronic will [b]rotate[/b] instead.
@export var actionMoveChance : float 
@export var actionOpportunityTimer : Timer

## returns a rotation of either +90 or -90 degrees
func RotateRandomly() -> float:
	var rotationRandom : int = randi_range(1, 2)

	if(rotationRandom == 1):
		return(rotation_degrees.y + 90)
	else:
		return(rotation_degrees.y - 90)


## returns a random movement node that the animatronic can move to[br]
## if the animatronic is stuck and can't move anywhere, it will return a random available move node on the map
func MoveRandomly() -> MovementNode:
	var randomNum : float = randf_range(1, 100)
	var stuck : bool = true
	
	if(actionMoveChance >= randomNum): # movement
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
			listOfAllMovementNodes = GameManager.GetAllMovementNodes()
			for i in len(listOfAllMovementNodes):
				var randomStuckMoveNode : MovementNode = listOfAllMovementNodes.pick_random()
				
				if(randomStuckMoveNode.GetOccupationStatus() == false):
					return randomStuckMoveNode
				else: # node is occupied; remove it from list of possibilities
					listOfAllMovementNodes.erase(randomStuckMoveNode)

	# it should NOT return null. the code should always return something.
	push_error(get_path(), " returned null when it should've returned a MovementNode for whatever tf reason.")
	return null
