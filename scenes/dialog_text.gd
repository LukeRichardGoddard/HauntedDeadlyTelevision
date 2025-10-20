extends Resource
class_name DialogText

@export
var player: String
@export
var text: String
@export
var next: int

func _init(_player:= "", _text:= "", _next:= 0):
	player = _player
	text = _text
	next = _next
