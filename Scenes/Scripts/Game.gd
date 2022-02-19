extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Nodes
onready var enemy = get_node("Enemy/EnemyController")
onready var debug_menu = get_node("CanvasLayer/Debug Menu")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Global.new_score("Your awesome name", $Score.score)
		get_tree().change_scene("res://Main.tscn")

# Debug box updating the game when values are changed
#func _on_RotateSpeedSpinBox_value_changed(value):
#	enemy.rotate_speed = value
#	enemy.update()
#
#func _on_TimerWaitTimeSpinBox_value_changed(value):
#	enemy.shoot_timer_wait_time = value
#	enemy.update()
#
#func _on_SpawnpointNumberSpinBox_value_changed(value):
#	enemy.spawnpoint_count = value
#	enemy.update()
#
#func _on_RadiusSpinBox_value_changed(value):
#	enemy.radius = value
#	enemy.update()
#
#func _on_BulletSpeedSpinBox_value_changed(value):
#	enemy.bullet_speed = value
#	enemy.update()
#
#func _on_TurnsCheckButton_toggled(button_pressed):
#	enemy.turns = button_pressed
#	enemy.update()
#
#func _on_TurnTimerWaitTime_value_changed(value):
#	enemy.turn_timer_wait_time = value
#	enemy.update()
