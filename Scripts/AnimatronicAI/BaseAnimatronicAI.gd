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
@export var actionMoveChance : float ## chance for animatronic to [b]MOVE[/b] per [code]actionOpportunity[/code]. [br]if this % chance doesn't hit, the bot will [b]rotate[/b] instead.
@export var actionOpportunityTimer : Timer

@export var screen : Node3D
var EyesightModule = preload("res://Scripts/AnimatronicAI/EyeSight.gd").new()

func SetCurrentMoveNode(node : MovementNode) -> void:
	currentMoveNode = node

## spawns the animatronic on the specified movement node and starts its AI
func SpawnAnimatronic(spawnNode : MovementNode) -> void:
	SetAnimatronicPosition(spawnNode)
	SetCurrentMoveNode(spawnNode)
	actionOpportunityTimer.wait_time = timeBetweenActionOpportunities
	actionOpportunityTimer.start()
	
	

## does what the name says. sets the pos of this animatronic to the pos of the movement node
func SetAnimatronicPosition(movementNode : MovementNode) -> void:
	position = movementNode.position
	EyesightModule.screen = screen
	var sawScreen : bool = EyesightModule.CanSeeScreen(self)
	
	print(sawScreen)
	

func GetPossibleMoveNodes() -> Array[MovementNode]:
	return currentMoveNode.GetAvailableMoveNodes()



var listOfAllMovementNodes : Array[Node]

## performs a movement action (rotation or movement)
## rotation chance is dependent on movement chance. if move chance doesn't hit, then rotate kicks in.
func PerformAction() -> void:
	var randomNum : float = randf_range(1, 100)
	var stuck : bool = true
	
	if(actionMoveChance >= randomNum): # movement
		for i in len(possibleMoveNodes):
			var randomMoveNode : MovementNode = possibleMoveNodes.pick_random()
			
			if(randomMoveNode.GetOccupationStatus() == false):
				SetAnimatronicPosition(randomMoveNode)
				currentMoveNode.SetOccupationStatus(false)
				randomMoveNode.SetOccupationStatus(true)
				SetCurrentMoveNode(randomMoveNode)
				stuck = false
				break
			else: # node is occupied and we need to remove it from the list of possibilities
				possibleMoveNodes.erase(randomMoveNode)
		
		#if the loop doesn't break, it means there are no possible places to move to
		#in this case, the animatronic will teleport to a random, unoccupied location on the map
		if(stuck == true):
			listOfAllMovementNodes = GameManager.GetAllMovementNodes()
			for i in len(listOfAllMovementNodes):
				var randomMoveNode : MovementNode = listOfAllMovementNodes.pick_random()
				
				if(randomMoveNode.GetOccupationStatus() == false):
					SetAnimatronicPosition(randomMoveNode)
					currentMoveNode.SetOccupationStatus(false)
					randomMoveNode.SetOccupationStatus(true)
					SetCurrentMoveNode(randomMoveNode)
					break
				else: # node is occupied; remove it from list of possibilities
					listOfAllMovementNodes.erase(randomMoveNode)
		
		

	else: # rotation (50% for + or - 90 degrees)
		var rotationRandom : int = randi_range(1, 2)

		if(rotationRandom == 1):
			rotation_degrees.y += 90
		elif(rotationRandom == 2):
			rotation_degrees.y -= 90
