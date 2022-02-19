extends KinematicBody2D


# Export variables
export var shoot_angle = 360
export var rotate_speed = 100
export var shoot_timer_wait_time = 0.2
export var spawnpoint_count = 4
export var radius = 100
export var bullet_speed = 100

export var turns = false
export var turn_timer_wait_time = 1


export var target_player = false


# Nodes
onready var shoot_timer = $ShootTimer
onready var rotator = $Rotator
onready var turn_timer = $TurnTimer

onready var main = get_tree().root.get_node("Main")
onready var player = main.get_node("Player")

# Scenes
var bullet_scene = preload("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_rotation
	if target_player:
		# Targets player instead of rotating
		new_rotation = rad2deg(player.global_position.angle_to_point(global_position))
	else:
		# BANANAS ROTAT E
		new_rotation = rotator.rotation_degrees + (rotate_speed * delta)
	
	rotator.rotation_degrees = fmod(new_rotation, 360)


func _on_Shoot_Timer_timeout():
	# Spawns a bullet in every spawnpoint
	for child in rotator.get_children():
		var bullet = bullet_scene.instance()
		bullet.position = child.global_position
		bullet.rotation = child.global_rotation
		bullet.speed = bullet_speed
		get_tree().get_root().add_child(bullet)

func update():
	# Deletes all existing spawnpoints
	for child in rotator.get_children():
		child.queue_free()
	
	# Gets the angle inbetween the spawnpoints
	var step = deg2rad(shoot_angle) / spawnpoint_count
	
	# For every spawnpoint, create a new position node at the appropriate position and with the appropriate rotation
	for i in range(spawnpoint_count):
		var spawnpoint = Position2D.new()
		
		# Creates a vector with the distance of radius and rotates it by the step times i
		var pos = Vector2(radius, 0).rotated(step * (i - (spawnpoint_count / 2)))
		spawnpoint.position = pos
		spawnpoint.rotation = pos.angle()
		rotator.add_child(spawnpoint)
	
	# Starts the timer
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()
	
	# Starts the turn timer
	if turns:
		turn_timer.wait_time = turn_timer_wait_time
		turn_timer.start()
	else:
		turn_timer.stop()


func _on_TurnTimer_timeout():
	rotate_speed = -rotate_speed
