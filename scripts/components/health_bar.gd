extends Node2D

func update_health(current, max):
	$TextureProgressBar.value = current
	$TextureProgressBar.max_value = max
