extends Node2D


func _process(delta):
	##get_tree().call_group("Enemy", "set_player_vector", $Players/Player.global_position)
	pass

func get_player(ID: int) -> CharacterBody2D:
	for player in get_tree().get_nodes_in_group("Player"):
		if(player.playerSimpleID == ID):
			return player
	return
