extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var enemy_controller = get_node("EnemyController")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Configuring the enemy controller to do the moves
func shot1():
	enemy_controller.shoot_angle = 360
	enemy_controller.rotate_speed = 100
	enemy_controller.shoot_timer_wait_time = 0.2
	enemy_controller.spawnpoint_count = 4
	enemy_controller.radius = 40
	enemy_controller.bullet_speed = 100
	enemy_controller.bullet_speed_variation = 0
	enemy_controller.turns = false
	enemy_controller.target_player = false
	enemy_controller.bullet_scene = preload("res://Scenes/Bullet.tscn")
	
	enemy_controller.update()

func shot2():
	enemy_controller.shoot_angle = 360
	enemy_controller.rotate_speed = -100
	enemy_controller.shoot_timer_wait_time = 0.2
	enemy_controller.spawnpoint_count = 4
	enemy_controller.radius = 40
	enemy_controller.bullet_speed = 100
	enemy_controller.bullet_speed_variation = 0
	enemy_controller.turns = false
	enemy_controller.target_player = false
	enemy_controller.bullet_scene = preload("res://Scenes/Bullet.tscn")
	
	enemy_controller.update()

func stop():
	enemy_controller.spawnpoint_count = 0
	
	enemy_controller.update()
