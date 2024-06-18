extends CanvasLayer

var is_timer = true
var minutes = 10
var seconds = 0
var decimals = 0
var paused = true

var mode_label = 'TIMER'

func update_label():
	$mode_label.text = str(decimals)
	$time_label.text = '%02d:%02d'%[minutes, seconds]


func _on_botonmodo_pressed():
	if $Timer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0
		is_timer = !is_timer
		if is_timer == true: 
			mode_label = 'TIMER'
		else:
			mode_label = 'STOP'
	update_label()
	$mode_label.text = mode_label
		

func _on_botonstart_pressed():
	if $Timer.is_stopped():
		$Timer.start()
		$pan.text = 'Run'
	else:
		$Timer.stop()
		$pan.text = 'stop'

func update_stop_watch():
	decimals += 1
	if decimals >= 10:
		decimals = 0
		seconds += 1
	if seconds >= 60:
		seconds = 0
		minutes += 1
	if minutes >= 59:
		seconds = 59
		minutes += 59
		decimals = 9
		$pan.text = 'stopped'
		$Timer.stop()
	update_label()
		
func update_timer():
	decimals -= 1
	if decimals < 0:
		decimals = 9
		seconds -= 1
	if seconds < 0:
		seconds = 59
		minutes -= 1
	if minutes < 0 :
		minutes = 0
		seconds = 0
		decimals = 0
		$pan.text = 'Stopped'
		$Timer.stop()
	update_label()
	
func on_main_timer_timeout():
	if is_timer == false: 
		update_stop_watch()
	else:
		update_timer()
		
		
	
		


func _on_botonsec_pressed():
	if $Timer.is_stopped() and is_timer == true:
		seconds += 1
		if seconds > 59:
			seconds = 0
