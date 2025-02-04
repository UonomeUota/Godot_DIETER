# 敵
extends Area2D

@export var damage = 10

func _ready():
	# 初期設定
	pass

# 衝突時の処理
func _on_player_collide(body):
	if body.is_in_group("player"):
		body.health -= damage  # プレイヤーにダメージ
		print("Enemy hit player!")
