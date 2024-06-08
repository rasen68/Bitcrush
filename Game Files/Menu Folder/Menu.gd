extends Control

var keysDict = {
		"NOTHING": [0, 0],
		KEY_8: [1, 1],
		KEY_Y: [2, 0],
		KEY_2: [3, 3],
		KEY_3: [4, 0],
		KEY_5: [5, 2],
		KEY_4: [6, 1],
		KEY_6: [7, 3],
		KEY_7: [8, 0],
		KEY_0: [9, 3],
		KEY_9: [10, 2],
		KEY_A: [11, 0],
		KEY_SEMICOLON: [12, 1],
		KEY_PLUS: [13, 2],
		KEY_C: [14, 2],
		KEY_BACKSLASH: [15, 3],
		KEY_BACKSPACE: [16, 3],
		KEY_BRACKETLEFT: [17, 1],
		KEY_TAB: [18, 0],
		KEY_B: [19, 1],
		KEY_CAPSLOCK: [20, 0],
		KEY_PERIOD: [21, 2],
		KEY_D: [22, 0],
		KEY_DOWN: [23, 3],
		KEY_E: [24, 3],
		KEY_ENTER: [25, 3],
		KEY_QUOTELEFT: [26, 0],
		KEY_J: [27, 2],
		KEY_L: [28, 3],
		KEY_I: [29, 2],
		KEY_H: [30, 1],
		KEY_F: [31, 1],
		KEY_K: [32, 3],
		KEY_G: [33, 0],
		KEY_UP: [34, 2],
		KEY_O: [35, 2],
		KEY_MINUS: [36, 1],
		KEY_N: [37, 1],
		KEY_M: [38, 0],
		KEY_P: [39, 3],
		KEY_COMMA: [40, 1],
		KEY_ASTERISK: [41, 1],
		KEY_S: [42, 2],
		KEY_EQUAL: [43, 2],
		KEY_R: [44, 1],
		KEY_RIGHT: [45, 0],
		KEY_Q: [46, 0],
		KEY_APOSTROPHE: [47, 2],
		KEY_SHIFT: [48, 0],
		KEY_SLASH: [49, 3],
		KEY_SPACE: [50, 0],
		KEY_T: [51, 3],
		KEY_BRACKETRIGHT: [52, 2],
		KEY_W: [53, 2],
		KEY_LEFT: [54, 1],
		KEY_V: [55, 1],
		KEY_U: [56, 0],
		KEY_X: [57, 3],
		KEY_1: [58, 2],
		KEY_Z: [59, 1],
		"HIGHLIGHT": [60, 0],
		"INVALID": [61, 3]
}

var audioIndexes = [0, 0, 0, 0]
var buttons_on = false
var credits_open = false
var thanks_open = false
var options_open = false
var menu_close = true
var fullscreen_on = true
var mouse_in_quit = false
var mouse_in_options = false
var mouse_in_credits = false
var mouse_in_play = false
var mouse_in_keybind = false
var credits_into_options = false
var everything_off = false
var selected_keybind = [null, 0]

func _ready():
	$LoGoZone.show()
	$LogoAnimation.hide()
	$MenuMusic.play()
	$Options.hide()
	$Credits.hide()
	
	audioIndexes[0] = AudioServer.get_bus_index("Master")
	audioIndexes[1] = AudioServer.get_bus_index("SFX")
	audioIndexes[2] = AudioServer.get_bus_index("BGM")
	audioIndexes[3] = AudioServer.get_bus_index("Battle")
	
	$Options/keybind1/AnimatedSprite2D.frame = keysDict[KEY_D][0]
	$Options/keybind2/AnimatedSprite2D.frame = keysDict[KEY_F][0]
	$Options/keybind2/AnimatedSprite2D.position.x = -100
	$Options/keybind3/AnimatedSprite2D.frame = keysDict[KEY_J][0]
	$Options/keybind3/AnimatedSprite2D.position.x = -200
	$Options/keybind4/AnimatedSprite2D.frame = keysDict[KEY_K][0]
	$Options/keybind4/AnimatedSprite2D.position.x = -300
	
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_options_mouse_entered():
	mouse_in_options = true
	if buttons_on and not everything_off:
		$Menu2/Area2D3/optionsHover.show()
	if credits_open or thanks_open:
		credits_into_options = true

func _on_credits_mouse_entered():
	mouse_in_credits = true
	if buttons_on and not everything_off:
		$Menu2/Area2D4/creditsHover.show()

