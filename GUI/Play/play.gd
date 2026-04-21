extends Control

func _ready():
	var back_button = find_child("Back")
	back_button.pressed.connect(GlobalNav._on_pressed.bind("res://GUI/Main/Main.tscn"))
	
	for i in range(1, 7):
		var save_button = find_child("Save" + str(i) + "Button")
		save_button.pressed.connect(load_save.bind(i-1))
		
		var config = ConfigFile.new()
		config.load(GlobalVar.saves[i-1])
		var map = config.get_value("save", "map", "")
		var time = config.get_value("save", "playtime", 0)
		time = Formatting.seconds_to_hours_minutes(time)
		
		var save_info = find_child("Save" + str(i) + "Info")
		save_info.text = "Map: " + map + "\nPlayed time: " + time

func load_save(save_number: int):
	GlobalVar.load_data(save_number)
	GlobalNav._on_pressed("res://Entities/Player/player.tscn")
