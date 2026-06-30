extends Node

func exit():
	if(get_tree().current_scene.scene_file_path != "res://GUI/Exit/Exit.tscn"):
		GlobalVar.last_scene_path = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file("res://GUI/Exit/Exit.tscn")

func go_back():
	get_tree().change_scene_to_file(GlobalVar.last_scene_path)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		exit()

# Change to the scene with the corresponding name
func change_to_scene(scene_path: String):
	GlobalVar.last_scene_path = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(scene_path)
