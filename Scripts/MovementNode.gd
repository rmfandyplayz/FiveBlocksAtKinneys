extends Marker3D
class_name MovementNode

@export var availableMovementNodes : Array[Marker3D] ## Nodes that an animatronic can potentially move to from this position.
@export var isOccupied : bool ## Is this node occupied by an animatronic?
@export var fairSpawn : bool ## Should this node be available for the animatronics to randomly spawn on at the start of each game?



## Returns a list of movement nodes that the animatronic may decide to move to.
func GetAvailableMoveNodes() -> Array[Marker3D]:
	var outputArray : Array[Marker3D]
	
	for i in availableMovementNodes:
		if(i.GetOccupationStatus() == false):
			outputArray.append(i)
	
	return outputArray
	


func GetFairSpawn() -> bool: return fairSpawn

# set isOccupied
func SetOccupationStatus(newStatus : bool) -> void: isOccupied = newStatus
func GetOccupationStatus() -> bool: return isOccupied
