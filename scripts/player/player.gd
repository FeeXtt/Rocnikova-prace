extends CharacterBody2D

class_name Player

const BULLET = preload("res://scenes/player/bullet.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_HOLD_TIME = 0.5
const BASE_JUMP_FORCE = -400.0
const MAX_JUMP_FORCE = -600.0
const DOUBLE_JUMP_FORCE = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_holding_jump = false
var is_shooting = false
var can_double_jump = false
var jump_timer = 0.0
var playerposition
var last_direction = 1



@onready var shootingSound = $ShootingSound
@onready var jumpingSound = $JumpingSound

var animation_player: AnimationPlayer
var sprite: Sprite2D

func _ready():
	animation_player = $AnimationPlayer
	sprite = $Sprite2D
	GameManager.player = self
	GameManager.reload_player()

#MOVEMENT
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0 and not is_holding_jump:
		velocity.x = direction * SPEED
		last_direction = sign(direction)
		sprite.flip_h = direction < 0
		if not animation_player.is_playing() or animation_player.current_animation != "walk":
			animation_player.play("walk")
	elif not is_holding_jump:
		if Input.is_action_just_pressed("fire"):
			animation_player.play("fire")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not animation_player.is_playing() or animation_player.current_animation != "idle" && animation_player.current_animation != "fire":
			animation_player.play("idle")
	
	# Handle jump input
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			is_jumping = true
			jump_timer = 0.0
		elif can_double_jump:
			jumpingSound.play()
			velocity.y = DOUBLE_JUMP_FORCE
			can_double_jump = false
			
	
	if Input.is_action_pressed("ui_accept") and is_jumping:
		if jump_timer > 0.1:
			velocity.x = 0
		
		if not is_holding_jump:
			is_holding_jump = true
			if not animation_player.is_playing() or animation_player.current_animation != "beforejump":
				animation_player.play("beforejump")
		
		if jump_timer < MAX_JUMP_HOLD_TIME:
			jump_timer += delta
	
	if Input.is_action_just_released("ui_accept") and is_jumping:
		is_holding_jump = false
		jumpingSound.play()
		if not animation_player.is_playing() or animation_player.current_animation != "afterjump":
			animation_player.play("afterjump")
		
		var jump_strength = lerp(BASE_JUMP_FORCE, MAX_JUMP_FORCE, jump_timer / MAX_JUMP_HOLD_TIME)
		velocity.y = jump_strength
		is_jumping = false

	move_and_slide()

#SHOOTING
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		var offset_distance := 12
		var offset := Vector2(offset_distance * last_direction, 0) 
		bullet_instance.global_position = position + offset
		bullet_instance.set_direction(last_direction)
		shootingSound.play()


func die():
	print("die")
	GameManager.respawn_player()
