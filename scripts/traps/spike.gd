extends Node2D

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().die()
