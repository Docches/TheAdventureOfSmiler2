extends Control


@onready var attack_button = $CombatActionsContainer/MainContainer/Option1Container/AttackButton
@onready var spells_button = $CombatActionsContainer/MainContainer/Option2Container/SpellsButton
@onready var items_button = $CombatActionsContainer/MainContainer/Option3Container/ItemsButton
@onready var run_button = $CombatActionsContainer/MainContainer/Option4Container/RunButton

@onready var attack_container = $CombatActionsContainer/AttackContainer
@onready var spells_container = $CombatActionsContainer/SpellsContainer
@onready var items_container = $CombatActionsContainer/ItemsContainer

@onready var foe_containers = [
	$CombatSceneContainer/FoesContainer/Foe1Container,
	$CombatSceneContainer/FoesContainer/Foe2Container,
	$CombatSceneContainer/FoesContainer/Foe3Container
]

const path_to_sprite = "/HBoxContainer/VBoxContainer/FoeSprite"
const path_to_hp = "/HBoxContainer/VBoxContainer/DefensiveStatsContainer/HpContainer/HpLabel"
const path_to_armor = "/HBoxContainer/VBoxContainer/DefensiveStatsContainer/ArmorContainer/ArmorLabel"
const path_to_magic_resistence = "/HBoxContainer/VBoxContainer/DefensiveStatsContainer/MagicResistenceContainer/MagicResistenceLabel"
const path_to_attack = "/HBoxContainer/OffensiveStatsContainer/AttackContainer/AttackLabel"
const path_to_magic = "/HBoxContainer/OffensiveStatsContainer/MagicContainer/MagicLabel"
const path_to_mana = "/HBoxContainer/OffensiveStatsContainer/ManaContainer/ManaLabel"
const path_to_selected = "/HBoxContainer/VBoxContainer/SelectedIcon"


var combat: CRPG_Combat
var player: CRPG_Player

var current_wave := 0

var foes: Array[CRPG_Foe] = []

var turn_order: Array[CRPG_Combatant] = []
var turn_index := 0