func _on_play_mouse_entered():
	mouse_in_play = true
	if buttons_on and not everything_off:
		$Menu2/Area2D2/playHover.show()

func _on_quit_mouse_entered():
	mouse_in_quit = true
	if buttons_on and not everything_off:
		$Menu2/Area2D/quitHover.show()

func _on_options_mouse_exited():
	mouse_in_options = false
	credits_into_options = false
	$Menu2/Area2D3/optionsHover.hide()
	
func _on_credits_mouse_exited():
	mouse_in_credits = false
	$Menu2/Area2D4/creditsHover.hide()

func _on_play_mouse_exited():
	mouse_in_play = false
	$Menu2/Area2D2/playHover.hide()

func _on_quit_mouse_exited():
	mouse_in_quit = false
	$Menu2/Area2D/quitHover.hide()

func _on_options_input_event(viewport, event, shape_idx):
	if buttons_on and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not credits_into_options:
			$Options.show()
			$Credits.hide()
			options_open = true
			buttons_on = false
			menu_close = false
			$boop.play()

func _on_credits_input_event(viewport, event, shape_idx):
	if buttons_on and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Credits.show()
		$Options.hide()
		credits_open = true
		buttons_on = false
		menu_close = false
		$boop.play()

func _on_play_input_event(viewport, event, shape_idx):
	if buttons_on and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://Intro Folder/introduction.tscn")
		$boop.play()

func _on_quit_input_event(viewport, event, shape_idx):
	if buttons_on and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().quit()
		$boop.play()

func _on_logo_zone_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$LoGoZone.hide()
		$LogoAnimation.show()
		$LogoAnimation.play("default")
		$boop.play()

func _on_logo_animation_looped():
	$LogoAnimation.stop()
	$LogoAnimation.hide()
	if mouse_in_options:
		$Menu2/Area2D3/optionsHover.show()
	if mouse_in_credits:
		$Menu2/Area2D4/creditsHover.show()
	if mouse_in_play:
		$Menu2/Area2D2/playHover.show()
	if mouse_in_quit:
		$Menu2/Area2D/quitHover.show()
	buttons_on = true
	$Options.hide()

func _on_thanks_mouse_entered():
	if credits_open:
		$Credits/Area2D/thanksHover.show()

func _on_thanks_mouse_exited():
	$Credits/Area2D/thanksHover.hide()

func _on_thanks_input_event(viewport, event, shape_idx):
	if credits_open and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		credits_open = false
		thanks_open = true
		menu_close = false
		$Credits.hide()
		$SpecialThanks.show()
		$boop.play()

func _on_devs_mouse_entered():
	if thanks_open:
		$SpecialThanks/Area2D/devsHover.show()

func _on_devs_mouse_exited():
	$SpecialThanks/Area2D/devsHover.hide()

func _on_devs_input_event(viewport, event, shape_idx):
	if thanks_open and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		credits_open = true
		thanks_open = false
		menu_close = false
		$Credits.show()
		$SpecialThanks.hide()
		$boop.play()

func _on_menu_background_2_input_event(viewport, event, shape_idx):
	if menu_close and not everything_off and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$Credits.hide()
		$SpecialThanks.hide()
		$Options.hide()
		buttons_on = true
		credits_open = false
		thanks_open = false
		$woop.play()
		if mouse_in_options:
			$Menu2/Area2D3/optionsHover.show()
		if mouse_in_quit:
			$Menu2/Area2D/quitHover.show()

func _on_credits_menu_mouse_entered():
	if credits_open:
		menu_close = false

func _on_credits_menu_mouse_exited():
	if credits_open:
		menu_close = true

func _on_special_thanks_mouse_entered():
	if thanks_open:
		menu_close = false

func _on_special_thanks_mouse_exited():
	if thanks_open:
		menu_close = true

func _on_options_menu_mouse_entered():
	if options_open:
		menu_close = false

func _on_options_menu_mouse_exited():
	if options_open:
		menu_close = true

func _on_fullscreen_button_mouse_entered():
	if options_open:
		if fullscreen_on:
			$Options/fullscreenButton/onHover.show()
		else:
			$Options/fullscreenButton/offHover.show()

func _on_fullscreen_button_mouse_exited():
	if options_open:
		if fullscreen_on:
			$Options/fullscreenButton/onHover.hide()
		else:
			$Options/fullscreenButton/offHover.hide()

