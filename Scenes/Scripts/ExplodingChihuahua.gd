extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var enemy_controller = get_node("EnemyController")

# Called when the node enters the scene tree for the first time.
func _ready():
	charge()
	yield(get_tree().create_timer(6.0), "timeout")
	stop()
	yield(get_tree().create_timer(9.0), "timeout")
	explode()
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func charge():
	enemy_controller.shoot_angle = 360
	enemy_controller.rotate_speed = 300
	enemy_controller.shoot_timer_wait_time = 0.5
	enemy_controller.spawnpoint_count = 8
	enemy_controller.radius = 700
	enemy_controller.bullet_speed = -100
	enemy_controller.bullet_speed_variation = 0.5
	enemy_controller.turns = false
	enemy_controller.target_player = false
	enemy_controller.bullet_scene = preload("res://Scenes/ChargingBullet.tscn")
	
	enemy_controller.update()

func explode():
	enemy_controller.shoot_angle = 360
	enemy_controller.rotate_speed = 100
	enemy_controller.shoot_timer_wait_time = 0.1
	enemy_controller.spawnpoint_count = 16
	enemy_controller.radius = 40
	enemy_controller.bullet_speed = 200
	enemy_controller.bullet_speed_variation = 0
	enemy_controller.turns = false
	enemy_controller.target_player = false
	enemy_controller.bullet_scene = preload("res://Scenes/Bullet.tscn")
	
	enemy_controller.update()

func stop():
	enemy_controller.spawnpoint_count = 0
	
	enemy_controller.update()
