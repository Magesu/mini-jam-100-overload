extends KinematicBody2D


# Export variables
export var speed = 400

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Stops the player
	direction = Vector2.ZERO
	
	# Checks if the player is pressing a movement button and makes the direction that direction
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	
	# Makes the player's velocity direction * speed
	# Direction is normalized so the player doesn't move faster diagonally
	velocity = direction.normalized() * speed
	
	# I like to move it, move it. I like to move it, move it. Ya like to (Move it!)
	move_and_slide(velocity)
