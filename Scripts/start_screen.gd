extends Control

@onready var press_text = $PressText  # PressText ノードを取得
var tween: Tween  # Tween を管理する変数

func _ready():
	press_text.visible = false  # 最初は非表示
	press_text.scale = Vector2(0, 0)  # 最初は小さくする

# ロゴが静止した後に PressText を表示する関数
func show_press_text():
	press_text.visible = true  # 表示
	tween = create_tween()

	# 最初にスケール 0 → 1.0 にする
	tween.tween_property(press_text, "scale", Vector2(1, 1), 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

	# 最初のアニメーション完了後に、ループアニメーションを開始
	await tween.finished
	animate_text_loop()

# 0.8倍 → 1.0倍 を繰り返すアニメーション
func animate_text_loop():
	while true:
		tween = create_tween()
		tween.tween_property(press_text, "scale", Vector2(0.8, 0.8), 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		await tween.finished

		tween = create_tween()
		tween.tween_property(press_text, "scale", Vector2(1, 1), 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
		await tween.finished

# スペースキーが押されたら次のシーンへ
func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		get_tree().change_scene_to_file("res://Level_Base/game.tscn")  # 次のシーンに遷移
