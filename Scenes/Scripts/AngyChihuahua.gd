extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var lifespan = get_node("Lifespan")

onready var shooter2 = get_node("Shooter2")
onready var barkwave_duration = get_node("BarkwaveDuration")
onready var time_between_barkwaves = get_node("TimeBetweenBarkwaves")

onready var game = get_tree().root.get_node("Game")

# Scenes
var new_chihuahua_scene = preload("res://Scenes/ExplodingChihuahua.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()
	barkwave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func barkwave():
	barkwave_duration.start()
	
	shooter2.shoot_angle = 360
	shooter2.rotate_speed = 100
	shooter2.shoot_timer_wait_time = 0.2
	shooter2.spawnpoint_count = 12
	shooter2.radius = 50
	shooter2.bullet_speed = 100
	shooter2.bullet_speed_variation = 0
	shooter2.turns = false
	shooter2.target_player = false
	shooter2.bullet_scene = preload("res://Scenes/Bullet.tscn")
	
	shooter2.update()

func _on_BarkwaveDuration_timeout():
	stop()
	time_between_barkwaves.start()

func _on_TimeBetweenBarkwaves_timeout():
	barkwave()

func stop():
	shooter2.spawnpoint_count = 0
	
	shooter2.update()

func die():
	var new_chihuahua = new_chihuahua_scene.instance()
	new_chihuahua.global_position = global_position
	game.add_child(new_chihuahua)
	queue_free()

func _on_Lifespan_timeout():
	die()
