extends Resource
class_name CRPG_Combatant


@export_group("Info")
@export var name: String
@export var portrait: Texture2D
@export_multiline var description: String


@export_group("Base Stats")
@export var max_hp: int = 10
@export var max_mana: int = 2

@export var atk: int = 2
@export var armor: int = 1

@export var magic: int = 2
@export var magic_resistance: int = 1

@export var speed: int = 1

@export_range(0.0, 1.0)
var accuracy := 1.0

@export_range(0.0, 1.0)
var crit := 0.0


@export_group("Combat")
@export var actions: Array[CRPG_CombatAction]


# Runtime values
var hp: int
var mana: int

var status_effects: Array[Dictionary] = []


func initialize():
	hp = max_hp
	mana = max_mana
	status_effects.clear()


func reset_combat_status():
	status_effects.clear()


func take_damage(amount: int):
	hp = max(0, hp - amount)


func heal(amount: int):
	hp = min(max_hp, hp + amount)


func restore_mana(amount: int):
	mana = min(max_mana, mana + amount)


func drain_mana(amount: int):
	mana = max(0, mana - amount)


func modify_atk(amount:int):
	atk += amount


func modify_armor(amount:int):
	armor += amount


func modify_magic(amount:int):
	magic += amount


func modify_magic_resistance(amount:int):
	magic_resistance += amount


func modify_speed(amount:int):
	speed += amount


func modify_accuracy(amount:float):
	accuracy = clamp(accuracy + amount, 0.0, 1.0)


func modify_crit(amount:float):
	crit = clamp(crit + amount, 0.0, 1.0)


func add_status(effect_name:String, power:int):
	status_effects.append({
		"name": effect_name,
		"power": power
	})


func remove_status(effect_name:String):
	for status in status_effects:
		if status["name"] == effect_name:
			status_effects.erase(status)
			return


func clear_status():
	status_effects.clear()


func has_status(effect_name:String)->bool:
	for status in status_effects:
		if status["name"] == effect_name:
			return true

	return false


func is_dead()->bool:
	return hp <= 0
