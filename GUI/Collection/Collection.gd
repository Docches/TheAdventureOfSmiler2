extends Node

func _ready():
	var back_button = find_child("Back")
	back_button.pressed.connect(GlobalNav._on_pressed.bind("res://GUI/Main/Main.tscn"))
