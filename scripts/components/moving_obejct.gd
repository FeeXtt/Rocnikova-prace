extends Node2D

@onready var sprite = $Sprite2D
@export var target_position: Vector2
@export var move_speed := 200.0
@export var spirePNG = preload("res://assets/radekhlava.png")
var start_position: Vector2
var going_to_target := true

func _ready():
	sprite.texture = spirePNG
	start_position = global_position

func _physics_process(delta: float) -> void:
	var target = target_position if going_to_target else start_position
	global_position = global_position.move_toward(target, move_speed * delta)

	if global_position.distance_to(target) < 1.0:
		going_to_target = !going_to_target


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		area.get_parent().die()
