extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var game = get_tree().root.get_node("Game")

onready var lifespan = get_node("Lifespan")

# Scenes
var new_fluffy_scene = preload("res://Scenes/PeeingFluffy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	var new_fluffy = new_fluffy_scene.instance()
	new_fluffy.global_position = global_position
	game.add_child(new_fluffy)
	queue_free()

func _on_Lifespan_timeout():
	die()
