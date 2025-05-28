extends Node3D
class_name BaseAnimatronicAI

## The base class that all animatronics should inherit from

@export var temp_spawnLocation : MovementNode ## REMOVE LATER

@export var aggressionLevel : float ## acts as a multiplier to things like [code]actionOpportunity[/code] and [code]timeBetweenActionOpportunities[/code]

@export_group("Action Opportunities")
@export var actionOpportunity : float ## % chance for animatronic to do something each [code]timeBetweenActionOpportunities[/code]
@export var timeBetweenActionOpportunities : float ## some amount of seconds between each [code]actionOpportunity[/code]
