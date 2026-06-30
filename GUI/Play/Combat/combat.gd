extends Control

@onready var music_player: AudioStreamPlayer = $Music
@onready var lanes = $LanesContainer

var beatmap: Beatmap = null

var song_time := 0.0
var next_note := 0
var playing := false


func _physics_process(_delta: float) -> void:
	if not playing:
		return
	song_time = music_player.get_playback_position()
	while next_note < beatmap.notes.size():
		var note := beatmap.notes[next_note]
		if note.time <= song_time + GlobalVar.beat_note_spawn_time:
			spawn_note(note)
			next_note += 1
		else:
			break


func load_beatmap(path: String) -> void:
	beatmap = load(path) as Beatmap
	next_note = 0
	song_time = 0.0
	music_player.stop()
	music_player.stream = beatmap.music
	music_player.play()
	playing = true


func spawn_note(note: Beatnote) -> void:
	var note_scene := preload("res://Entities/Beatmap/Beatnote/Beatnote.tscn").instantiate()
	var lane = lanes.get_child(note.lane)
	lane.add_child(note_scene)
	note_scene.initialize(note, song_time, GlobalVar.beat_note_spawn_time)
