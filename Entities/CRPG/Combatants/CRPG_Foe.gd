extends CRPG_Combatant
class_name CRPG_Foe


@export_group("Foe Data")
@export var sprite_frames: SpriteFrames
@export_multiline var lore: String


@export_group("AI")
@export var ai_type: String = "basic"


@export_group("Rewards")
@export var experience_reward: int = 10
@export var gold_reward: int = 5


func get_ai_action() -> CRPG_CombatAction:
	match ai_type:
		"basic":
			return basic_ai()

		"random":
			return random_ai()

	return null


func basic_ai() -> CRPG_CombatAction:
	for action in actions:
		if action != null:
			return action

	return null


func random_ai() -> CRPG_CombatAction:
	var available := actions.filter(func(action):
		return action != null
	)

	if available.is_empty():
		return null

	return available.pick_random()


func take_turn(targets: Array[CRPG_Combatant]) -> void:
	var action := get_ai_action()

	if action == null:
		return

	action.execute(self, targets)


func end_combat() -> void:
	clear_status()
