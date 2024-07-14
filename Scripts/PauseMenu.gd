extends Control

var paused = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pausemenu()
		
func pausemenu():
	if paused == true:
		$AnimationPlayer.play("Pause_Menu")
		paused = false
		Engine.time_scale = 1
	else:
		$AnimationPlayer.play_backwards("Pause_Menu")
		Engine.time_scale = 1
		paused = true
		
	
		
	