func _on_fullscreen_button_input_event(viewport, event, shape_idx):
	if options_open and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if fullscreen_on:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			Global.fullscreen = false
			fullscreen_on = false
			$Options/fullscreenButton/onHover.hide()
			$Options/fullscreenButton/on.hide()
			$Options/fullscreenButton/offHover.show()
			$Options/fullscreenButton/off.show()
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Global.fullscreen = true
			fullscreen_on = true
			$Options/fullscreenButton/onHover.show()
			$Options/fullscreenButton/on.show()
			$Options/fullscreenButton/offHover.hide()
			$Options/fullscreenButton/off.hide()

# Adapted from https://www.youtube.com/watch?app=desktop&v=aFkRmtGiZCw
func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(audioIndexes[0], linear_to_db(value))

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(audioIndexes[1], linear_to_db(value))

func _on_bgm_slider_value_changed(value):
	AudioServer.set_bus_volume_db(audioIndexes[2], linear_to_db(value))

func _on_battle_slider_value_changed(value):
	AudioServer.set_bus_volume_db(audioIndexes[3], linear_to_db(value))

func _on_master_slider_drag_started():
	$boop.play()

func _on_master_slider_drag_ended(value_changed):
	$woop.play()

func _on_sfx_slider_drag_started():
	$boop.play()

func _on_sfx_slider_drag_ended(value_changed):
	$woop.play()

func _on_bgm_slider_drag_started():
	$boop.play()

func _on_bgm_slider_drag_ended(value_changed):
	$woop.play()

func _on_battle_slider_drag_started():
	$boop.play()

func _on_battle_slider_drag_ended(value_changed):
	$woop.play()

func _on_keybind_1_mouse_entered():
	mouse_in_keybind = true

func _on_keybind_1_mouse_exited():
	mouse_in_keybind = false

func _on_keybind_2_mouse_entered():
	mouse_in_keybind = true

func _on_keybind_2_mouse_exited():
	mouse_in_keybind = false

func _on_keybind_3_mouse_entered():
	mouse_in_keybind = true

func _on_keybind_3_mouse_exited():
	mouse_in_keybind = false

func _on_keybind_4_mouse_entered():
	mouse_in_keybind = true

func _on_keybind_4_mouse_exited():
	mouse_in_keybind = false

func _input(event):
	if everything_off:
		if not mouse_in_keybind and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			everything_off = false
			selected_keybind[0].frame = keysDict["NOTHING"][0]
			Global.keybinds[selected_keybind[1]] = null
		elif event is InputEventKey and event.pressed:
			everything_off = false
			if keysDict.has(event.keycode) and event.keycode not in Global.keybinds:
				selected_keybind[0].frame = keysDict[event.keycode][0]
				selected_keybind[0].position.x = keysDict[event.keycode][1] * -100
				Global.keybinds[selected_keybind[1]] = event.keycode
			else:
				selected_keybind[0].frame = keysDict["INVALID"][0]
				selected_keybind[0].position[0] = keysDict["INVALID"][1] * -100
				Global.keybinds[selected_keybind[1]] = null

func _on_keybind_1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected_keybind = [$Options/keybind1/AnimatedSprite2D, 0]
		selected_keybind[0].frame = keysDict["HIGHLIGHT"][0]
		selected_keybind[0].position.x = keysDict["HIGHLIGHT"][1] * -100
		everything_off = true

func _on_keybind_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected_keybind = [$Options/keybind2/AnimatedSprite2D, 1]
		selected_keybind[0].frame = keysDict["HIGHLIGHT"][0]
		selected_keybind[0].position.x = keysDict["HIGHLIGHT"][1] * -100
		everything_off = true

func _on_keybind_3_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected_keybind = [$Options/keybind3/AnimatedSprite2D, 2]
		selected_keybind[0].frame = keysDict["HIGHLIGHT"][0]
		selected_keybind[0].position.x = keysDict["HIGHLIGHT"][1] * -100
		everything_off = true

func _on_keybind_4_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected_keybind = [$Options/keybind4/AnimatedSprite2D, 3]
		selected_keybind[0].frame = keysDict["HIGHLIGHT"][0]
		selected_keybind[0].position.x = keysDict["HIGHLIGHT"][1] * -100
		everything_off = true

func _process(delta):
	var threads = [$Options/thread1, $Options/thread2, $Options/thread3, $Options/thread4]
	for i in range(4):
		if Global.keybinds[i] == null:
			threads[i].hide()
		else:
			threads[i].show()
	if Global.keybinds == [null, null, null, null]:
		$Options/masterThread.hide()
	else:
		$Options/masterThread.show()
