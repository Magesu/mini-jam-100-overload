extends KinematicBody2D


# Export variables
export var speed = 400
export var radius = 40
export var imortal = false
export var discharging = false
export var discharge_radius_max = 0

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Nodes
onready var animator = $AnimatedSprite #equivalent to "get_node("AnimatedSprite")
onready var charge_animator = $AnimatedSprite/AnimatedSprite2
onready var hitbox = $Hitbox
onready var discharge = $Discharge/CollisionShape2D
onready var game = get_parent()

#Signals
signal player_hit

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


	# Checks if the player tried to discharge and if there is enough charge for it
	if Input.is_action_just_pressed("ui_accept") and game.charge_percentage > 0.75:
		game.reset_charge()
		discharge_radius_max = clamp(200*(game.charge_percentage-0.75), 0, 50)
		discharge.disabled = false
		discharging = true
		# Plays the charge backwards
		charge_animator.play("charge", true)
		charge_animator.modulate = Color(1, 1, 1, 1)
		
	# Controls the discharging and resets when reaches the max
	if discharging:
		discharge.scale += Vector2(delta*500, delta*500)
		charge_animator.scale += Vector2(delta*500, delta*500)
		if discharge.scale.x >= discharge_radius_max:
			discharging = false
			discharge.disabled = true
			discharge.scale = Vector2(1, 1)
			charge_animator.scale = Vector2(1, 1)
			charge_animator.modulate = Color(1, 1, 1, 150.0/255)

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
	
	# Animates the charging animation when passes a certain treshold
	if not discharging:
		if game.charge_percentage > 0.7:
#			charge_animator.modulate = Color(1, 1, 1, (-0.5+game.charge_percentage)*4)
			charge_animator.speed_scale = clamp(1/(1-game.charge_percentage), 1, 10)
			charge_animator.play("charge")
		else:
#			charge_animator.modulate = Color(0, 0, 0, 0)
			charge_animator.speed_scale = 1
			charge_animator.play("default")


func _on_Hitbox_area_entered(area):
	# OUCH! makes the player red and emits the signal (to the game)
	if not imortal:
		if area.is_in_group("enemy"):
			player_die()
	#		yield(get_tree().create_timer(0.2),"timeout")
	#		animator.modulate = Color(1,1,1)

func player_die():
	animator.modulate = Color(1,0,0)
	emit_signal("player_hit")

func _on_Timer_timeout():
	imortal = false
