extends CharacterBody2D

@onready var Sprite = $Sprite
@onready var animation_player = $Sprite/PlayerAnimation

var movement_enabled = true
var speed = 100.0

func _ready():
	add_to_group("player")
	GlobalVar.player = self
	position.x = GlobalVar.player_position_x
	position.y = GlobalVar.player_position_y

func _physics_process(delta: float) -> void:
	if movement_enabled:
		var direzioneO = Input.get_axis("move_left", "move_right")
		var direzioneV = Input.get_axis("move_up", "move_down")
		
		var direction = Vector2(direzioneO, direzioneV)
		
		if direction.length() > 0:
			direction = direction.normalized()
			
		velocity = direction * speed
		
		move_and_slide()
		
		GlobalVar.player_position_x = position.x
		GlobalVar.player_position_y = position.y
		
		if direzioneO < 0:
			animation_player.play("walk_left")
		elif direzioneO > 0:
			animation_player.play("walk_right")
		elif direzioneV > 0:
			animation_player.play("walk_down")
		elif direzioneV < 0:
			animation_player.play("walk_up")
		else:
			animation_player.stop()
			Sprite.frame_coords.y = 0
	else:
		velocity = Vector2.ZERO
		move_and_slide()

func wait_dialogue_end():
	animation_player.stop()
	movement_enabled = false

func dialogue_end():
	movement_enabled = true
