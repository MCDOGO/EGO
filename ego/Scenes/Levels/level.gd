extends Node2D


func _process(delta):
	get_tree().call_group("Enemy", "set_player_vector", $Players/Player.global_position)
