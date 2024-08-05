extends Control
#$notes: check whether if the pvp and pve are minimize, dsisable focus group and when not enable focus group

# Called when the node enters the scene tree for the first time.
#func _ready():
#	$Bomb/Play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/pvp_pveMenu.tscn")

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
	else:
		animation.play_backwards("Button_Battle_Click")
		if Check:
			$"PvE'/PvE".hide()
			$"PvP'/PvP".hide()
			Check = false
		$InTimer.start()
	Toggle = !Toggle
	
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

