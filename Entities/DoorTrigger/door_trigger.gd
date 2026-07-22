extends Area2D

@export_enum("onEnter", "byInteract") var trigger_type = "byInteract"
@export_file("*.tscn") var target_scene_path: String
@export var spawn_point: Vector2

var player_in_range = false
var teleporting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Doors")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if trigger_type == "byInteract":
		if player_in_range and Input.is_action_just_pressed("interact_door"):
			teleport_player()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		if trigger_type == "onEnter":
			teleport_player()
	
func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
	
func teleport_player():
	if target_scene_path != "" and not teleporting:
		teleporting = true
		GlobalVar.player.movement_enabled = false
		GlobalVar.player_position_x = spawn_point.x
		GlobalVar.player_position_y = spawn_point.y
		GlobalVar.current_map = target_scene_path
		get_tree().change_scene_to_file(target_scene_path)
