class_name  Main
extends Node

@export var level_scene = preload("res://scenes/levels/level_b.tscn")
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton.tscn")
@export var tv_scene = preload("res://scenes/television.tscn")
@onready var world = $World
var rng = RandomNumberGenerator.new()
var spawn_limit_top_left: Vector2
var spawn_limit_bottom_right: Vector2
var player_start: Vector3

var play_sfx: bool = true
var play_music: bool = true

func _ready() -> void:
	var current_level = level_scene.instantiate()
	world.add_child(current_level)
	spawn_limit_top_left = Vector2(current_level.topleft.position.x, current_level.topleft.position.z)
	spawn_limit_bottom_right = Vector2(current_level.bottomright.position.x, current_level.bottomright.position.z)
	player_start = current_level.player_start.position
	
	var player = player_scene.instantiate()
	player.position = player_start
	world.add_child(player)
	var tv_skeleton = tv_scene.instantiate()
	tv_skeleton.position = Vector3(rng.randf_range(spawn_limit_top_left.x, spawn_limit_bottom_right.x), 1.0, rng.randf_range(spawn_limit_top_left.y, spawn_limit_bottom_right.y))
	world.add_child(tv_skeleton)

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
