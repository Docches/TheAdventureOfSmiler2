extends Node

func _ready():
	# back button signal connect
	var back_button = find_child("Back")
	back_button.pressed.connect(GlobalNav._on_pressed.bind("res://GUI/Main/Main.tscn"))
	
	# language option button selection handling
	var language_button = find_child("LanguageButton")
	language_button.item_selected.connect(_on_language_selected)
	
	var language = GlobalVar.current_language
	var language_index = GlobalVar.supported_languages.find(language)
	
	if language_index != -1:
		language_button.select(language_index)
	
	# fps cap option button selection handling
	var frame_lock_button = find_child("FrameLockButton")
	frame_lock_button.item_selected.connect(_on_frame_rate_selected)
	
	var frame_rate = GlobalVar.fps_cap;
	var frame_rate_index = GlobalVar.supported_fps_caps.find(frame_rate)
	
	if frame_rate_index != -1:
		frame_lock_button.select(frame_rate_index)
	
	# music volume slider handling
	var music_volume_slider = find_child("MusicVolumeButton")
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	
	music_volume_slider.set_value(GlobalVar.music_volume)
	
	# sound volume slider handling
	var sound_volume_slider = find_child("SoundVolumeButton")
	sound_volume_slider.value_changed.connect(_on_sound_volume_changed)
	
	sound_volume_slider.set_value(GlobalVar.sound_volume)
	
	# auto save checkbox handling
	var auto_save_checkbox = find_child("AutosaveButton")
	auto_save_checkbox.toggled.connect(_on_autosave_checkbox_toggled)
	
	auto_save_checkbox.button_pressed = GlobalVar.auto_save
	
	# auto pause checkbox handling
	var auto_pause_checkbox = find_child("AutopauseButton")
	auto_pause_checkbox.toggled.connect(_on_autopause_checkbox_toggled)
	
	auto_pause_checkbox.button_pressed = GlobalVar.auto_pause
	
	# controls edit button handling
	var controls_button = find_child("ControlsButton")
	controls_button.pressed.connect(GlobalNav._on_pressed.bind("res://GUI/Settings/Controls/Controls.tscn"))

func _on_language_selected(index):
	LanguageManager.set_language(GlobalVar.supported_languages[index])

func _on_frame_rate_selected(index):
	GlobalVar.fps_cap = GlobalVar.supported_fps_caps[index]
	Engine.max_fps = GlobalVar.fps_cap

func _on_music_volume_changed(value):
	GlobalVar.music_volume = value
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)

func _on_sound_volume_changed(value):
	GlobalVar.sound_volume = value
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), db)

func _on_autosave_checkbox_toggled(pressed):
	GlobalVar.auto_save = pressed

func _on_autopause_checkbox_toggled(pressed):
	GlobalVar.auto_pause = pressed
