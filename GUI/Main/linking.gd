extends VBoxContainer

# connect all buttons automatically
func _ready():
	# loop through all children
	for button in get_children():
		if button is Button:
			var scene_path = "res://GUI/%s/%s.tscn" % [button.name , button.name]
			button.pressed.connect(GlobalNav._on_pressed.bind(scene_path))
