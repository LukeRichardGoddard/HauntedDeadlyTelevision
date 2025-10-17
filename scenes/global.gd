extends Node

@export var level_scene = preload("res://scenes/level.tscn")
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton_warrior.tscn")
@onready var world = $World

func _ready() -> void:
	var current_level = level_scene.instantiate()
	world.add_child(current_level)
	var player = player_scene.instantiate()
	player.position = Vector3(5.0, 2.5, 0.0)
	world.add_child(player)
	var skeleton = skeleton_scene.instantiate()
	skeleton.position = Vector3(-1.0, 2.5, 0.0)
	world.add_child(skeleton)
