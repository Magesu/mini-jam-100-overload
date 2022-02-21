extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Scenes
var new_corgi_scene = preload("res://Scenes/HighCorgi.tscn")

# Nodes
onready var game = get_tree().root.get_node("Game")
onready var lifespan = get_node("Lifespan")
onready var shooter = get_node("Shooter")
onready var shooter2 = get_node("Shooter2")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	stop()
	yield(get_tree().create_timer(6), "timeout")
	var new_corgi = new_corgi_scene.instance()
	new_corgi.global_position = global_position
	game.add_child(new_corgi)
	queue_free()

func _on_Lifespan_timeout():
	die()

func stop():
	shooter.spawnpoint_count = 0
	shooter2.spawnpoint_count = 0
	
	shooter.update()
	shooter2.update()
