extends CharacterBody2D

@onready var Sprite = $Sprite
@onready var animation_player = $Sprite/PlayerAnimation
@onready var camera = $Camera2D

var movement_enabled = true
var speed = 150

func _ready():
	add_to_group("player")
	GlobalVar.player = self
	global_position.x = GlobalVar.player_position_x
	global_position.y = GlobalVar.player_position_y
	if camera:
		camera.position_smoothing_enabled = false
		camera.reset_smoothing()
		camera.force_update_scroll()
		await get_tree().process_frame
		camera.position_smoothing_enabled = true
	
	
func _physics_process(delta: float) -> void:
	# movement
	if movement_enabled:
		var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = (input_dir * speed).round()
		move_and_slide()
		
		GlobalVar.player_position_x = global_position.x
		GlobalVar.player_position_y = global_position.y
		
		if(input_dir.x<0):
			animation_player.play("walk_left")
		elif(input_dir.x>0):
			animation_player.play("walk_right")
		elif(input_dir.y>0):
			animation_player.play("walk_down")
		elif(input_dir.y<0):
			animation_player.play("walk_up")
		else:
			animation_player.stop()
			Sprite.frame_coords.y = 0

func wait_dialogue_end():
	animation_player.stop()
	movement_enabled = false

func dialogue_end():
	movement_enabled = true
