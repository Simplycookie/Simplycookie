extends Node2D

@export var Colims = int(0)
@export var Rows = int(0)
var loopcount = 0
var loadscene = preload("res://scenes/food.tscn")
var Colimscount = 0
var counter = 0
func _ready():
	while counter < Colims:
		Global.framechainRows.append([])
		Global.framechainRowsframe.append(0)
		Global.framechainIDRows.append(0)
		Global.currentchainRows.append(0)
		counter += 1
		Global.framechainRows[counter].append(0)
	print(Global.framechainColims)
	Global.ColimsAndRows[0] = Colims
	Global.ColimsAndRows[1] = Rows
	var foodcount = Colims*Rows
	Global.framecap = int(float(Colims*Rows/3)+0.5)
	print(Global.framecap)
	while Colimscount < Colims - 1:
		Global.toprowframe.append(0)
		Colimscount += 1
	while loopcount < foodcount:
		add_child(loadscene.instantiate())
		loopcount += 1
	add_child(preload("res://scenes/last_action.tscn").instantiate())
	print(Global.framechainRowsframe)
	print(Global.framechainRows)
	print(Global.framechainIDRows)
	print(Global.toprowframe)
	var evenierx = float(Colims)/2 - int(Colims/2)
	var eveniery = float(Rows)/2 - int(Rows/2)
	if evenierx == 0:
		evenierx = 1
	if eveniery == 0:
		eveniery = 1
	$Playerview.position.x = (100*(Colims/2 + float(1 / float(2 * evenierx))))
	$Playerview.position.y = (100*(Rows/2 + float(1 / float(2 * eveniery))))
	Global.checking = true
func _process(delta):
	$Playerview/score.text = str(Global.score)
	if Global.switched == true or Global.doublecheck == true:
		Global.switched = false
		Global.doublecheck = false
		Global.checking = true
		Global.destroying = false
		Global.framechainColim_row_check = 0
		Global.framechainColims.clear()
		Global.framechainColims.append(0)
		Global.framechainIDColims = 0
		Global.currentchainColims = 0
		Global.framechainRows.clear()
		Global.framechainRows.append(0)
		Global.framechainIDRows.clear()
		Global.framechainIDRows.append(0)
		Global.currentchainRows.clear()
		Global.currentchainRows.append(0)
		counter = 0
		while counter < Global.ColimsAndRows[0]:
			Global.framechainRows.append([])
			Global.framechainRowsframe.append(0)
			Global.framechainIDRows.append(0)
			Global.currentchainRows.append(0)
			counter += 1
			Global.framechainRows[counter].append(0)
		Global.multiply = 1
		counter = 0
		

