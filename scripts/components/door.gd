extends Node2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		GameManager.activatedCheckpoint = false
		GameManager.doorLevel = GameManager.doorLevel  + 1
		get_tree().change_scene_to_file("res://scenes/levels/level_"+str(GameManager.doorLevel)+".tscn")
		print(GameManager.level)
		print(GameManager.doorLevel)
		
