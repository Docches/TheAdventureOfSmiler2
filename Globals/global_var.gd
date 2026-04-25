extends Node

# file paths
var setting_file = "user://settings.cfg"
var statistic_file = "user://statistics.cfg"
var saves = ["user://save_1.cfg", "user://save_2.cfg", "user://save_3.cfg", 
			"user://save_4.cfg", "user://save_5.cfg", "user://save_6.cfg"]

# global variables
const supported_languages = ["en", "it", "zh", "ja"]
const supported_fps_caps = [30, 60, 90, 120, 0]
var last_scene_path : String = ""

	# system variables
var using_save : int = -1

	# setting variables
var current_language : String = "en"
var fps_cap : int = 60
var music_volume : int = 100
var sound_volume : int = 100
var auto_save : bool = true
var auto_pause : bool = false

	# statistics variables
var total_play_time : float = 0

	# data variables
var save_play_time : float = 0
var current_play_time : float = 0
var current_map : String = ""
var player_position_x : float = 0
var player_position_y : float = 0

func _ready():
	load_settings()
	load_statistics()

func _process(delta):
	if using_save!=-1:
		current_play_time += delta

# loading and saving functions
func load_settings():
	var config = ConfigFile.new()
	var err = config.load(setting_file)
	
	if err == OK:
		# load language
		current_language = config.get_value("settings", "language", "en")
		if current_language in GlobalVar.supported_languages:
			LanguageManager.set_language(current_language)
		else:
			var system_lang = OS.get_locale().split("_")[0]
			LanguageManager.set_language(system_lang)
		
		# load fps cap
		fps_cap = config.get_value("settings", "fps_cap", 0)
		Engine.max_fps = fps_cap
		
		# load music volume
		music_volume = config.get_value("settings", "music_volume", 100)
		var mdb = linear_to_db(music_volume)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), mdb)
		
		# load sound volume
		sound_volume = config.get_value("settings", "sound_volume", 100)
		var sdb = linear_to_db(sound_volume)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), sdb)
		
		# load auto save
		auto_save = config.get_value("settings", "auto_save", true)
		
		# load auto pause
		auto_pause = config.get_value("settings", "auto_pause", false)
		
		# load keybidings
		for action in config.get_section_keys("input"):
			var key_string = config.get_value("input", action)
			
			var event = InputEventKey.new()
			event.keycode = OS.find_keycode_from_string(key_string)
			
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)

func save_settings():
	var config = ConfigFile.new()
	
	config.set_value("settings", "language", current_language)
	config.set_value("settings", "fps_cap", fps_cap)
	config.set_value("settings", "music_volume", music_volume)
	config.set_value("settings", "sound_volume", sound_volume)
	config.set_value("settings", "auto_save", auto_save)
	config.set_value("settings", "auto_pause", auto_pause)
	
	for action in InputMap.get_actions():
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			config.set_value("input", action, events[0].as_text())
	
	config.save(setting_file)

func load_statistics():
	var config = ConfigFile.new()
	var err = config.load(statistic_file)
	
	if err == OK:
		total_play_time = config.get_value("statistics", "total_play_time", 0)
		

func save_statistics():
	var config = ConfigFile.new()
	
	config.set_value("statistics", "total_play_time", total_play_time+current_play_time)
	
	config.save(statistic_file)

func load_data(save_number: int):
	using_save = save_number
	
	var config = ConfigFile.new()
	var err = config.load(saves[using_save])
	
	if err == OK:
		save_play_time = config.get_value("save", "playtime", 0)
		current_map = config.get_value("save", "map", "")
		player_position_x = config.get_value("player", "x", 0)
		player_position_y = config.get_value("player", "y", 0)
	else:
		print("No save file found, starting fresh")

func save_data(save_number: int):
	var config = ConfigFile.new()
	config.set_value("save", "playtime", save_play_time+current_play_time)
	config.set_value("save", "map", current_map)
	config.set_value("player", "x", player_position_x)
	config.set_value("player", "y", player_position_y)
	
	config.save(saves[save_number])
