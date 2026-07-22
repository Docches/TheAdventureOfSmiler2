extends Area2D

@export var trigger_type = "onEnter"
@export var dialogue_id = "debug"
@export var total_phrase = 2
@export var total_times = 1
var times = 0

@export var disabled = false

@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var interaction_frame: int = 0

var phrase = 1
var triggered = false
var player_in_range = false


@onready var debug_area_cast = $debug_area_cast

signal dialogue_triggered(dialogue_id: String, phrase: int, total: int)

func _ready():
	add_to_group("dialogue_triggers")
	debug_area_cast.visible = GlobalVar.debug_mode
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if animation_player != null:
		if animation_player.has_animation("idle"):
			animation_player.play("idle")
	


func _physics_process(delta):
	if trigger_type == "byInteract":
		if player_in_range and Input.is_action_just_pressed("interact_dialogue"):
			trigger_dialogue()


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		if animation_player != null:
			animation_player.stop()
		if sprite != null:
			sprite.frame = interaction_frame
		if trigger_type == "onEnter":
			trigger_dialogue()


func _on_body_exited(body):
	if body.is_in_group("player"):
		if animation_player != null:
			if animation_player.has_animation("idle"):
				animation_player.play("idle")
		player_in_range = false


func trigger_dialogue():
	if not triggered and times < total_times:
		triggered = true
		times+=1
		GlobalVar.player.wait_dialogue_end()
		if trigger_type == "byInteract":
			phrase-=1
		dialogue_triggered.emit(dialogue_id, phrase, total_phrase)
		triggered = false
	elif not triggered and total_times == -1:
		triggered = true
		GlobalVar.player.wait_dialogue_end()
		if trigger_type == "byInteract":
			phrase-=1
		dialogue_triggered.emit(dialogue_id, phrase, total_phrase)
		triggered = false
