extends Node2D

@export var health: int = 100; 
var current_phase = true
var current_point_index := 0
const BULLET = preload("res://scenes/bosses/boss1/boss_1_bullet.tscn")
@export var player: Node2D



func _process(delta: float) -> void:
		var shoot_timer := 0.0
		var shoot_delay := 0.5  
		while current_phase == true:
				shoot_timer -= delta
				if shoot_timer <= 0:
					shoot_projectile_at_player()
					shoot_timer = shoot_delay

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		health -= 1


func shoot_projectile_at_player():
	var proj = BULLET.instantiate()
	get_parent().add_child(proj)
	proj.global_position = global_position
	proj.direction = (GameManager.playerposaition.global_position - global_position).normalized()
