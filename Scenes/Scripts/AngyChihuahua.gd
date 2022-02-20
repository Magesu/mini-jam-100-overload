extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var lifespan = get_node("Lifespan")

# Scenes
var new_chihuahua_scene = preload("res://Scenes/ExplodingChihuahua.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func die():
	var new_chihuahua = new_chihuahua_scene.instance()
	new_chihuahua.global_position = global_position
	get_parent().add_child(new_chihuahua)
	queue_free()

func _on_Lifespan_timeout():
	die()
