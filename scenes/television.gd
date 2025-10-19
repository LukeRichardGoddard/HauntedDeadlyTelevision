extends Character

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var tree = $AnimationTree
@export var notice_radius: float = 15
@export var speed: float = 7
@export var attack_radius: float = 2
@export var taunt_radius: float = 5
var rng = RandomNumberGenerator.new()
var started_spawning_skeletons = false

func _ready() -> void:
	skin = $Skins.get_child(0)
	tree.anim_player = "../Skins/Skeleton_Minion/AnimationPlayer"
	var random_weapon = Globals.weapons[Globals.weapons.keys().pick_random()]
	attack_radius = 3
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
			if not started_spawning_skeletons:
				_on_spawn_timer_timeout()
				started_spawning_skeletons = true
			var target_dir = (player.position - position).normalized()
			var target_vec2 = Vector2(target_dir.x, target_dir.z)
			var target_angle = target_vec2.angle() + PI/2
			if position.distance_to(player.position) > taunt_radius:
				rotation.y = rotate_toward(rotation.y, -target_angle, delta * 6)
				velocity = Vector3(-target_vec2.x, 0, -target_vec2.y) * speed
				set_move_state("Running_C")
			else:
				if position.distance_to(player.position) > attack_radius:
					rotation.y = rotate_toward(rotation.y, target_angle, 600)
					if rotation.y == target_angle:
						velocity = Vector3.ZERO
					set_move_state("Taunt")
				else:
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
	$Timers/SpawnTimer.stop()
	var tween = create_tween()
	tween.tween_method(_death_change, 0.0, 1.0, 0.25)
	world.destroy_skeletons()

func _death_change(value):
	$AnimationTree.set("parameters/DeathBlend/blend_amount", value)
	$"Skins/Skeleton_Minion/Rig/Skeleton3D/Head/old tv/Cube_002".hide()


func _on_spawn_timer_timeout() -> void:
	$Timers/SpawnTimer.wait_time = rng.randf_range(5.0, 10.0)
	$Timers/SpawnTimer.start()
	var num_of_skeletons = rng.randi_range(1,3)
	print("Spawning ", num_of_skeletons, " skeletons")
	for i in num_of_skeletons:
		world.spawn_skeleton()

func update_health(health: int):
	pass
