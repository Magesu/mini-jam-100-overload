extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var game = get_tree().root.get_node("Game")
onready var shooter = get_node("Shooter")
onready var lifespan = get_node("Lifespan")

# Scenes
var next_boss_scene = preload("res://Scenes/LowCorgi.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	lifespan.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func die():
	game.spawn_new_boss()
	queue_free()


func _on_Timer_timeout():
	die()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
