class_name  Main
extends Node

@export var level_scene = preload("res://scenes/level.tscn")
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton.tscn")
@export var tv_scene = preload("res://scenes/television.tscn")
@onready var world = $World
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var current_level = level_scene.instantiate()
	world.add_child(current_level)
	var player = player_scene.instantiate()
	player.position = Vector3(3.0, 2.5, 0.0)
	world.add_child(player)
	var tv_skeleton = tv_scene.instantiate()
	tv_skeleton.position = Vector3(rng.randf_range(-15.0, 15.0), 2.5, rng.randf_range(-8.0, 8.0))
	world.add_child(tv_skeleton)

func spawn_skeleton():
	var skeleton = skeleton_scene.instantiate()
	skeleton.position = Vector3(rng.randf_range(-15.0, 15.0), 2.5, rng.randf_range(-8.0, 8.0))
	world.add_child(skeleton)
