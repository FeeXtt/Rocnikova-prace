extends Node2D

@export var speed: = -300
var current_speed: = 0.0 

func _physics_process(delta):
	position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().die()
	else:
		queue_free()
		
func _on_body_entered(area):
	if area.get_parent() is Area2D: 
		queue_free()

func _on_player_detection_area_entered(area):
	if area.get_parent() is Player:
		fall()
		
func fall():
	current_speed = speed
	await get_tree().create_timer(5).timeout
	queue_free()
		
