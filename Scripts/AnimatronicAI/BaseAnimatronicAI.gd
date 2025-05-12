extends Node3D
class_name BaseAnimatronicAI

@export var temp_spawnLocation : MovementNode ## REMOVE LATER

@export var aggressionLevel : float ## acts as a multiplier to things like [code]actionOpportunity[/code] and [code]timeBetweenActionOpportunities[/code]
@export var viewDistanceHitbox : Area3D ## the area3d that acts as the "hitbox" for the AI

@export_group("Movement Nodes")
var possibleMoveNodes : Array[MovementNode] ## a list of possible nodes that the animatronic may decide to move to
var currentMoveNode : MovementNode ## the current movement node the animatronic is sitting on

@export_group("Action Opportunities")
@export var actionOpportunity : float ## % chance for animatronic to do something each [code]timeBetweenActionOpportunities[/code]
@export var timeBetweenActionOpportunities : float ## some amount of seconds between each [code]actionOpportunity[/code]
@export var actionRotationChance : float ## chance for animatronic to [b]ROTATE[/b] per [code]actionOpportunity[/code]
@export var actionMoveChance : float ## chance for animatronic to [b]MOVE[/b] per [code]actionOpportunity[/code]
@export var actionOpportunityTimer : Timer


func SetCurrentMoveNode(node : MovementNode):
	currentMoveNode = node

## spawns the animatronic on the specified movement node and starts its AI
func SpawnAnimatronic(spawnNode : MovementNode):
	SetAnimatronicPosition(spawnNode)
	SetCurrentMoveNode(spawnNode)
	actionOpportunityTimer.wait_time = timeBetweenActionOpportunities
	actionOpportunityTimer.start()
	
	

## does what the name says. sets the pos of this animatronic to the pos of the movement node
func SetAnimatronicPosition(movementNode : MovementNode):
	print(movementNode)
	position = movementNode.position
	

func GetPossibleMoveNodes() -> Array[MovementNode]:
	print(len(currentMoveNode.GetAvailableMoveNodes()), " available move nodes.")
	return currentMoveNode.GetAvailableMoveNodes()


## performs a movement action (rotation or movement)
func PerformAction(): # so far, it's 30% chance of rotation and 70% chance of movement
	var randomNum = randf_range(1, 100)
	print(randomNum)
	
	
	if(actionRotationChance >= randomNum): # rotation (50% for + or - 90 degrees)
		print("ROTATE")
		var rotationRandom = randi_range(1, 2)

		if(rotationRandom == 1):
			rotation_degrees.y += 90
		elif(rotationRandom == 2):
			rotation_degrees.y -= 90

	elif(actionMoveChance >= randomNum): # movement
		print("MOVE")
		for i in len(possibleMoveNodes):
			var randomMoveNode : MovementNode = possibleMoveNodes.pick_random()
			
			if(randomMoveNode.GetOccupationStatus() == false):
				SetAnimatronicPosition(randomMoveNode)
				currentMoveNode.SetOccupationStatus(false)
				randomMoveNode.SetOccupationStatus(true)
				SetCurrentMoveNode(randomMoveNode)
				break
				
			#TODO: if there are no possible places to move, animatronic will move to some random spot on the map
