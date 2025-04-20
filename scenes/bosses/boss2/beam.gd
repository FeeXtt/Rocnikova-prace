extends Node2D

@export var player_path: NodePath
@onready var player = $"../Player"

@onready var raycast =  $RayCast2D
@onready var full_beam =  $Line2D2
@onready var hit_beam =  $Line2D  
var lenght= 1

var time_on_target := 0.0
const KILL_TIME := 5.0

func _physics_process(delta):
	if not player:
		return
	# Paprsek vždy míří na hráče
	var direction = (player.global_position - global_position).normalized()
	var max_length = 100
	


	

	hit_beam.clear_points()
	if raycast.is_colliding():
		var collision_point = to_local(raycast.get_collision_point())
		hit_beam.add_point(Vector2.ZERO)
		hit_beam.add_point(collision_point)
		direction = raycast.get_collision_point() - global_position
		lenght = global_position.distance_to(raycast.get_collision_point())
		print(lenght)
		print("h")
	else:
		hit_beam.add_point(Vector2.ZERO)
		hit_beam.add_point(Vector2.ZERO)
		
	var beam_vector = direction * lenght
	raycast.target_position = beam_vector
	raycast.force_raycast_update()
	full_beam.clear_points()
	full_beam.add_point(Vector2.ZERO)
	full_beam.add_point(beam_vector)


	if raycast.is_colliding() and raycast.get_collider() == player:
		time_on_target += delta
		if time_on_target >= KILL_TIME:

			pass
