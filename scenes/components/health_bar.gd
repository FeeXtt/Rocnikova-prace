extends Control
@export var max_value = 200
func _ready() -> void:
	$HealthBar.max_value = max_value


func update_healthbar(current, max):
	$HealthBar.max_value = max
	$HealthBar.value = current
	
