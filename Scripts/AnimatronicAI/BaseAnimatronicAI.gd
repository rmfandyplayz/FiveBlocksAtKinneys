extends Node3D
class_name BaseAnimatronicAI

## The base class that all animatronics should inherit from

@export var aggressionLevel : float ## acts as a multiplier to things like [code]actionOpportunity[/code] and [code]timeBetweenActionOpportunities[/code]

@export var aiActivated : bool ## if set to false, it will disable the AI from doing ANYTHING. vice versa if otherwise

@export_group("Action Opportunities")
@export var actionOpportunity : float ## % chance for animatronic to do something each [code]timeBetweenActionOpportunities[/code]
@export var timeBetweenActionOpportunities : float ## some amount of seconds between each [code]actionOpportunity[/code]
@export var actionOpportunityTimer : Timer ## the actual timer itself keeping track of action opportunities


## disables animatronic AI, and resets & pauses their action opportunity timer
func ActivateAI() -> void:
	actionOpportunityTimer.start() # start() restarts the timer if it's already running... sucks they don't got restart()
	actionOpportunityTimer.paused = false
	aiActivated = false


## enables animatronic AI, and resets & unpauses their action opportunity timer
func DeactivateAI() -> void:
	actionOpportunityTimer.start()
	actionOpportunityTimer.paused = true
	aiActivated = true
	
func GetAiActivationStatus() -> bool:
	return aiActivated


## WARNING: YOU MUST OVERRIDE THIS FUNCTION in the top-level AI script for this animatronic.
## yes, it MUST BE THE SAME NAME. however, the functionality can be different!
func SpawnAnimatronic():
	push_error(get_path(), " top level AI script did not override SpawnAnimatronic() in inherited BaseAnimatronicAI script. Please override!")
	return false
