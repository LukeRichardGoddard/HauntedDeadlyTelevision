class_name  Main
extends Node

@export var level_scene = preload("res://scenes/level.tscn")
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton.tscn")
@export var tv_skeleton_scene = preload("res://scenes/tv_skeleton.tscn")
@onready var world = $World
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var current_level = level_scene.instantiate()
	world.add_child(current_level)
	var player = player_scene.instantiate()
	player.position = Vector3(3.0, 2.5, 0.0)
	world.add_child(player)
	var num_of_skeletons = rng.randi_range(1,3)
	for i in num_of_skeletons:
		var skeleton = skeleton_scene.instantiate()
		skeleton.position = Vector3(rng.randf_range(-25.0, 25.0), 2.5, rng.randf_range(-18.0, 18.0))
		world.add_child(skeleton)
	var tv_skeleton = tv_skeleton_scene.instantiate()
	tv_skeleton.position = Vector3(rng.randf_range(-25.0, 25.0), 2.5, rng.randf_range(-18.0, 18.0))
	world.add_child(tv_skeleton)
	
