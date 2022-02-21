extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/VBoxContainer/Start.grab_focus()
	
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Start_pressed():
	self.queue_free()
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Highscores_pressed():
	get_tree().change_scene("res://Scenes/Highscores.tscn")

func _on_Quit_pressed():
	get_tree().quit()
