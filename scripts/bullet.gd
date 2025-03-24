extends Node2D

const speed: int = 500

func _process(delta: float) -> void:
	position += transform.x * speed * delta
