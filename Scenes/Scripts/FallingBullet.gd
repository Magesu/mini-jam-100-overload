extends Area2D


# Export variables
export var speed = 100
export var fall_speed = 1

# Variables
var direction = Vector2.UP
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction.y += fall_speed * delta
	rotation = direction.normalized().angle()
	
	# Makes the bullet move forward
	velocity = direction * speed
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	# Kills the bullet when it goes offscreen
	queue_free()

func _on_FallingBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
