extends KinematicBody2D


# Export variables
export var speed = 400
export var radius = 40

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
onready var animator = $AnimatedSprite #equivalent to "get_node("AnimatedSprite")

# Scenes
var bullet_scene = preload("res://Scenes/Bullet.tscn")

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
		animator.flip_h = false
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
		animator.flip_h = true
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	# Shoot
	if Input.is_action_just_pressed("mouse_left_click"):
		var bullet = bullet_scene.instance()
		var rotation = position.angle_to_point(get_global_mouse_position()) + PI
		bullet.position = position + Vector2.RIGHT.rotated(rotation) * radius
		bullet.rotation = rotation
		bullet.speed = 500
		get_tree().get_root().add_child(bullet)
		
	
	# Makes the player's velocity direction * speed
	# Direction is normalized so the player doesn't move faster diagonally
	velocity = direction.normalized() * speed
	
	if velocity == Vector2.ZERO:
		animator.play("default")
	else:
		animator.play("walking")

	# I like to move it, move it. I like to move it, move it. Ya like to (Move it!)
	move_and_slide(velocity)
