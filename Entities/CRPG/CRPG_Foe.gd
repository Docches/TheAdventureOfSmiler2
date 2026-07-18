extends Resource
class_name CRPG_Foe

@export var name: String
@export var sprite_frames: SpriteFrames
@export var description: String

@export var hp: int
@export var atk: int
@export var armor: int

func attack():
	pass

func special_ability():
	pass

func on_every_turn():
	pass
