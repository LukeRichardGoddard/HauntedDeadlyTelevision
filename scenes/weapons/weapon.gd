extends Node3D

const equipment_type = "Weapon"
var animation: String
var damage: int
var parent
var radius: float

func setup(weapon_animation, weapon_damage, weapon_radius, weapon_parent):
	animation = weapon_animation
	damage = weapon_damage
	radius = weapon_radius
	parent = weapon_parent

func get_collider():
	return $RayCast3D.get_collider()
