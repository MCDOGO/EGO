extends Control

func _ready() -> void:
	pass


func _on_heavy_weapon_pressed() -> void:
	pass # Replace with function body.


func _on_primary_weapon_pressed() -> void:
	pass # Replace with function body.


func _on_melee_weapon_pressed() -> void:
	pass # Replace with function body.


func _on_armor_pressed() -> void:
	pass # Replace with function body.


func _on_throwable_weapon_pressed() -> void:
	pass # Replace with function body.


func _on_skills_pressed() -> void:
	pass # Replace with function body.


func _on_close_pressed() -> void:
	SignalBus.emit_signal("closed_lodout")
	get_tree().queue_delete(self)
