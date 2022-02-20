extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	score += 1
	text = str(score)
	$Timer.start(1)
