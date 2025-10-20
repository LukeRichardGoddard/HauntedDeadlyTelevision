extends Control

@onready var world = get_tree().get_first_node_in_group("Main")

func _ready() -> void:
	pass

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
