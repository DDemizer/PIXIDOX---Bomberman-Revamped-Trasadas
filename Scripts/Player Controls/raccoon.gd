extends CharacterBody2D


const SPEED = 70
#const JUMP_VELOCITY = -400.0
# NODES
@onready var animation = get_node("AnimationPlayer")
@onready var sprite = $AnimatedSprite2D
@export var player = 0

# Buttons
var up = 11
var down = 12
var left = 13
var right = 14
var start_button = 6
var select_button = 4
var green = 2
var blue = 3
var yellow = 0
var red = 1
var l1 = 9
var r1 = 10


func _physics_process(delta):
	# buttons
	var up_button = Input.is_joy_button_pressed(player, up)
	var down_button = Input.is_joy_button_pressed(player, down)
	var right_button = Input.is_joy_button_pressed(player, right)
	var left_button = Input.is_joy_button_pressed(player, left)
	var place_bomb = Input.is_joy_button_pressed(player, green)
	var escape = Input.is_action_just_pressed('ui_cancel')
	
	# WALKING
	if up_button or down_button:
		if up_button:
			velocity.y = -SPEED
			if not right_button and not left_button:
				animation.play('up')
		if down_button:
			velocity.y = SPEED
			if not right_button and not left_button:
				animation.play('down')
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if right_button or left_button:
		if right_button or (right_button and up_button) or (right_button and down_button):
			sprite.flip_h = false
			animation.play('side')
			velocity.x = SPEED
		if left_button or (left_button and up_button) or (left_button and down_button):
			sprite.flip_h = true
			animation.play('side')
			velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.flip_h = false
#	
	if not (up_button or down_button or left_button or right_button):
		animation.play('idle')
		
		
	if place_bomb:
		pass
	
	if escape:
		get_tree().quit()
	move_and_slide()
