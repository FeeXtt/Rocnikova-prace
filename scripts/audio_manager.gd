extends Node

@onready var music = $Music
@onready var jump = $JumpingSound
@onready var shoot = $ShootingSound
@onready var shotgunfire = $ShotgunFire
var paused_position


func play_music(stream: AudioStream):
	if music.stream != stream:
		music.stream = stream
		music.play()

func stop_music():
	paused_position = music.get_playback_position()
	music.stop()
	print(paused_position)
	
func resume_music():
	if music.stream:
		music.play(paused_position)

func shoot_play():
	shoot.play()
	
func jump_play():
	jump.play()
	
func play_music_boss_level(stream: AudioStream):
		music.stream = stream
		music.play()
func play_shotgun_fire():
	shotgunfire.play()
	
