extends Node

func _ready():
	GlobalVar.save_settings()
	GlobalVar.save_statistics()
	if GlobalVar.auto_save:
		GlobalVar.save_data(GlobalVar.using_save)
	find_child("Confirm").pressed.connect(get_tree().quit)
	find_child("Cancel").pressed.connect(GlobalNav.go_back)
