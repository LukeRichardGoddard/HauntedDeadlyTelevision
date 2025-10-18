extends Character

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var tree = $AnimationTree
@export var notice_radius: float = 15
@export var speed: float = 2
@export var attack_radius: float = 2
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	skin = $Skins.get_child(0)
	tree.anim_player = "../Skins/Skeleton_Minion/AnimationPlayer"
	var random_weapon = Globals.weapons[Globals.weapons.keys().pick_random()]
	#equip(random_weapon, skin.get_node('Rig/Skeleton3D/RightHand'))
	attack_radius = 2
	health = 5

func _physics_process(delta: float) -> void:
	if health > 0:
		flee_from_player(delta)
		if not is_on_floor():
			apply_gravity(fall_gravity, delta)
		else:
			velocity.y = 0
		move_and_slide()
		attack_logic()

func flee_from_player(delta):
	if player:
		if position.distance_to(player.position) < notice_radius:
			var target_dir = (player.position - position).normalized()
			var target_vec2 = Vector2(target_dir.x, target_dir.z)
			var target_angle = target_vec2.angle() + PI/2
			if position.distance_to(player.position) > attack_radius:
				rotation.y = rotate_toward(rotation.y, -target_angle, delta * 6)
				velocity = Vector3(-target_vec2.x, 0, -target_vec2.y) * speed
				set_move_state("Running_C")
			else:
				if rotation.y == target_angle:
					velocity = Vector3.ZERO
					set_move_state("Taunt")
				else:
					rotation.y = rotate_toward(rotation.y, target_angle, 600)
					velocity = Vector3.ZERO
					set_move_state("Idle")
		else:
			velocity = Vector3.ZERO
			set_move_state("Idle")

func _on_attack_timer_timeout() -> void:
	$Timers/AttackTimer.wait_time = rng.randf_range(2.0, 3.5)
	if player:
		if position.distance_to(player.position) <= attack_radius:
			pass
			#$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
			#attacking = true

func death_logic():
	$CollisionShape3D.disabled = true
	$Timers/AttackTimer.stop()
	var tween = create_tween()
	tween.tween_method(_death_change, 0.0, 1.0, 0.25)

func _death_change(value):
	$AnimationTree.set("parameters/DeathBlend/blend_amount", value)
	$"Skins/Skeleton_Minion/Rig/Skeleton3D/Head/old tv/Cube_002".hide()
