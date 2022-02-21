extends Area2D


# Export variables
export var speed = 100
export var angular_speed = 0
export var max_angle_deviation = 90
export var spin_increment_wait_time = 0.1
export var deviation_delay_wait_time = 0

# Variables
var original_rotation
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var can_deviate = false

# Nodes 
onready var spin_increment = get_node("SpinIncrement")
onready var deviation_delay = get_node("DeviationDelay")
onready var lifespan = get_node("Lifespan")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets the direction of the bullet with the power of MATH
	direction = Vector2(cos(get_rotation()),sin(get_rotation()))
	original_rotation = rotation_degrees
	
	# Starts the timer that's going to tell when to change the angle so we don't change the angle every frame
	spin_increment.wait_time = spin_increment_wait_time
	spin_increment.start()
	
	# Starts (or not) the timer that delays the curving of the spinny bullet
	if deviation_delay_wait_time > 0:
		deviation_delay.wait_time = deviation_delay_wait_time
		deviation_delay.start()
	else:
		can_deviate = true
	
	lifespan.start()
	z_index = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Makes the bullet move forward
	velocity = direction * speed
	position += velocity * delta

func _on_SpinIncrement_timeout():
	# Checks if the deviation delay has passed
	if can_deviate:
		# CUUUUUUUUUUUUUUUUUUUUUUUUUUURVES if the bullet hasn't hit the max angle deviation so it doesn't keep spinning on screen
		if rotation_degrees >= (original_rotation - max_angle_deviation) and rotation_degrees <= (original_rotation + max_angle_deviation):
			rotation_degrees += angular_speed
			direction = Vector2(cos(get_rotation()),sin(get_rotation()))

func _on_DeviationDelay_timeout():
	# Deviation delay has passed
	can_deviate = true

func _on_Lifespan_timeout():
	queue_free()

func _on_SpinningBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
