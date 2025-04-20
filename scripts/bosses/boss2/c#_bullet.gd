extends Node2D

@export var speed := 150.0
var direction := Vector2.ZERO

func _ready() -> void:
	add_to_group("projectiles")

func _process(delta):
	position += direction * speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().die()
	elif area.get_parent() is Bounds:
		print("despawn")
		queue_free()
