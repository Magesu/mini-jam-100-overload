extends KinematicBody2D


# Export variables
export var rotate_speed = 100
export var shoot_timer_wait_time = 0.2
export var spawnpoint_count = 4
export var radius = 100

# Nodes
onready var shoot_timer = $ShootTimer
onready var rotator = $Rotator

# Scenes
var bullet_scene = preload("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets the angle inbetween the spawnpoints
	var step = (2 * PI) / spawnpoint_count
	
	# For every spawnpoint, create a new position node at the appropriate position and with the appropriate rotation
	for i in range(spawnpoint_count):
		var spawnpoint = Position2D.new()
		
		# Creates a vector with the distance of radius and rotates it by the step times i
		var pos = Vector2(radius, 0).rotated(step * i)
		spawnpoint.position = pos
		spawnpoint.rotation = pos.angle()
		rotator.add_child(spawnpoint)
	
	# Starts the timer
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# BANANAS ROTAT E
	var new_rotation = rotator.rotation_degrees + (rotate_speed * delta)
	rotator.rotation_degrees = fmod(new_rotation, 360)


func _on_Shoot_Timer_timeout():
	# Spawns a bullet in every spawnpoint
	for child in rotator.get_children():
		var bullet = bullet_scene.instance()
		bullet.position = child.global_position
		bullet.rotation = child.global_rotation
		get_tree().get_root().add_child(bullet)
