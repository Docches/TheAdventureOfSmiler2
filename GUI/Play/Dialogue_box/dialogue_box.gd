extends CanvasLayer

@onready var dialogue_text = $MarginContainer/MarginContainer/Label
@onready var next_button = $MarginContainer/Next

var dialogue
var phrase
var total

func _ready():
	for trigger in get_tree().get_nodes_in_group("dialogue_triggers"):
		trigger.dialogue_triggered.connect(_on_dialogue_triggered)
	next_button.pressed.connect(_next_phrase)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact_dialogue"):
		_next_phrase()

func _on_dialogue_triggered(id: String, n: int, t: int):
	self.visible = true
	dialogue = id
	phrase = n
	total = t
	dialogue_text.text = format_placeholder(dialogue, phrase)

func _next_phrase():
	if phrase == total:
		self.visible = false
		GlobalVar.player.dialogue_end()
	else:
		phrase+=1
		dialogue_text.text = format_placeholder(dialogue, phrase)
	
func format_placeholder(id, n):
	return "@dialogue_%s_%d@" % [id, n]
