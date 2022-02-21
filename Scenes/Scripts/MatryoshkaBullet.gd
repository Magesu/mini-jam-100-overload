extends Area2D


# Export variables
export var lifespan_wait_time = 1
export var speed = 100
export var shoot_angle = 360
export var spawnpoint_count = 1
export var radius = 1
export var bullet_speed = 100
export var target_player = false
export var rand_lifespan = false

# Nodes
onready var main = get_tree().root.get_node("Game")
onready var player = main.get_node("Player")
onready var lifespan = get_node("Lifespan")

# Scenes
export(PackedScene) var bullet_scene = preload("res://Scenes/Bullet.tscn")

# Variables
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# Gets the direction of this bullet with the power of MATH
	direction = Vector2(cos(get_rotation()),sin(get_rotation()))
	
	# Matryoshka bullet is now officially born
	if rand_lifespan:
		lifespan.wait_time = 1 + (randi() % lifespan_wait_time)
	else:
		lifespan.wait_time = lifespan_wait_time
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Makes the bullet move forward
	velocity = direction * speed
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	# Kills the bullet when it goes offscreen
	queue_free()

func _on_Lifespan_timeout():
	# Gets the angle inbetween the spawnpoints of the new bullets
	var step = deg2rad(shoot_angle) / spawnpoint_count
	
	# For every spawnpoint, create a new position node at the appropriate position and with the appropriate rotation
	for i in range(spawnpoint_count):
		var bullet = bullet_scene.instance()
		
		# Creates a vector with the distance of radius and rotates it by the step times i
		var pos = Vector2(radius, 0).rotated(step * (i - (spawnpoint_count / 2)))
		
		# Decides wether the new bullets will target the player or not
		if target_player:
			bullet.global_rotation = player.global_position.angle_to_point(position)
		else:
			bullet.global_rotation = pos.angle()
		
		# Sets variables of the new bullets
		bullet.global_position = global_position + pos
		
		if !bullet.is_in_group("static"):
			bullet.speed = bullet_speed
		
		# Matryoshka bullet's children are now officially born
		main.add_child(bullet)
	
	# Matryoshka bullet is now officially dead
	queue_free()


func _on_MatryoshkaBullet_area_entered(area):
	if area.is_in_group("player"):
		queue_free()
