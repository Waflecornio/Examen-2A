extends CanvasLayer

var is_timer = true

var minutos = 0
var seconds = 0
var decimals = 0

var mode_label = 'TIMER'

func update_label():
	$decimales.text = str(decimals)
	$Tiempo.text = '%02d:%02d'%[minutos,seconds]
	
func  update_stopwatch():
	decimals += 1
	if  decimals >= 10:
		decimals = 0
		seconds += 1
	if  seconds >= 60:
		seconds = 0
		minutos += 1
	if minutos >= 59:
		seconds = 59
		minutos = 59
		decimals = 0
		$estado.text = 'STOPPED'
		$Timer.stop()
	update_label()

func _on_bot_modo_pressed():
	if $Timer.is_stopped():
		minutos = 0
		seconds = 0
		decimals = 0
		is_timer = !is_timer
		if is_timer == true:
			mode_label = 'TIMER'
		else: 
			mode_label = 'STOPWATCH'
	update_label()
	$modo.text = mode_label

func _on_boton_inci_pressed():
	if $Timer.is_stopped():
		$Timer.start()
		$estado.text = 'running'
	else:
		$Timer.stop()
		$modo.text = 'STOPPED'
		
func update_timer():
	decimals -= 1
	if  decimals < 0:
		decimals = 9
		seconds -= 1
	if seconds < 0:
		minutos = 0
		seconds = 0
		decimals = 0
		$estado.text = 'STOPPED'
		$Timer.stop()
	update_label()
	

func _on_timer_timeout():
	if is_timer == false:
		update_stopwatch()
	else:
		update_timer()
		


func _on_bot_secs_pressed():
	if $Timer.is_stopped() and is_timer == true:
		seconds += 1
		if  seconds > 59:
			seconds = 0
		decimals = 0
		update_label()
		
		



func _on_bot_min_pressed():
	if $Timer.is_stopped() and is_timer == true:
		minutos += 1
		if minutos > 59:
			minutos = 0
		decimals = 0
		update_label()


func _on_clear_bot_pressed():
	if  $Timer.is_stopped():
		minutos = 0
		seconds = 0
		decimals = 0
		update_label()
