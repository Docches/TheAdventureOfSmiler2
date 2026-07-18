extends Control

@onready var dialogue_box = $DialogueBox
@onready var attack_button = $CombatActionsContainer/HBoxContainer/Option1Container/AttackButton
@onready var spells_button = $CombatActionsContainer/HBoxContainer/Option2Container/SpellsButton
@onready var items_button = $CombatActionsContainer/HBoxContainer/Option3Container/ItemsButton
@onready var run_button = $CombatActionsContainer/HBoxContainer/Option4Container/RunButton
@onready var foe_sprites: Array[AnimatedSprite2D] = [
	$CombatSceneContainer/FoesContainer/Foe1Container/Foe1,
	$CombatSceneContainer/FoesContainer/Foe2Container/Foe2,
	$CombatSceneContainer/FoesContainer/Foe3Container/Foe3,
]

var combat: CRPG_Combat
var current_wave := 0


func _ready() -> void:
	load_combat(GlobalVar.current_combat)
	run_button.pressed.connect(GlobalNav.change_to_scene.bind(GlobalVar.current_map))


func load_combat(combat_id: String) -> void:
	var path := "res://Combats/CRPG/%s.tres" % combat_id
	combat = load(path) as CRPG_Combat
	
	if combat == null:
		push_error("Failed to load combat: %s" % path)
		return
	
	current_wave = 0
	load_wave(current_wave)


func load_wave(wave_index: int) -> void:
	if wave_index < 0 or wave_index >= combat.waves.size():
		return
	
	var wave := combat.waves[wave_index]
	
	dialogue_box._on_dialogue_triggered(wave.dialogue_id, wave.phrase, wave.total)
	
	for sprite in foe_sprites:
		sprite.sprite_frames = null
		sprite.visible = false
	
	for i in range(min(wave.foes.size(), foe_sprites.size())):
		var foe := wave.foes[i]
		var sprite := foe_sprites[i]
	
		sprite.sprite_frames = foe.sprite_frames
		sprite.animation = "idle"
		sprite.play()
		sprite.visible = true
