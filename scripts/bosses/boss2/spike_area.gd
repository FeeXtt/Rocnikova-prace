extends Node2D

@export var trigger_time := 1.0  # sekundy
@onready var timer := Timer.new()
var player_in_area := false
var spikes = preload("res://scenes/bosses/boss2/changable_spikes.tscn")
var marks = preload("res://scenes/bosses/boss2/marks_for_spikes.tscn")

func _ready() -> void:
	timer.wait_time = trigger_time
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timeout"))
	add_child(timer)
	connect("body_entered", Callable(self, "_on_area_2d_area_entered"))
	connect("body_exited", Callable(self, " _on_area_2d_area_exited"))


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_in_area = true
		timer.start()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		player_in_area = false
		timer.stop()

func _on_timeout():
	if player_in_area:
		var mark = marks.instantiate() 
		get_tree().root.add_child(mark)
		mark.global_position = global_position
		mark.add_to_group("marks")
		await get_tree().create_timer(2).timeout
		var spike = spikes.instantiate()
		get_tree().root.add_child(spike)
		spike.global_position = global_position
		spike.add_to_group("marks")
		await get_tree().create_timer(2).timeout
		spike.queue_free()
		mark.queue_free()
		
