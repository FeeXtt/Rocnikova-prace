extends Control

var paused = false;



func _input(event) -> void:
	if event.is_action_pressed("Escape") && !paused:
		pause()
		AudioManagerScene.stop_music()
	elif event.is_action_pressed("Escape") && paused:
		resume()
		AudioManagerScene.resume_music()


func _ready() -> void:
	$AnimationPlayer.play("RESET")


func pause():
	paused = true;
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
	
func resume():
	paused = false
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	


func _on_resume_pressed() -> void:
	if paused:
		resume()
		print("resume")
		AudioManagerScene.resume_music()


func _on_save_pressed() -> void:
	if paused:
		GameManager.save()


func _on_main_menu_pressed() -> void:
	if paused:
		AudioManagerScene.stop_music()
		get_tree().paused = false
		for node in get_tree().get_nodes_in_group("marks"):
			node.queue_free()
		for node in get_tree().get_nodes_in_group("projectiles"):
			node.queue_free()
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
		
		


func _on_exit_pressed() -> void:
	if paused:
		AudioManagerScene.stop_music()
		get_tree().quit()
