extends KinematicBody2D


export var rot_speed = 100
export var timer_delay = 5
export var spawnpoint_count = 6
export var radius = 100

onready var shoot_timer = $Shoot_Timer
onready var rotator = $Rotator

var bullet_scene= preload("res://Scenes/Bullett.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var step = (PI * 2) / spawnpoint_count
	for i in range(spawnpoint_count):
		var spawnpoint = Position2D.new()
		var pos = Vector2(radius, 0).rotated(i*step)
		spawnpoint.position = pos
		spawnpoint.rotation = pos.angle()
		rotator.add_child(spawnpoint)
	
	shoot_timer.wait_time = timer_delay
	shoot_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_Shoot_Timer_timeout():
	for child in rotator.get_children():
		var bullet = bullet_scene.instance()
		bullet.position = child.global_position
		bullet.rotation = child.global_rotation
		get_tree().get_root().add_child(bullet)
