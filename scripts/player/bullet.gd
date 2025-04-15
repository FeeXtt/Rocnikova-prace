extends Node2D
class_name Bullet
const speed: int = 500
var direction: int = 1

@onready var sprite = $Sprite2D 
@onready var area = $BulletHitBox
func _process(delta: float) -> void:
	position.x += direction * speed * delta


func set_direction(new_direction: int):
	direction = new_direction
	sprite.flip_h = direction < 0

func _on_bullet_hit_box_area_entered(_area: Area2D) -> void:
	queue_free()
