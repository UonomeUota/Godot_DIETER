extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D  # "AnimatedSprite2D" ノードを参照
@onready var player = $"../Player"  # プレイヤーノードを参照

var speed = 100  # 敵の移動速度
var detection_radius = 300  # プレイヤーを追尾する距離

# Called every frame.
func _process(delta):
	# プレイヤーと敵の距離を計算
	var direction_to_player = player.position - position
	var distance_to_player = direction_to_player.length()

	# プレイヤーが近くにいる場合に追尾
	if distance_to_player < detection_radius:
		direction_to_player = direction_to_player.normalized()  # プレイヤー方向に正規化

		# 速度を設定（方向 * 速度）
		velocity = direction_to_player * speed

		# 敵の向きに合わせてアニメーションを再生（必要に応じて）
		if direction_to_player.x > 0:
			sprite.flip_h = false  # 右向き
			sprite.play("walk_right")  # 右向きの歩くアニメーション
		elif direction_to_player.x < 0:
			sprite.flip_h = true  # 左向き
			sprite.play("walk_left")  # 左向きの歩くアニメーション
	else:
		# プレイヤーが近くにいない場合、静止アニメーションに切り替え
		velocity = Vector2.ZERO  # 動かないようにする
		sprite.play("idle")  # 静止アニメーション
