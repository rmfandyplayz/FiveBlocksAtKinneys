extends Node3D
class_name BaseAnimatronicAI

@export var aggressionLevel : int # basically works identically to fnaf's AI Level
@export var actionOpportunity : float # % chance for animatronic to do something each second
@export var viewDistanceHitbox : Area3D # the area3d that acts as the "hitbox" for the AI
@export var possibleMoveNodes : Array[BaseAnimatronicAI] ## a list of possible nodes that the animatronic may decide to move to

var currentMoveNode : MovementNode
@export var availableMoveNodes : Array[MovementNode]

## meant for other scripts to initially assign a movement node to an animatronic
func AssignMoveNode(node : MovementNode):
	currentMoveNode = node

## performs a movement action (rotation or movement)
func PerformAction():
	var randomNum = randi_range(1, 100)
	
	if(randomNum <= 30): # rotation (50% for + or - 90 degrees)
		var rotationRandom = randi_range(1, 2)
		
		if(rotationRandom == 1):
			rotation_degrees.x += 90
		elif(rotationRandom == 2):
			rotation_degrees.x -= 90
			
	elif(randomNum >= 31): # movement
		for i in len(availableMoveNodes):
			var randomMoveNode : MovementNode = availableMoveNodes.pick_random()
			
