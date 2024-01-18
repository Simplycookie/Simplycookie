extends AnimatedSprite2D

const MouseSx = 4.5
const MouseSy = 4.5
var swap = false
var tempframe = 0
var idleSx = scale.x
var idleSy = scale.y
var foodid = [0,0]
var framechainidColims
var framechainidRows
var select = false
var select2 = false
var mouseP = get_global_mouse_position()
var mousepress = false
var y_axis = mouseP.y
var x_axis = mouseP.x
var directionx = 0
var directiony = 0
var adder = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	frame = randi_range(1,Global.framecap)
	## assign and Checks if the colims are breaching the limit if it does it resets colim and adds 1 to row 
	
	if Global.placementCR[0] > Global.ColimsAndRows[0]:
		Global.placementCR[0] = 1
		Global.placementCR[1] += 1
	if Global.placementCR[0] <= Global.ColimsAndRows[0]:
		position.x = (100 * (Global.placementCR[0]))
		position.y = (100 * (Global.placementCR[1]))
		Global.placementCR[0] += 1 
	
	Global.foodcount += 1
	foodid[0] = Global.placementCR[0] - 1
	foodid[1] = Global.placementCR[1]
	if foodid[1] == 1:
		Global.toprowframe[foodid[0] - 1] = frame
	print(foodid)
	
	
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and (select or Global.selected2 == foodid) and Global.selected == [0,0] and !mousepress:
		Global.selected = foodid
		print(Global.selected)
		scale.x = MouseSx + 1
		scale.y = MouseSy + 1
		mousepress = true
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Global.selected == foodid and !mousepress:
		mouseP = get_global_mouse_position()
		Global.selected = [0,0]
		#print(mouseP.x)
		#print(position.x)
		if !select or Global.selected2 == foodid:
			Global.selected2 = [0,0]
			if (mouseP.x - position.x) > 0:
				x_axis = (mouseP.x - position.x)
				directionx = 1
				#print("susx>")
			else:
				x_axis = -(mouseP.x - position.x)
				directionx = -1
				#print("susx<")
			
			if (mouseP.y - position.y) > 0:
				y_axis = (mouseP.y - position.y)
				directiony = -1
				#print("susy<")
			else:
				y_axis = -(mouseP.y - position.y)
				directiony = 1
				#print("susy>")
			#print(leftright)
			#print(updown)
			if x_axis > y_axis:
				Global.swapaxis = 1
				if directionx < 0:
					print("left")
					if foodid[0] - 1 <= 0:
						print("offzone")
						Global.swapselect = [0,0]
					else:
						Global.swapselect[0] = foodid[0] - 1
						Global.swapselect[1] = foodid[1]
						Global.swapframe1 = frame
						Global.selected = foodid
				else:
					print("right")
					if foodid[0] + 1 > Global.ColimsAndRows[0]:
						print("offzone")
						Global.swapselect = [0,0]
					else:
						Global.swapselect[0] = foodid[0] + 1
						Global.swapselect[1] = foodid[1]
						Global.swapframe1 = frame
						Global.selected = foodid
				#print(directionx,"x")
			else:
				Global.swapaxis = 0
				if directiony < 0:
					print("down")
					if foodid[1] + 1 > Global.ColimsAndRows[1]:
						print("offzone")
						Global.swapselect = [0,0]
					else:
						Global.swapselect[0] = foodid[0]
						Global.swapselect[1] = foodid[1] + 1
						Global.swapframe1 = frame
						Global.selected = foodid
						
				else:
					print("up")
					if foodid[1] - 1 <= 0:
						print("offzone")
						Global.swapselect = [0,0]
					else:
						Global.swapselect[0] = foodid[0]
						Global.swapselect[1] = foodid[1] - 1
						Global.swapframe1 = frame
						Global.selected = foodid
			Global.swapdirectionx = directionx
			Global.swapdirectiony = directiony
			print(Global.swapselect)
			print(Global.selected)
		
				#print(directiony,"y")
		scale.x = idleSx
		scale.y = idleSy
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		mousepress = false
func _on_mouse_detect_l_1_mouse_entered():
	
	scale.x = MouseSx
	scale.y = MouseSy
	if Global.selected == [0,0]:
		select = true
	


