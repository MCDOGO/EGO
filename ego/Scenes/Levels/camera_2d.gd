extends Camera2D

@onready var player : Player = $"../Players/Player"

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	global_position = player.global_position
