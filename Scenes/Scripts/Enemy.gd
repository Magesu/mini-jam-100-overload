extends KinematicBody2D

onready var main = get_tree().root.get_node("Main")
onready var player = main.get_node("Player")

export var rot_speed = 100
export var timer_delay = 6
export var spawnpoint_count = 3
export var radius = 100

onready var shoot_timer = $Shoot_Timer
onready var rotator = $Rotator

var bullet_scene= preload("res://Scenes/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(spawnpoint_count):
		var spawnpoint = Position2D.new()
		var pos = Vector2(radius, 0).rotated((i-1)*(PI/9))
		spawnpoint.position = pos
		spawnpoint.rotation = ((i-1)*(PI/9))
		rotator.add_child(spawnpoint)
	
	shoot_timer.wait_time = timer_delay
	shoot_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	rotator.rotation = position.angle_to_point(player.position)+PI



func _on_Shoot_Timer_timeout():
	for child in rotator.get_children():
		var bullet = bullet_scene.instance()
		bullet.position = child.global_position
		bullet.rotation = child.global_rotation
		get_tree().get_root().add_child(bullet)
