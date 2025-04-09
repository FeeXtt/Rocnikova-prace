extends Control

var paused = false;



func _input(event) -> void:
	if event.is_action_pressed("Escape") && !paused:
		pause()
	elif event.is_action_pressed("Escape") && paused:
		resume()
	

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


func _on_save_pressed() -> void:
	if paused:
		GameManager.save()


func _on_main_menu_pressed() -> void:
	if paused:
<<<<<<< Updated upstream
=======
		get_tree().paused = false
>>>>>>> Stashed changes
		get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")


func _on_exit_pressed() -> void:
	if paused:
		get_tree().quit()
	
