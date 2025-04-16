extends Node2D

@export var speed := 300.0
var direction := Vector2.ZERO

func _process(delta):
	position += direction * speed * delta
	if not get_viewport_rect().has_point(global_position):
		queue_free()
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().die()
