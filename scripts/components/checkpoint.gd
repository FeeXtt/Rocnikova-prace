extends Node2D
class_name Checkpoint

@export var spawnpoint = false;
@export var sumOne: int = 1

func activate():
	GameManager.level = GameManager.level + sumOne
	print(str(GameManager.level) + "checkpoint")
	$AnimationPlayer.play("activated")
	GameManager.currentCheckpoint = self
	GameManager.activatedCheckpoint = true

func activateAnim():
	$AnimationPlayer.play("activated")
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet && !GameManager.activatedCheckpoint:
		GameManager.activatedCheckpoint = false
		activate()

func _ready() -> void:
	if GameManager.level == GameManager.doorLevel:
		activateAnim()
	
	
	
