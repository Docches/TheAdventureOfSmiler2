extends Resource
class_name CRPG_Wave

@export var dialogue_id: String
@export var phrase: int
@export var total: int

@export var foes: Array[CRPG_Foe] = []

func _init():
	changed.connect(validate)

func validate():
	if foes.size() > 3:
		foes.resize(3)
