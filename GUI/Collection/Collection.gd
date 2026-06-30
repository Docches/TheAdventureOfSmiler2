extends Node

func _ready():
	var back_button = find_child("Back")
	back_button.pressed.connect(GlobalNav.change_to_scene.bind("res://GUI/Main/Main.tscn"))
