extends KinematicBody2D


# Export variables
export var speed = 400
export var radius = 40

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Nodes
onready var animator = $AnimatedSprite #equivalent to "get_node("AnimatedSprite")
onready var hitbox = $Hitbox

#Signals
signal player_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Stops the player
	direction = Vector2.ZERO
	
	# Checks if the player is pressing a movement button and makes the direction that direction
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT
		animator.flip_h = false
		hitbox.position.x = 7
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
		animator.flip_h = true
		hitbox.position.x = -7
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	
	# Makes the player's velocity direction * speed
	# Direction is normalized so the player doesn't move faster diagonally
	if Input.is_action_pressed("shift"):
		velocity = direction.normalized() * (speed / 2)
	else:
		velocity = direction.normalized() * speed
	
	if velocity == Vector2.ZERO:
		animator.play("default")
	else:
		animator.play("walking")

	# I like to move it, move it. I like to move it, move it. Ya like to (Move it!)
	move_and_slide(velocity)


func _on_Hitbox_area_entered(area):
	# OUCH! makes the player red and emits the signal (to the game)
	if area.is_in_group("enemy"):
		animator.modulate = Color(1,0,0)
		emit_signal("player_hit")
#		yield(get_tree().create_timer(0.2),"timeout")
#		animator.modulate = Color(1,1,1)
