extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Bomb/Play.grab_focus()

#quit
func _on_quit_pressed():
	get_tree().quit()

#Play Button
@onready var animation = $AnimationPlayer
var Toggle = true
var Check = true

func _on_button_pressed():
	if Toggle:
		$"PvP'".show()
		$"PvE'".show()
		$"PvE'/PvE".show()
		$"PvP'/PvP".show()
		animation.play("Button_Battle_Click")
		$OutTimer.start()
		if animation.is_playing():
			$"PvP'/PvP".focus_mode = Control.FOCUS_NONE
			$"PvE'/PvE".focus_mode = Control.FOCUS_NONE
			$Customize.focus_mode = Control.FOCUS_NONE
			$Quit.focus_mode = Control.FOCUS_NONE
			$Transition.start()
	else:
		animation.play_backwards("Button_Battle_Click")
		if animation.is_playing():
			$"PvP'/PvP".focus_mode = Control.FOCUS_NONE
			$"PvE'/PvE".focus_mode = Control.FOCUS_NONE
			$Customize.focus_mode = Control.FOCUS_NONE
			$Quit.focus_mode = Control.FOCUS_NONE
			$Transition.start()
		if Check:
			$"PvE'/PvE".hide()
			$"PvP'/PvP".hide()
			Check = false
		$InTimer.start()
	Toggle = !Toggle

func _on_transition_timeout():
	$"PvP'/PvP".focus_mode = Control.FOCUS_ALL
	$"PvE'/PvE".focus_mode = Control.FOCUS_ALL
	$Bomb/Play.focus_mode = Control.FOCUS_ALL
	$Customize.focus_mode = Control.FOCUS_ALL
	$Quit.focus_mode = Control.FOCUS_ALL
	$Transition.stop()
	
func _on_timer_timeout():
	$Customize.show()
	$Quit.show()
	Check = true
	$OutTimer.stop()
	
func _on_out_timer_timeout():
	$Customize.hide()
	$Quit.hide()
	$OutTimer.stop()

func _on_pv_p_pressed():
	get_tree().change_scene_to_file("res://Scenes/CharacterSelectionArea.tscn")

var recent_animation = ""
#Pvp button
func _on_pv_p_focus_entered():
	animation.play("Hover_PvP")
	recent_animation = "Hover_PvP"
func _on_pv_p_focus_exited():
	$Bomb/Play.disabled = true
	$Hover.start()
	
#Pve button
func _on_pv_e_focus_entered():
	recent_animation = "Hover_PvE"
	animation.play("Hover_PvE")
func _on_pv_e_focus_exited():
	$Bomb/Play.disabled = true
	$Hover.start()

func _on_hover_timeout():
	if $Bomb/Play.has_focus():
		$Bomb/Play.disabled = true
		if recent_animation == "Hover_PvE":
			animation.play_backwards("Hover_PvE")
			if animation.is_playing():
				$"PvP'/PvP".focus_mode = Control.FOCUS_NONE
				$"PvE'/PvE".focus_mode = Control.FOCUS_NONE
				$Transition.start()
		elif recent_animation == "Hover_PvP":
			animation.play_backwards("Hover_PvP")
			if animation.is_playing():
				$"PvP'/PvP".focus_mode = Control.FOCUS_NONE
				$"PvE'/PvE".focus_mode = Control.FOCUS_NONE
				$Transition.start()
		$Pressed.start()
			
	if $"PvP'/PvP".has_focus():
		animation.play_backwards("Hover_PvE")
		print(recent_animation)
		if animation.is_playing():
			$"PvE'/PvE".focus_mode = Control.FOCUS_NONE
			$Bomb/Play.focus_mode = Control.FOCUS_NONE
			$Transition.start()
			
	if $"PvE'/PvE".has_focus():
		animation.play_backwards("Hover_PvP")
		recent_animation = "Hover_PvE"
		print(recent_animation)
		if animation.is_playing():
			$"PvP'/PvP".focus_mode = Control.FOCUS_NONE
			$Bomb/Play.focus_mode = Control.FOCUS_NONE
			$Transition.start()
	$Hover.stop()
 

func _on_pressed_timeout():
	$Bomb/Play.disabled = false
	$Pressed.stop()

#customize button
func _on_customize_pressed():
	if Toggle:
		$Ninentndo.show()
		$Customize.focus_mode = Control.FOCUS_ALL
		$Bomb/Play.focus_mode = Control.FOCUS_NONE
		$Quit.focus_mode = Control.FOCUS_NONE
		animation.play("Customize_On_Pressed")
		$Customize_in.start()
		
	else:
		$Bomb/Play.focus_mode = Control.FOCUS_NONE
		$Quit.focus_mode = Control.FOCUS_NONE
		animation.play_backwards("Customize_On_Pressed")
		$Bomb/Play.show()
		$Quit.show()
		$Customize_out.start()
	Toggle = !Toggle


func _on_customize_out_timeout():
	$Ninentndo.hide()
	$Bomb/Play.focus_mode = Control.FOCUS_ALL
	$Quit.focus_mode = Control.FOCUS_ALL
	$Customize_out.stop()

func _on_customize_in_timeout():
	$Bomb/Play.hide()
	$Quit.hide()
	$Customize_in.stop()

