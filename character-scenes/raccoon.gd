extends CharacterBody2D


const SPEED = 70
#const JUMP_VELOCITY = -400.0
# NODES
@onready var animation = get_node("AnimationPlayer")
@onready var sprite = $AnimatedSprite2D


# Game Variables

func _physics_process(delta):
	# buttons
	var up1 = Input.is_action_pressed('up_player1')
	var down1 = Input.is_action_pressed('down_player1')
	var down_released1 = Input.is_action_just_released('down_player1')
	var right1 = Input.is_action_pressed('right_player1')
	var left1 = Input.is_action_pressed('left_player1')
	var place_bomb1 = Input.is_action_just_pressed('place_bomb')
	
	# WALKING
	if up1 or down1:
		if up1:
			velocity.y = -SPEED
#			if not right1 and not left1:
			animation.play('up')
		if down1:
			velocity.y = SPEED
#			if not right1 and not left1:
			animation.play('down')
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if right1 or left1:
		if right1 or (right1 and up1) or (right1 and down1):
			sprite.flip_h = false
			animation.play('side')
			velocity.x = SPEED
		if left1 or (left1 and up1) or (left1 and down1):
			sprite.flip_h = true
			animation.play('side')
			velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.flip_h = false
#	
	if not (up1 or down1 or left1 or right1):
		animation.play('idle')
		
		
	if place_bomb1:
		pass
	
	move_and_slide()
