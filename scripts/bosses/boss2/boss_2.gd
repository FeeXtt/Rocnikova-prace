class_name Boss2
extends Node2D

@export var max_health := 1;
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
	0.0,
]

func _ready() -> void:
	health_bar.update_healthbar(current_health, max_health)
	bossloop()
	
func bossloop():
	while bossalive:
		await phase1()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Bullet:
		print("au")
		current_health -= 1
		health_bar.update_healthbar(current_health, max_health)
		if current_health <= 0:
			queue_free()
			
			
			
# Phase 1
func phase1():
	await mark_cycle()
	await delete_spikes()
	
	
func mark_cycle():
	for n in range(0,10, 2):
			print(n)
			var mark = marks.instantiate() 
			get_tree().root.add_child(mark)
			mark.global_position = Vector2(spikepositions[n], 125)
			mark.add_to_group("marks")
			var mark2 = marks2.instantiate() 
			get_tree().root.add_child(mark2)
			mark2.global_position = Vector2(spikepositions[n+1], 125)
			mark2.add_to_group("marks")
			await get_tree().create_timer(2).timeout
			var spike = spikes.instantiate()
			get_tree().root.add_child(spike)
			spike.global_position = Vector2(spikepositions[n], 125)
			spike.add_to_group("marks")
			var spike2 = spikes2.instantiate()
			get_tree().root.add_child(spike2)
			spike2.global_position = Vector2(spikepositions[n+1], 125)
			spike2.add_to_group("marks")
	var mark = marks.instantiate() 
	get_tree().root.add_child(mark)
	mark.global_position = Vector2(spikepositions[10], 125)
	mark.add_to_group("marks")
	await get_tree().create_timer(2).timeout
	var spike = spikes.instantiate()
	get_tree().root.add_child(spike)
	spike.global_position = Vector2(spikepositions[10], 125)
	spike.add_to_group("marks")

func delete_spikes():
	for node in get_tree().get_nodes_in_group("marks"):
			node.queue_free()
	
