class_name Boss2
extends Node2D

@export var max_health := 200;
var bossalive = true
var current_health := max_health
@onready var health_bar = $"../HealthBar"
var spikes = preload("res://scenes/bosses/boss2/changable_spikes.tscn")
var spikes2 = preload("res://scenes/bosses/boss2/changable_spikes.tscn")
var marks = preload("res://scenes/bosses/boss2/marks_for_spikes.tscn")
var marks2 = preload("res://scenes/bosses/boss2/marks_for_spikes.tscn")
var spikepositions = [
	-360.0,360,
	-288.0,288,
	-216.0,216,
	-144.0,144,
	-72.0,72.0,
	0.0,]
var CSHARP = preload("res://scenes/bosses/boss2/c#_bullet.tscn")
var HEAD  = preload("res://scenes/bosses/boss2/radek_head.tscn")
var DOTNET = preload("res://scenes/bosses/boss2/dot_net_logo.tscn")
var SPIKESAREA = preload("res://scenes/bosses/boss2/spike_area.tscn")

func _ready() -> void:
	health_bar.update_healthbar(current_health, max_health)
	bossloop()
	
func bossloop():
	await get_tree().create_timer(3).timeout
	while bossalive:
		await phase1()
		await phase2()
		await phase3()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		print("au")
		current_health -= 1
		health_bar.update_healthbar(current_health, max_health)
		if current_health <= 0:
			queue_free()
		if area.get_parent() is Player:
			area.get_parent().die()

# Phase 1
func phase1():
	mark_cycle(spikepositions, range(0,10, 2), 5, 3)
	move_to_position_smoothly(Vector2(345.0, 80.0), 0.4)
	for i in 4:
			var positionsY = [112.0,112.0,112.0, 81.0,81.0,81.0, 99.0,99.0,]
			global_position = Vector2(412.0, 80.0)
			await move_to_position_smoothly(Vector2(320.0, 80.0), 0.4)
			await shoot_scsharp_in_patter(positionsY, 0.5,-400.0, 280)
			await move_to_position_smoothly(Vector2(412.0, 80.0), 0.4)
			await get_tree().create_timer(1).timeout
			global_position = Vector2(-412.0, 80.0)
			await move_to_position_smoothly(Vector2(-320.0, 80.0), 0.4)
			await shoot_scsharp_in_patter(positionsY, 0.5,400.0, -280)
			await move_to_position_smoothly(Vector2(-412.0, 80.0), 0.4)
			await get_tree().create_timer(1).timeout
	await get_tree().create_timer(4).timeout
		

func mark_cycle(positions, range, timer1, timer2):
	for n in range(0,10, 2):
			await get_tree().create_timer(timer1).timeout
			print(n)
			var mark = marks.instantiate() 
			get_tree().root.add_child(mark)
			mark.global_position = Vector2(spikepositions[n], 125)
			mark.add_to_group("marks")
			var mark2 = marks2.instantiate() 
			get_tree().root.add_child(mark2)
			mark2.global_position = Vector2(spikepositions[n+1], 125)
			mark2.add_to_group("marks")
			await get_tree().create_timer(timer2).timeout
			var spike = spikes.instantiate()
			get_tree().root.add_child(spike)
			spike.global_position = Vector2(spikepositions[n], 125)
			spike.add_to_group("marks")
			var spike2 = spikes2.instantiate()
			get_tree().root.add_child(spike2)
			spike2.global_position = Vector2(spikepositions[n+1], 125)
			spike2.add_to_group("marks")
	#var mark = marks.instantiate() 
	#get_tree().root.add_child(mark)
	#mark.global_position = Vector2(positions[10], 125)
	#mark.add_to_group("marks")
	#await get_tree().create_timer(2).timeout
	#var spike = spikes.instantiate()
	#get_tree().root.add_child(spike)
	#spike.global_position = Vector2(positions[10], 125)
	#spike.add_to_group("marks")

