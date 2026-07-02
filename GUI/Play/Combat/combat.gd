extends Control

@onready var music_player: AudioStreamPlayer = $Music
@onready var lanes = $LanesContainer
@onready var notes = $Notes
@onready var hitline = $Hitline

const BEAT_NOTE = preload("res://GUI/Play/Combat/Notes/Beatnote/Beatnote.tscn")
const HOLD_NOTE = preload("res://GUI/Play/Combat/Notes/Holdnote/Holdnote.tscn")

var beatmap: Beatmap = null

var song_time := 0.0
var next_note := 0
var playing := false
var lane_notes = [[],[],[],[],[]]
var score := 0
var combo := 0


func _ready() -> void:
	$Button.pressed.connect(load_beatmap.bind("res://Beatmaps/try.tres"))
	GlobalVar.HIT_Y = hitline.position.y


func _physics_process(_delta: float) -> void:
	if not playing:
		return
	song_time = music_player.get_playback_position()
	song_time += AudioServer.get_time_since_last_mix()
	while next_note < beatmap.notes.size():
		var note := beatmap.notes[next_note]
		if note.time <= song_time + GlobalVar.note_spawn_time:
			spawn_note(note)
			next_note += 1
		else:
			break
	check_misses()


func load_beatmap(path: String) -> void:
	beatmap = load(path) as Beatmap
	next_note = 0
	song_time = 0.0
	music_player.stop()
	music_player.stream = beatmap.SFX
	music_player.play()
	lanes.visible = true
	notes.visible = true
	hitline.visible = true
	playing = true


func spawn_note(note) -> void:
	var note_scene = (BEAT_NOTE if note.hold_time == 0 else HOLD_NOTE).instantiate()
	notes.add_child(note_scene)
	note_scene.initialize(note, music_player, GlobalVar.note_spawn_time)
	note_scene.position.x = lanes.get_child(note.lane).position.x
	lane_notes[note.lane].append(note_scene)


func get_judgement(delta: float) -> String:
	if delta <= GlobalVar.PERFECT_WINDOW:
		combo+=1
		return "Perfect"
	elif delta <= GlobalVar.GOOD_WINDOW:
		combo+=1
		return "Good"
	elif delta <= GlobalVar.BAD_WINDOW:
		combo+=1
		return "Bad"
	else:
		return "Miss"

func _input(event):
	if event.is_action_pressed("lane_0"):
		try_hit_lane(0)
	if event.is_action_pressed("lane_1"):
		try_hit_lane(1)
	if event.is_action_pressed("lane_2"):
		try_hit_lane(2)
	if event.is_action_pressed("lane_3"):
		try_hit_lane(3)
	if event.is_action_pressed("lane_4"):
		try_hit_lane(4)


func try_hit_lane(lane: int) -> void:
	song_time = music_player.get_playback_position()
	song_time += AudioServer.get_time_since_last_mix()
	var lane_queue = lane_notes[lane]
	if lane_queue.is_empty():
		return
	var note = lane_queue.front()
	if note.hit:
		return
	var delta = abs(song_time - note.note.time)
	var judgment = get_judgement(delta)
	if judgment == "Miss":
		combo = 0
		print("Ghost Miss")
		return
		
	apply_hit(note, judgment)

func apply_hit(note_node, judgment: String) -> void:
	note_node.hit = true
	match judgment:
		"Perfect":
			score += 1000
		"Good":
			score += 700
		"Bad":
			score += 300
	lane_notes[note_node.note.lane].pop_front()
	note_node.queue_free()
	print(judgment)


func check_misses():
	for queue in lane_notes:
		if queue.is_empty():
			continue
		var note = queue.front()
		if song_time - note.note.time > GlobalVar.BAD_WINDOW:
			note.hit = true
			queue.pop_front()
			note.queue_free()
			combo = 0
			print("Miss")