func _on_mouse_detect_mouse_exited():
	if !Global.selected == foodid:
		scale.x = idleSx
		scale.y = idleSy
	select = false
	Global.selected2 = [0,0]

func _process(delta):
	#swapping process
	if Global.swapframe1 > -1 or !swap:
		if Global.swapselect == foodid:
			Global.swapframe2 = frame
			frame = Global.swapframe1
			if Global.swapaxis:
				if Global.swapdirectionx < 0:
					$Animation.play("swappingright")
				else:
					$Animation.play("swappingleft")
			else:
				if Global.swapdirectiony < 0:
					$Animation.play("swappingup")
				else:
					$Animation.play("swappingdown")
			Global.swapdirectionx = 0
			Global.swapdirectiony = 0
			Global.selected2 = foodid
			if foodid[1] == 1:
				Global.toprowframe[foodid[0] - 1] = frame
				#print(Global.toprowframe)
		elif Global.selected == foodid and Global.swapframe2 > -1:
			frame = Global.swapframe2
			Global.swapframe1 = -1
			Global.swapframe2 = -1
			Global.selected = [0,0]
			Global.swapselect = [0,0]
			if x_axis > y_axis:
				if directionx < 0:
					$Animation.play("swappingleft")
				elif directionx > 0:
					$Animation.play("swappingright")
			else:
				if directiony < 0:
					$Animation.play("swappingdown")
				elif directiony > 0:
					$Animation.play("swappingup")
			directionx = 0
			directiony = 0
			if foodid[1] == 1:
				Global.toprowframe[foodid[0] - 1] = frame
				#print(Global.toprowframe)
	
	if Global.checking == true:
		#checking process\
		if foodid[1] < Global.framechainColim_row_check:
			Global.framechainColim_row_check = foodid[1]
		if foodid[1] > Global.framechainColim_row_check:
			Global.framechainColims.append(1)
			Global.currentchainColims = 1
			Global.framechainColim_row_check = foodid[1]
			Global.framechainColimframe = frame
			Global.framechainIDColims += 1
			framechainidColims = Global.framechainIDColims
		elif frame == Global.framechainColimframe:
			Global.currentchainColims += 1
			Global.framechainColims[Global.framechainIDColims] = Global.currentchainColims
			framechainidColims = Global.framechainIDColims
			if Global.framechainColims[Global.framechainIDColims] >= 3:
				Global.found = true
				
		else:
			Global.framechainIDColims += 1
			Global.framechainColimframe = frame
			Global.framechainColims.append(1)
			Global.currentchainColims = 1
			framechainidColims = Global.framechainIDColims
		#checking rows
		if frame == Global.framechainRowsframe[foodid[0]]:
			Global.currentchainRows[foodid[0]] += 1
			Global.framechainRows[foodid[0]][Global.framechainIDRows[foodid[0]]] = Global.currentchainRows[foodid[0]]
			framechainidRows = Global.framechainIDRows[foodid[0]]
			if Global.framechainRows[foodid[0]][Global.framechainIDRows[foodid[0]]] >= 3:
				Global.found = true
				print("found Rows")
				print("rows ",foodid[0],",", Global.framechainIDRows[foodid[0]] )
				print(framechainidRows)
		else:
			Global.framechainIDRows[foodid[0]] += 1
			Global.framechainRowsframe[foodid[0]] = frame
			Global.framechainRows[foodid[0]].append(1)
			Global.currentchainRows[foodid[0]] = 1
			framechainidRows = Global.framechainIDRows[foodid[0]]
	#destroying and placingtest
	if Global.destroying == true:
		if Global.framechainColims[framechainidColims] >= 3 or Global.framechainRows[foodid[0]][framechainidRows] >= 3:
			print(Global.framechainColims[framechainidColims])
			print(Global.framechainRows[foodid[0]][framechainidRows])
			Global.score += 10 * Global.multiply
			Global.multiply += 0.10
			frame = randi_range(1,Global.framecap)
		
func _on_animation_animation_finished(anim_name):
	if Global.checking == false:
		Global.switched = true
