extends Node3D
class_name BaseAnimatronicAI

@export var aggressionLevel : int # basically works identically to fnaf's AI Level
@export var actionOpportunity : float # % chance for animatronic to do something each second
@export var viewDistanceHitbox : Area3D # the area3d that acts as the "hitbox" for the AI