func delete_spikes():
	for node in get_tree().get_nodes_in_group("marks"):
			node.queue_free()

func shoot_scsharp_in_patter(positions, time, secondaryposition, Xspawnpoint):
	for n in 8:
		if !bossalive: 
			break
		print(n)
		var cSharp = CSHARP.instantiate()
		get_tree().root.add_child(cSharp)
		cSharp.global_position = Vector2(Xspawnpoint, positions[n])
		cSharp.direction = (Vector2(secondaryposition, positions[n]) - cSharp.global_position ).normalized()
		await get_tree().create_timer(time).timeout
func move_to_position_smoothly(target: Vector2, duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", target, duration)
	await tween.finished
	
	
#Phase 2
func phase2():
	await move_to_position_smoothly(Vector2(-102.0, -102.0), 1.0)
	var positionOfHead = [
		-12.0,-12.0,-12.0,
		12,12,12,
		-12.0,-12.0,
		12,12,
		-12.0,
		12,
		-12.0,
		12,
		-12.0,-12.0,
		12,12,
		-12.0,-12.0,
		12,12,
		-12.0,-12.0,-12.0,
		12,12,12,
		-12.0,-12.0,-12.0,
		12,12,12,
		-12.0,-12.0,
		12,12,
		-12.0,
		12,
		-12.0,
		12,
		-12.0,-12.0,
		12,12,
		-12.0,-12.0,
		12,12,
		-12.0,-12.0,-12.0,
		12,12,12,
		 ]
	await droping_heads_in_patern(positionOfHead)
	
func droping_heads_in_patern(positionOfHead):
	for n in range(positionOfHead.size()):
		if !bossalive: 
			break
		var head = HEAD.instantiate()
		get_tree().root.add_child(head)
		head.global_position = Vector2(positionOfHead[n], -250)
		head.direction = (Vector2(0, 500)).normalized()
		await get_tree().create_timer(0.5).timeout
		
#phase 3
func phase3():
	for node in get_tree().get_nodes_in_group("marks"):
		node.queue_free()
	var position_of_boss = [
		Vector2(-242.0, -124.0),
		Vector2(0, 0),
		Vector2(242.0, -140.0),
		Vector2(-242.0, -100.0),
		Vector2(0, -50.0),
		Vector2(242.0, -80),
		Vector2(-242.0, -20.0),
		Vector2(0, -40.0),
		Vector2(242.0, -0.0),
		Vector2(-242.0, -10.0),
		Vector2(0, -100.0),
		Vector2(242.0, -80.0),
		Vector2(-242.0, -124.0),
		Vector2(0, 0),
		Vector2(242.0, -140.0),
		Vector2(-242.0, -100.0),
		Vector2(0, -50.0),
		Vector2(242.0, -80),
		Vector2(-242.0, -20.0),
		Vector2(0, -40.0),
		Vector2(242.0, -0.0),
		Vector2(-242.0, -10.0),
		Vector2(0, -100.0),
		Vector2(242.0, -80.0),
	]
	await spawn_spike_areas()
	await shoot_in_circle(position_of_boss)
	for node in get_tree().get_nodes_in_group("marks"):
		node.queue_free()
	await get_tree().create_timer(3).timeout
	
	
	
	
func shoot_in_circle(position_of_boss):
	for n in position_of_boss.size():
		await move_to_position_smoothly(position_of_boss[n], 0.4)
		for i in 20:
			var angle = TAU * i / 20
			var direction = Vector2.RIGHT.rotated(angle)
			var dotnet = DOTNET.instantiate()
			get_tree().root.add_child(dotnet)
			dotnet.global_position = global_position
			dotnet.direction = direction
		await get_tree().create_timer(1).timeout
		
func spawn_spike_areas():
	for n in spikepositions.size():
		var area = SPIKESAREA.instantiate() 
		get_tree().root.add_child(area)
		area.global_position = Vector2(spikepositions[n], 125)
		area.add_to_group("marks")
		
	
