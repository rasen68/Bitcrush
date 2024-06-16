extends Node

## Global##

#sensor
var sensor_AL = 0
var sensor_AD = 0
var sensor_AU = 0
var sensor_AR = 0
var fullscreen = true

var perfectMargin = [572.0, 592.0]
var deadCenter = (perfectMargin[0] + perfectMargin[1]) / 2.0
var greatMargin = [557.0, 607.0]
var okMargin = [542.0, 622.0]
var hurtMargin = 623.0
var disappearMargin = 700.0
var noteSpeed = 300
var magicalDoubleMargin = 24.0

var keybinds = [KEY_D, KEY_F, KEY_J, KEY_K]
var inputEvent = null

var comboCounter = 0
