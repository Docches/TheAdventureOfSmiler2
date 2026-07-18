
extends Control

var note: Note
var music: AudioStreamPlayer
var hit := false


var spawn_time := 0.0

func initialize(data, player, appear_time):
	note = data
	music = player
	spawn_time = appear_time

func _process(_delta):
	var song_time = music.get_playback_position()
	var t = 1.0 - (note.time - song_time) / spawn_time
	position.y = lerp(GlobalVar.SPAWN_Y, GlobalVar.HIT_Y, t)
