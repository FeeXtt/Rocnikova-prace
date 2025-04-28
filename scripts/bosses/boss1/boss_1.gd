extends Node2D
class_name Boss

@export var max_health := 150;
var current_health := max_health

var current_phase = true
var current_point_index := 0
var bossalive = true
const BULLET = preload("res://scenes/bosses/boss1/boss_1_bullet.tscn")
const WORD = preload("res://scenes/bosses/boss1/boss_1_words.tscn")
const HEAD = preload("res://scenes/bosses/boss1/boss_1_heads.tscn")
@onready var health_bar = $"../HealthBar"
@onready var player = $"../Player"
@onready var animplayer = $AnimationPlayer
@onready var shotgun = $shotgun
@onready var megaphone = $megaphone
@onready var bossbound = $"../BossBound"
@onready var ground = $"../TileMap/Ground"
@onready var platform1 = $"../TileMap/plaformsLayer1"
@onready var platform2 = $"../TileMap/plaformsLayer2"
@onready var warningmark_ground = $"../Exclamationmark_ground"
@onready var warningmark_platform1 = $"../Exclamationmark_platform1"
@onready var warningmark_platform2= $"../Exclamationmark_platform2"



func _ready() -> void:
	health_bar.update_healthbar(current_health, max_health)
	bossloop()

func bossloop():
	while bossalive:
		await phase1()
		await phase2()
		await phase3()
		await phase4()
		await phase5()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		print("au")
		current_health -= 1
		health_bar.update_healthbar(current_health, max_health)
		if current_health <= 0:
			queue_free()
	if area.get_parent() is Player:
		area.get_parent().die()


#PHASE 1
func phase1():
	platform2.enabled = false
	platform1.enabled = true
	ground.enabled = true
	shotgun.visible = true
	await move_to_position_smoothly(Vector2(250, 30), 2.0)
	await shoot_projectile_at_player(10)
	shotgun.visible = false

