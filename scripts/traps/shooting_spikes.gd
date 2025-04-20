
@tool
class_name ShootingSpike
extends Node2D


@export var speed: = -300
@export var sideways = true
@export var detection_length: float = 100.0:
	set(value):
		detection_length = value
		_update_shape()
var current_speed: = 0.0
@export_range(-180, 180, 1) var sprite_rotation_degrees: float = 0.0:
	set(value):
		sprite_rotation_degrees = value
		_update_shape()

func _ready() -> void:
		_update_shape()


func _physics_process(delta):
	if sideways:
		position.x += current_speed * delta
	else:
		position.y += current_speed * delta

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().die()

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

func _update_shape():
	if not is_inside_tree():
		return
	var collision_shape = $PlayerDetection/CollisionShape2D
	var shape = $PlayerDetection/CollisionShape2D.shape
	if shape is RectangleShape2D:
		collision_shape.shape = shape.duplicate()
		var new_shape = collision_shape.shape as RectangleShape2D
		new_shape.size.y = detection_length
		collision_shape.position.y = -detection_length / 2.0
	if $Rotatable:
		$Rotatable.rotation_degrees = sprite_rotation_degrees
		
		
