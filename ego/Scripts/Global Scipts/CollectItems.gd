extends Node

var Primary_Weapons: Dictionary
var Heavy_Weapons: Dictionary
var Melee_Weapons: Dictionary
var Throwable_Weapons: Dictionary
var Weapons_Attachments: Dictionary
var Armors: Dictionary

func _ready() -> void:
	setWeapons()


##		Setters


## Sets up all Dictionaries
func setWeapons():
	Primary_Weapons = set_primaries()
	Heavy_Weapons = set_heavies()
	Melee_Weapons = set_melees()
	Throwable_Weapons = set_throwables()
	Weapons_Attachments = set_attachments()
	Armors = set_armor()

## Sets dictionary of primary weapons
func set_primaries() -> Dictionary:
	return {
		##0 : preload(),
	}


## Sets dictionary of heavy weapons
func set_heavies() -> Dictionary:
	return {
		##0 : preload(),
	}


## Sets dictionary of melee weapons
func set_melees() -> Dictionary:
	return {
		##0 : preload(),
	}


## Sets dictionary of throwable weapons
func set_throwables() -> Dictionary:
	return {
		##0 : preload(),
	}


## Sets dictionary of weapon attachments
func set_attachments() -> Dictionary:
	return {
		##0 : preload(),
	}

## Sets dictionary of armor equipables
func set_armor() -> Dictionary:
	return {
		##0 : preload()
	}


##		Getters
