extends Node2D

@export var target_position: Vector2
@export var move_speed := 200.0
@export var waitOnPlayer = false
var start_position: Vector2
var going_to_target := true
var player_on_platform
@onready var player = $"../Player"

func _ready():
	start_position = global_position

func _physics_process(delta: float) -> void:
	if waitOnPlayer:
		if player_on_platform: 
			var target = target_position if going_to_target else start_position
			var old_pos = global_position
			global_position = global_position.move_toward(target, move_speed * delta)
			var velocity = position - old_pos
			if player_on_platform:
				player.global_position += velocity
	else:
		var target = target_position if going_to_target else start_position
		var old_pos = global_position
		global_position = global_position.move_toward(target, move_speed * delta)
		var velocity = position - old_pos

		if player_on_platform:
			player.global_position += velocity
		
		if global_position.distance_to(target) < 1.0:
			going_to_target = !going_to_target

func _on_area_2d_area_entered(area) -> void:
	if area.get_parent() is Player:
		player_on_platform = true

func _on_area_2d_area_exited(area) -> void:
	if area.get_parent() is Player:
		player_on_platform = false
