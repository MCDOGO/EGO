extends Control

#var level_select_screen = preload()
var player_lodout_screen = preload("res://Scenes/UI/Lodout Screen.tscn")
#var settings_screen = preload()


func _ready() -> void:
	SignalBus.closed_lodout.connect(lodout_closed)


func _on_start_button_pressed() -> void:
	#add_child(level_select_screen)
	get_tree().change_scene_to_file("res://Scenes/Levels/Level.tscn")


var lodout_open := false

func _on_lodout_pressed() -> void:
	if(!lodout_open):
		var temp = player_lodout_screen.instantiate()
		add_child(temp)
		lodout_open = true


func _on_exit_pressed() -> void:
	#save_game()
	get_tree().quit()


func lodout_closed() -> void:
	lodout_open = false
