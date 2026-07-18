extends Area2D

enum gameplay {CRPG, ARPG, TBT_RPG, VSRG}

var combat_scene = {
	gameplay.CRPG : "res://GUI/Play/Combat/CRPG/Combat.tscn",
	gameplay.ARPG : "res://GUI/Play/Combat/ARPG/Combat.tscn",
	gameplay.TBT_RPG : "res://GUI/Play/Combat/TBT_RPG/Combat.tscn",
	gameplay.VSRG : "res://GUI/Play/Combat/VSRG/Combat.tscn"
}

@export var trigger_type = "byInteract"
@export var combat_id = "debug"
@export var combat_gameplay: gameplay = gameplay.CRPG
@export var disabled = false

var triggered = false
var player_in_range = false

@onready var debug_area_cast = $debug_area_cast


func _ready():
	add_to_group("combat_triggers")
	debug_area_cast.visible = GlobalVar.debug_mode
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(_delta):
	if trigger_type == "byInteract":
		if player_in_range and Input.is_action_just_pressed("interact_combat"):
			trigger_combat()


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		if trigger_type == "onEnter":
			trigger_combat()


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false


func trigger_combat():
	if triggered:
		return

	triggered = true

	GlobalVar.current_combat = combat_id
	GlobalNav.change_to_scene(combat_scene[combat_gameplay])
