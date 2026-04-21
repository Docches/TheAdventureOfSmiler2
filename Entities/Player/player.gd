extends Sprite2D

var speed = 10

func _ready():
	position.x = GlobalVar.player_position_x
	position.y = GlobalVar.player_position_y

func _physics_process(delta: float) -> void:
	# movement
	var direzioneO = Input.get_axis("move_left", "move_right")
	var direzioneV = Input.get_axis("move_up", "move_down")
	
	position.x += direzioneO * speed
	position.y += direzioneV * speed
	
	GlobalVar.player_position_x = position.x
	GlobalVar.player_position_y = position.y
	
	if(direzioneO<0):
		$PlayerAnimation.play("walk_left")
	elif(direzioneO>0):
		$PlayerAnimation.play("walk_right")
	elif(direzioneV>0):
		$PlayerAnimation.play("walk_down")
	elif(direzioneV<0):
		$PlayerAnimation.play("walk_up")
	else:
		$PlayerAnimation.stop()
		frame_coords.y = 0
