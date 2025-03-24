extends CharacterBody2D

class_name Player

const BULLET = preload("res://scenes/bullet.tscn")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_HOLD_TIME = 0.5
const BASE_JUMP_FORCE = -700.0
const MAX_JUMP_FORCE = -1300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping = false
var is_holding_jump = false
var is_shooting = false
var jump_timer = 0.0

var animation_player: AnimationPlayer
var sprite: Sprite2D

func _ready():
	animation_player = $AnimationPlayer
	sprite = $Sprite2D
	GameManager.player = self

#MOVEMENT
func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0 and not is_holding_jump:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
		if not animation_player.is_playing() or animation_player.current_animation != "walk":
			animation_player.play("walk")
	elif not is_holding_jump && not is_shooting:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not animation_player.is_playing() or animation_player.current_animation != "idle":
			animation_player.play("idle")
	

	# Handle jump input
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		is_jumping = true
		jump_timer = 0.0
	
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
		if not animation_player.is_playing() or animation_player.current_animation != "afterjump":
			animation_player.play("afterjump")

		var jump_strength = lerp(BASE_JUMP_FORCE, MAX_JUMP_FORCE, jump_timer / MAX_JUMP_HOLD_TIME)
		velocity.y = jump_strength
		is_jumping = false

	velocity = velocity
	move_and_slide()


#SHOOTING
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		is_shooting = true
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = position
		is_shooting = false

func die():
	GameManager.respawn_player()
