class_name Bullet
extends Node2D

const speed: int = 500
var direction: int = 1

@onready var sprite = $Sprite2D 
@onready var area = $BulletHitBox
func _process(delta: float) -> void:
	position.x += direction * speed * delta
	get_tree().create_timer(3.0).timeout.connect(queue_free)


func set_direction(new_direction: int):
	direction = new_direction
	sprite.flip_h = direction < 0




func _on_bullet_hit_box_area_entered(area: Area2D) -> void:
	if area.get_parent() is Boss:
		queue_free()
	elif area.get_parent() is Bounds:
		queue_free()
