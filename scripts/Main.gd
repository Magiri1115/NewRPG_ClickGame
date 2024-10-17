# scripts/Main.gd
extends Node2D

var tako_instance: Node
var start_time: float
var is_game_over: bool = false

func _ready():
	tako_instance = $tako # takoシーンをインスタンス化したノード
	start_time = Time.get_ticks_msec()
	# gameoverLabel を最初は非表示に設定
	$CanvasLayer/gameoverLabel.visible = false

func _process(delta):
	if not is_game_over:
		var elapsed_time = (Time.get_ticks_msec() - start_time) / 1000.0
		$CanvasLayer/timeLabel.text = "%.2f 秒" % elapsed_time

#gameoverLabelの表示
func _on_tako_game_over():
	is_game_over = true
	var final_time = (Time.get_ticks_msec() - start_time) / 1000.0
	$CanvasLayer/gameoverLabel.visible = true
	
