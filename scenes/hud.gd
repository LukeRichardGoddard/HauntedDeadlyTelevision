extends Control

@onready var world = get_tree().get_first_node_in_group("Main")
@export var dialog: Array[DialogText] = []
var dialog_index = 0

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


var dialogs = {'level_a': 1, 'level_b': 1}

func get_line(level: String):
	return dialogs[level]

func _ready() -> void:
	dialog_index = get_line('level_b')

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if %DialogBox.visible == true and dialog_index == 0:
			%DialogBox.visible = false
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			return
		%DialogBox.visible = true
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
			
		if dialog[dialog[dialog_index].next].next == 0:
			%InstructionText.text = "PRESS SPACE TO EXIT"
		else:
			%InstructionText.text = "PRESS SPACE TO CONTINUE"
		dialog_index = dialog[dialog_index].next
