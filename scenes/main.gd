class_name  Main
extends Node

@export var level_scenes = [preload("res://scenes/levels/level_a.tscn"),preload("res://scenes/levels/level_b.tscn")]
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton.tscn")
@export var tv_scene = preload("res://scenes/television.tscn")
@onready var world = $World
@onready var hud = $HUD
var player
var tv_skeleton
var rng = RandomNumberGenerator.new()
var spawn_limit_top_left: Vector2
var spawn_limit_bottom_right: Vector2
var player_start: Vector3
var current_level

var play_sfx: bool = true
var play_music: bool = true
var sfx_volume: float = 1.0
var music_volume: float = 1.0

func _ready() -> void:
	get_tree().paused = true
	load_level()

func load_level():
	if not current_level == null:
		for child in world.get_children():
			if child is Level or child is Skeleton:
				child.queue_free()
	current_level = level_scenes.pick_random().instantiate()
	world.add_child(current_level)
	spawn_limit_top_left = Vector2(current_level.topleft.position.x, current_level.topleft.position.z)
	spawn_limit_bottom_right = Vector2(current_level.bottomright.position.x, current_level.bottomright.position.z)
	player_start = current_level.player_start.position
	
	if player == null:
		player = player_scene.instantiate()
		player.position = player_start
		world.add_child(player)
	else:
		player.position = player_start
	
	if tv_skeleton == null:
		tv_skeleton = tv_scene.instantiate()
		tv_skeleton.position = Vector3(rng.randf_range(spawn_limit_top_left.x, spawn_limit_bottom_right.x), 1.0, rng.randf_range(spawn_limit_top_left.y, spawn_limit_bottom_right.y))
		world.add_child(tv_skeleton)
	else:
		tv_skeleton.position = Vector3(rng.randf_range(spawn_limit_top_left.x, spawn_limit_bottom_right.x), 1.0, rng.randf_range(spawn_limit_top_left.y, spawn_limit_bottom_right.y))
		tv_skeleton.reset()
		world.add_child(tv_skeleton)
	if play_music:
		$Music/Mysterium.play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		hud.toggle_menu()

func spawn_skeleton():
	var skeleton = skeleton_scene.instantiate()
	skeleton.position = Vector3(rng.randf_range(spawn_limit_top_left.x, spawn_limit_bottom_right.x), 1.0, rng.randf_range(spawn_limit_top_left.y, spawn_limit_bottom_right.y))
	world.add_child(skeleton)

func destroy_skeletons():
	for child in world.get_children():
		if child is Skeleton:
			child.destroy()

func play_axe():
	if play_sfx:
		$Sounds/SFXAxe.play()

func play_blade():
	if play_sfx:
		$Sounds/SFXBlade.play()

func play_staff():
	if play_sfx:
		$Sounds/SFXStaff.play()

func update_health(health: int):
	hud.update_health(health)

func set_sfx_volume(volume: float):
	sfx_volume = volume
	for child in $Sounds.get_children():
		child.volume_linear = volume

func set_music_volume(volume: float):
	music_volume = volume
	$Music/Mysterium.volume_linear = volume

func get_level_name():
	return current_level.level

func start_end_dialog():
	hud.start_end_dialog()
