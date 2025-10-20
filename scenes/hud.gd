extends Control

@onready var world = get_tree().get_first_node_in_group("Main")
@export var dialog: Array[DialogText] = []
var dialog_index

func game_over():
	%"Game Over".show()

func toggle_menu():
	if $Menu.visible:
		$Menu.hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		$Menu.show()
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func update_health(health: int):
	$HealthBar/VBoxContainer/HealthProgressBar.value = health


func _on_sfx_slider_value_changed(value: float) -> void:
	world.set_sfx_volume(value)


func _on_music_slider_value_changed(value: float) -> void:
	world.set_music_volume(value)


var dialogs = {'LevelA': 2, 'LevelB': 7}
var end_level_dialogs = {'LevelA': 9, 'LevelB': 11}

func start_end_dialog():
	dialog_index = end_level_dialogs[world.get_level_name()]
	process_dialog()

func get_line(level: String):
	return dialogs[level]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("play_again"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("interact"):
		load_dialog()

func load_dialog():
	if dialog_index == null:
		dialog_index = dialogs[world.get_level_name()]
		#print(world.get_child(1).get_child(0).name, world.get_child(1).name)
	elif dialog_index == 1:
		world.load_level()
		dialog_index = dialogs[world.get_level_name()]
	else:
		process_dialog()

func showing_dialog():
	return %DialogBox.visible

func process_dialog():
	if %DialogBox.visible == true and dialog_index == 0:
		%DialogBox.hide()
		get_tree().paused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif dialog_index == 0:
		return
	else:
		print("Showing dialog box, index ", dialog_index)
		%DialogBox.show()
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		%DialogText.text = dialog[dialog_index].text
		for child in %ProfilePic.get_children():
			child.hide()
		match dialog[dialog_index].player:
			"Barbarian":
				%BarbarianPic.show()
			"Knight":
				%KnightPic.show()
			"Mage":
				%MagePic.show()
			"Rogue":
				%RoguePic.show()
			
		if dialog[dialog_index].next == 0:
			%InstructionText.text = "PRESS SPACE TO EXIT"
		else:
			%InstructionText.text = "PRESS SPACE TO CONTINUE"
		dialog_index = dialog[dialog_index].next
