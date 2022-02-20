extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var shooter = get_node("Shooter")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Sequence of moves
	stop()
	yield(get_tree().create_timer(3.0), "timeout")
	charge()
	yield(get_tree().create_timer(6.0), "timeout")
	stop()
	yield(get_tree().create_timer(9.0), "timeout")
	explode()
	yield(get_tree().create_timer(0.3), "timeout")
	call_deferred("queue_free")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Configuring the enemy controller to do the moves
func charge():
	shooter.shoot_angle = 360
	shooter.rotate_speed = 300
	shooter.shoot_timer_wait_time = 0.5
	shooter.spawnpoint_count = 8
	shooter.radius = 700
	shooter.bullet_speed = -100
	shooter.bullet_speed_variation = 0.5
	shooter.turns = false
	shooter.target_player = false
	shooter.bullet_scene = preload("res://Scenes/ChargingBullet.tscn")
	
	shooter.update()

func explode():
	shooter.shoot_angle = 360
	shooter.rotate_speed = 100
	shooter.shoot_timer_wait_time = 0.1
	shooter.spawnpoint_count = 16
	shooter.radius = 40
	shooter.bullet_speed = 300
	shooter.bullet_speed_variation = 0
	shooter.turns = false
	shooter.target_player = false
	shooter.bullet_scene = preload("res://Scenes/Bullet.tscn")
	
	shooter.update()

func stop():
	shooter.spawnpoint_count = 0
	
	shooter.update()
