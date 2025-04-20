extends Node2D

@export var jump:float = -150;
@export var doublejump: float = -150
@export var gravity: float = 0.2
@export var maxjump: float = -200
@export var speed: float = 150


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		GameManager.constantDoubleJump = true
		GameManager.GRAVITY = gravity
		GameManager.BASE_JUMP_FORCE = jump
		GameManager.DOUBLE_JUMP_FORCE= doublejump
		GameManager.MAX_JUMP_FORCE = maxjump 
		GameManager.SPEED = speed 


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		GameManager.constantDoubleJump = false
		GameManager.BASE_JUMP_FORCE = -350
		GameManager.DOUBLE_JUMP_FORCE= -350
		GameManager.GRAVITY = 1
		GameManager.MAX_JUMP_FORCE = -500.0
		GameManager.SPEED = 300.0
		
		
		
		