func move_to_position_smoothly(target: Vector2, duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", target, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func shoot_projectile_at_player(numofbullets):
	for n in numofbullets:
		var bullet = BULLET.instantiate()
		get_tree().root.add_child(bullet)
		animplayer.play("shoot")
		AudioManagerScene.play_shotgun_fire()
		bullet.global_position = position + Vector2(-80, 20)
		bullet.direction = (player.global_position- bullet.global_position).normalized()
		await get_tree().create_timer(0.4).timeout
		

#PHASE 2
func phase2():
	move_to_position_smoothly(Vector2(250, -42), 2.0)
	await  warning_mark_enabled(warningmark_ground, 4)
	megaphone.visible = true
	ground.enabled = false
	var times = [0.3, 0.2, 0.4, 0.1, 0.5, 0.1, 0.1, 0.3, 0.5, 0.6, 0.7, 0.3, 0.2, 0.4, 0.1, 0.5, 0.4, 0.3, 0.5, 0.5, 0.6, 0.7]
	var positions1 = [
		Vector2(-500, -90),
		Vector2(-500, 50),
		Vector2(-500, -150),
		Vector2(-500, 130),
		Vector2(-500, 0),
		Vector2(-500, -230),
		Vector2(-500, 90),
		Vector2(-500, -70),
		Vector2(-500, 10),
		Vector2(-500, -190),
		Vector2(-500, -30),
		Vector2(-500, 8),
		Vector2(-500, -170),
		Vector2(-500, 30),
		Vector2(-500, -250),
		Vector2(-500, -110),
		Vector2(-500, 70),
		Vector2(-500, -210),
		Vector2(-500, 130),
		Vector2(-500, -50),
		]
	await shoot_words_in_patern(times, positions1)
	megaphone.visible = false
	
func shoot_words_in_patern(times, positions):
	for n in 19:
		if !bossalive: 
			break
		print(n)
		var word = WORD.instantiate()
		get_tree().root.add_child(word)
		word.global_position = global_position + Vector2(-60, 20)
		word.direction = (positions[n]).normalized()
		await get_tree().create_timer(times[n]).timeout
		
func warning_mark_enabled(mark, timer):
	mark.visible = true
	animplayer = mark.get_node("WarningAnimPlayer")
	animplayer.play("warning")
	await get_tree().create_timer(timer).timeout
	mark.visible = false

## PHASE3
func phase3():
	platform2.enabled = true
	await move_to_position_smoothly(Vector2(250, -100), 2.0)
	shotgun.visible = true
	await shoot_projectile_at_player(13)
	shotgun.visible = false
	
## PHASE4
func phase4():
	move_to_position_smoothly(Vector2(250, -100), 2.0)
	await  warning_mark_enabled(warningmark_platform1, 4)
	platform1.enabled = false
	megaphone.visible = true
	var times = [0.3, 0.2, 0.4, 0.1, 0.5, 0.1, 0.1, 0.3, 0.5, 0.6, 0.7, 0.3, 0.2, 0.4, 0.1, 0.5, 0.4, 0.3, 0.5, 0.5, 0.6, 0.7]
	var positions2 = [
		Vector2(-400, -80),
		Vector2(-400, -295),
		Vector2(-400, 0),
		Vector2(-400, -110),
		Vector2(-400, 65),
		Vector2(-400, -120),
		Vector2(-400, 25),
		Vector2(-400, -250),
		Vector2(-400, -30),
		Vector2(-400, -150),
		Vector2(-400, -120),
		Vector2(-400, -70),
		Vector2(-400, -215),
		Vector2(-400, 45),
		Vector2(-400, -120),
		Vector2(-400, -275),
		Vector2(-400, -115),
		Vector2(-400, -180),
		Vector2(-400, -108),
		Vector2(-400, -55),]
	await shoot_words_in_patern(times, positions2)
	megaphone.visible = false
	
#PHASE 5
func phase5():
	if !bossalive: 
		return
	move_to_position_smoothly(Vector2(250, -42), 2.0)
	platform1.enabled = true
	await  warning_mark_enabled(warningmark_platform2, 3)
	platform2.enabled = false
	await get_tree().create_timer(1).timeout
	var numberOfHeads = 80
	var positionOfHead= [
		Vector2(-124, -240),
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-85, -240),
		
		Vector2(-124, -240),
		Vector2(-201, -240),
		Vector2(-85, -240),
		Vector2(-47, -240),
		
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		Vector2(-85, -240),
		
		Vector2(-163, -240),
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		
		Vector2(-85, -240),
		Vector2(-163, -240),
		Vector2(-124, -240),
		Vector2(-47, -240),
		
		Vector2(-201, -240),
		Vector2(-124, -240),
		Vector2(-85, -240),
		Vector2(-163, -240),
		
		Vector2(-85, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		Vector2(-163, -240),
		
		Vector2(-201, -240),
		Vector2(-85, -240),
		Vector2(-124, -240),
		Vector2(-47, -240),
		
		Vector2(-47, -240),
		Vector2(-201, -240),
		Vector2(-124, -240),
		Vector2(-163, -240),
		
		Vector2(-124, -240),
		Vector2(-85, -240),
		Vector2(-163, -240),
		Vector2(-47, -240),
		
		Vector2(-124, -240),
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-85, -240),
		
		Vector2(-124, -240),
		Vector2(-201, -240),
		Vector2(-85, -240),
		Vector2(-47, -240),
		
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		Vector2(-85, -240),
		
		Vector2(-163, -240),
		Vector2(-163, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		
		Vector2(-85, -240),
		Vector2(-163, -240),
		Vector2(-124, -240),
		Vector2(-47, -240),
		
		Vector2(-201, -240),
		Vector2(-124, -240),
		Vector2(-85, -240),
		Vector2(-163, -240),
		
		Vector2(-85, -240),
		Vector2(-201, -240),
		Vector2(-47, -240),
		Vector2(-163, -240),
		
		Vector2(-201, -240),
		Vector2(-85, -240),
		Vector2(-124, -240),
		Vector2(-47, -240),
		
		Vector2(-47, -240),
		Vector2(-201, -240),
		Vector2(-124, -240),
		Vector2(-163, -240),
		
		Vector2(-124, -240),
		Vector2(-85, -240),
		Vector2(-163, -240),
		Vector2(-47, -240),
		]
	await droping_heads_in_patern(numberOfHeads, positionOfHead)
	
func droping_heads_in_patern(numberOfHeads, positionOfHead):
	for n in range(numberOfHeads):
		if !bossalive: 
			break
		var head = HEAD.instantiate()
		get_tree().root.add_child(head)
		head.global_position = positionOfHead[n]
		head.direction = (Vector2(0, 500)).normalized()
		await get_tree().create_timer(0.25).timeout
