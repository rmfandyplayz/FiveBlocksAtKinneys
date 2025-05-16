extends BaseAnimatronicAI
class_name BaseTAAI

## Base Class for all Teacher Assistant AI's

@export var aggressionModifier : float ## how much will mr kinney's aggression level multiply by when TA catches the player lacking

func	 _ready() -> void:
	SpawnAnimatronic(temp_spawnLocation)

func _on_action_opportunity_timer_timeout() -> void:
	var randomNum : float = randf_range(1, 100)

	if(actionOpportunity >= randomNum):
		possibleMoveNodes = GetPossibleMoveNodes()
		PerformAction()

	actionOpportunityTimer.start()
	
	
