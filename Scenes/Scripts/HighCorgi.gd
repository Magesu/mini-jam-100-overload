extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var game = get_tree().root.get_node("Game")
onready var lifespan = get_node("Lifespan")

# Scenes

# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	game.spawn_new_boss()
	queue_free()

func _on_Lifespan_timeout():
	die()
