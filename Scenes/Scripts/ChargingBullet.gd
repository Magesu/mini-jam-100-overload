extends Area2D


# Export variables
export var speed = 100

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Nodes
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets the direction of the bullet with the power of MATH
	direction = Vector2(cos(get_rotation()),sin(get_rotation()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Makes the bullet move forward
	velocity = direction * speed
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	# Kills the bullet when it goes offscreen
	queue_free()


func _on_ChargingBullet_body_entered(body):
	# Kills bullet when it touches the charger
	if parent != null:
		if body == parent:
			queue_free()
