extends Control

@onready var animation = $AnimationPlayer
@onready var animation1 = $Exit
@export var paused = false
var check = true
var swap = true

# Called when the node enters the scene tree for the first time.
func _ready():
	BattleManager.connect('paused', pausemenu)
#	paused = true
	


#func _process(delta):
func pausemenu():
	animation1.play("Exit")
	$Resume/R_Button.grab_focus()
	if check:
		animation.play("Resume")
		check = false
	print_debug(paused)
	if paused == true:
		paused = false
		get_tree().paused = true
	else:
		get_tree().paused = false
		paused = true
#	paused = !paused
	
		
	
var anim = ""

func _on_e_button_focus_entered():
	anim = "Exit"
	animation.play("Exit")

func _on_e_button_focus_exited():
	$Hover.start()
		
		
func _on_r_button_focus_entered():
	animation.play("Resume")

func _on_r_button_focus_exited():
	$Hover.start()


func _on_c_button_focus_entered():
	anim = "Custom"
	animation.play("Customize")

func _on_c_button_focus_exited():
	$Hover.start()

func _on_hover_timeout():
	if $Customize/C_Button.has_focus():
		animation.play_backwards("Resume")
		if animation.is_playing():
			$Resume/R_Button.focus_mode = Control.FOCUS_NONE
			$Exit/E_Button.focus_mode = Control.FOCUS_NONE
			$Transition.start()
	if $Resume/R_Button.has_focus():
		if anim == "Custom":
			animation.play_backwards("Customize")
			if animation.is_playing():
				$Exit/E_Button.focus_mode = Control.FOCUS_NONE
				$Customize/C_Button.focus_mode = Control.FOCUS_NONE
				$Transition.start()
		if anim == "Exit":
			animation.play_backwards("Exit")
			if animation.is_playing():
				$Exit/E_Button.focus_mode = Control.FOCUS_NONE
				$Customize/C_Button.focus_mode = Control.FOCUS_NONE
				$Transition.start()
	if $Exit/E_Button.has_focus():
		animation.play_backwards("Resume")
		if animation.is_playing():
			$Resume/R_Button.focus_mode = Control.FOCUS_NONE
			$Customize/C_Button.focus_mode = Control.FOCUS_NONE
			$Transition.start()
	$Hover.stop()



func _on_transition_timeout():
	$Exit/E_Button.focus_mode = Control.FOCUS_ALL
	$Customize/C_Button.focus_mode = Control.FOCUS_ALL
	$Resume/R_Button.focus_mode = Control.FOCUS_ALL
	$Transition.stop()


func _on_e_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	get_tree().paused = false


func _on_c_button_pressed():
	if swap:
		$Resume.hide()
		$Exit.hide()
		$Ninentndo.show()
	else:
		$Resume.show()
		$Exit.show()
		$Ninentndo.hide()
	swap = !swap


func _on_r_button_pressed():
#	paused = false
	pausemenu()
	self.hide()
