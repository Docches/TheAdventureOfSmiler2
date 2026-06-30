extends Area2D

@export var trigger_type = "byInteract"
@export var combat_id = "debug"

@export var disabled = false

var triggered = false
var player_in_range = false

@onready var debug_area_cast = $debug_area_cast

signal combat_triggered(combat_id: String)

func _ready():
	add_to_group("combat_triggers")
	debug_area_cast.visible = GlobalVar.debug_mode
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta):
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
	if not triggered:
		triggered = true
		combat_triggered.emit(combat_id)
		GlobalNav.change_to_scene("res://GUI/Play/Combat/Combat.tscn")
