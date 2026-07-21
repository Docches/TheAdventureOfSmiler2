extends CRPG_Combatant
class_name CRPG_Player


@export_group("Player Data")
@export var level: int = 1
@export var experience: int = 0

@export var sprite_frames: SpriteFrames


@export_group("Progression")
@export var equipment: Array[Resource] = []
@export var inventory: Array[Resource] = []


func initialize():
	super.initialize()


func gain_experience(amount:int):
	experience += amount


func level_up():
	level += 1

	max_hp += 5
	max_mana += 1

	atk += 1
	armor += 1

	magic += 1
	magic_resistance += 1

	speed += 1

	# refill after level up
	hp = max_hp
	mana = max_mana

func end_combat():
	# Status effects never survive battles
	clear_status()
