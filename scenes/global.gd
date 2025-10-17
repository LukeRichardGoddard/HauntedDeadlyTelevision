class_name  Global
extends Node

@export var level_scene = preload("res://scenes/level.tscn")
@export var player_scene = preload("res://scenes/player.tscn")
@export var skeleton_scene = preload("res://scenes/skeleton_warrior.tscn")
@onready var world = $World

func _ready() -> void:
	var current_level = level_scene.instantiate()
	world.add_child(current_level)
	var player = player_scene.instantiate()
	player.position = Vector3(3.0, 2.5, 0.0)
	world.add_child(player)
	var skeleton = skeleton_scene.instantiate()
	skeleton.position = Vector3(-1.0, 2.5, 0.0)
	world.add_child(skeleton)

var weapons: Dictionary = {
	'blade': 
		{
			'type': 'weapon',
			'damage': 1, 
			'scene': preload("res://scenes/weapons/blade.tscn"),
			'animation': '1H_Melee_Attack_Stab',
			'range': 1.2,
			'audio': preload("res://audio/blade.wav")
		},
	'barbarian_axe': 
		{
			'type': 'weapon',
			'damage': 3, 
			'scene': preload("res://scenes/weapons/barbarian_axe.tscn"),
			'animation': '1H_Melee_Attack_Chop',
			'range': 1.3,
			'audio': preload("res://audio/axe.wav")
		},
	'axe': 
		{
			'type': 'weapon',
			'damage': 3, 
			'scene': preload("res://scenes/weapons/axe.tscn"),
			'animation': '2H_Melee_Attack_Spin',
			'range': 1.3,
			'audio': preload("res://audio/axe.wav")
		},
	'staff': 
		{
			'type': 'weapon',
			'damage': 1, 
			'scene': preload("res://scenes/weapons/staff.tscn"),
			'animation': '2H_Melee_Attack_Slice',
			'range': 2.1,
			'audio': preload("res://audio/staff.wav")
		},
}
