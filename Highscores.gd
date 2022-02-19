extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Button.grab_focus()
	
	#fills up the highscores with static stuff (possibly dev/tester highscores later)
	for i in range(0, 10):
		$CenterContainer/VBoxContainer.get_child(i).text = Global.scores[i].name + " ... " + str(Global.scores[i].score_number)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
