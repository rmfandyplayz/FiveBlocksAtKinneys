## documentation: it make you see stuff

## IMPORTANT: It is assumed that -Z is forward
extends Node

#const screenAngle : float = deg_to_rad(5) -- deprecated
const maxEyesightDistance : float = 3600
@export var screen : Node3D

func _withinMaxDistance(difference : Vector3) -> bool:
	return difference.length() < maxEyesightDistance

## If the position of the screen is not behind the enemy's back
func _screenIsInFrontOfEnemy(look : Vector3, diff : Vector3) -> bool :
	return look.dot(diff) > 0 # Could be the other way I suck at math idk

func _acceptablyFacingTowardScreen(look : Vector3) -> bool :
	var screenFront : Vector3 = -screen.get_transform().basis.z
	# facing each other?
	return screenFront.dot(look) < 0 

func CanSeeScreen(animatronic : Node3D) -> bool:
	if screen == null :
		return false # can't see something that's not there
	var differenceVector : Vector3 = screen.position - animatronic.position
	var lookvector : Vector3 = -animatronic.get_transform().basis.z
	var result : bool = (
		_withinMaxDistance(differenceVector) 
		and _screenIsInFrontOfEnemy(lookvector,differenceVector)
		and _acceptablyFacingTowardScreen(lookvector)
	)
	return result
