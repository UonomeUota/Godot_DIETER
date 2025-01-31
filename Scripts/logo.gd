extends RigidBody2D

@onready var start_screen = $".."  # StartScreen ノードを取得

func _ready():
	# 2秒後に PressText を表示
	await get_tree().create_timer(1.0).timeout
	start_screen.show_press_text()
