extends Control

func update_health(health: int):
	$PanelContainer/VBoxContainer/HealthProgressBar.value = health
