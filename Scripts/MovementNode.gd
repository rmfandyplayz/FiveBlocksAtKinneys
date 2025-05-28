extends Marker3D
class_name MovementNode

@export var coordinates : Vector2i ## stores the coordinates for the movement node. [code](0, 0)[/code] is mr. kinney's seat. [br][code]x[/code] is row, [code]y[/code] is column 
@export var availableMovementNodes : Array[MovementNode] ## Nodes that an animatronic can potentially move to from this position.
@export var isOccupied : bool ## Is this node occupied by an animatronic?
@export var fairSpawn : bool ## Should this node be available for the animatronics to randomly spawn on at the start of each game?



## Returns a list of movement nodes an animatronic may move to.
func GetAvailableMoveNodes() -> Array[MovementNode]:
	var outputArray : Array[MovementNode]
	
	for i in availableMovementNodes:
		if(i.GetOccupationStatus() == false):
			outputArray.append(i)
	
	return outputArray
	


func GetFairSpawn() -> bool: 
	return fairSpawn

# set isOccupied
func SetOccupationStatus(newStatus : bool) -> void: 
	isOccupied = newStatus

## returns true if is occupied. false if otherwise
func GetOccupationStatus() -> bool: 
	return isOccupied
