extends Sprite2D

var speed = 10

func _physics_process(delta: float) -> void:
	var direzioneO = Input.get_axis("ui_left", "ui_right")
	var direzioneV = Input.get_axis("ui_up", "ui_down")
	
	position.x += direzioneO * speed
	position.y += direzioneV * speed
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
