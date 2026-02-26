#MaxThreadsPerHotkey, 2
#Include logFile.ahk 
Process, Priority, , High
SetBatchLines, 10
ListLines, Off
SendMode, Event
SetKeyDelay, 10, 10
SetDefaultMouseSpeed, 10
CoordMode, Pixel, Window  
CoordMode, Mouse, Window  
CoordMode, ToolTip, Screen 

/*
	resolucion 1920x1080
*/

iniLog()
cuadradosId := []
coleccion := []
;r1 := playBtnRegion
;r2 := crearRegion(728, 121, 857, 291) ;level up tabern?
;r3 := crearRegion(376, 319, 1467, 492) ;Center enemy cards?
;r4 := crearRegion(563, 920, 1240, 1074) ;Own hand?
;r5 := crearRegion(1210, 964, 1654, 1037) ;money?
;r6 := crearRegion(387, 517, 1513, 696) ;Center own cards?
;r7 := turnsLayoutRegion
;r8 := crearRegion(949, 630, 1090, 681) ;??

;turnsLayoutRegion := crearRegion(1501, 5, 1607, 70)
battleGroundsBtnRegion := crearRegion(756, 373, 1161, 441)
playBtnRegion := crearRegion(1350, 750, 1550, 968)

chooseHeroTitleRegion := crearRegion(673, 98, 1224, 230)
chosesHero1Region := crearRegion(367, 357, 665, 674)
chosesHero2Region := crearRegion(686, 361, 965, 667)
chosesHero3Region := crearRegion(981, 366, 1257, 664)
chosesHero4Region := crearRegion(1277, 371, 1550, 668)
confirmBtnRegion := crearRegion(866, 815, 1063, 901)
leftBar := crearRegion(220, 110, 362, 947)
greenDeadRegion := crearRegion(563, 920, 1240, 1074)
errorNotificacionRegion := crearRegion(575, 423, 1328, 648)
errorNotificacionBtnRegion := crearRegion(903, 631, 1003, 669)
deathScreenPurpleRegion := crearRegion(810, 710, 904, 765)
;deathScreenPurpleRegion := crearRegion(810, 510, 904, 565)

coleccion.push(battleGroundsBtnRegion)
coleccion.push(playBtnRegion)
coleccion.push(chooseHeroTitleRegion)
coleccion.push(chosesHero1Region)
coleccion.push(chosesHero2Region)
coleccion.push(chosesHero3Region)
coleccion.push(chosesHero4Region)
coleccion.push(confirmBtnRegion)
coleccion.push(leftBar)
coleccion.push(greenDeadRegion)
coleccion.push(errorNotificacionRegion)
coleccion.push(errorNotificacionBtnRegion)
coleccion.push(deathScreenPurpleRegion)

gameCount := 0

return

2::
	Tooltip, % "detectaGreeDead2() = " detectaGreeDead2()
return



^1::
	if(toggleScript:=!toggleScript){

		showDebugMsg("HS - Play & Dead On")

		seguir := aguardabattleGroundsBtn()
		if (!seguir){
			showUserMsg("Lobby BattleGrounds Button> timeLimit exceeded")
			return
		}
		
		randomSleep(200, 300)
		clickRegion(battleGroundsBtnRegion, 30)
		setTimer, playDead, 2000
		setTimer, countGame, 1000
	
	}else{


		setTimer, playDead, Off
		setTimer, countGame, Off
		showDebugMsg("HS - Play & Dead will Off after one execution")
		registra("-", 1)
		
	}

return


^f12::
	if(ctrlf12:=!ctrlf12){

		winHwnd := WinExist("A")
		cuadradosId := mostrarColeccionCuadrados(winHwnd, coleccion)

	}else{

		ocultarColeccionCuadrados(cuadradosId)

	}
return


playDead(){
	Global

	registra("Starting new game")
	gameCount++
	seguir := aguardaPlayBtn(600000)
	if (!seguir){
		
		if (!hayError()){
			setTimer, playDead, Off
			showUserMsg("Play Button > timeLimit exceeded")
			
			return
		}
		
		err := atenderErrorReiniciar()

		if (err = 0){
			setTimer, playDead, 2000
			return
		}

		if (err = 1) {
			setTimer, playDead, Off
			showUserMsg("Play Button or Lobby BattleGrounds Button > Time limit exceeded")
			
			return
		}

		if (err = 2) {
			setTimer, playDead, Off
			showUserMsg("Lobby Error Notification > timeLimit exceeded")
			
			return
		}
	
	}
	showDebugMsg("Play btn ready")


	randomSleep(100, 300)
	clickRegion(playBtnRegion, 60)

	
	seguir := aguardaChooseHeroInterface(600000)
	if (!seguir){

		if (!hayError()){
			setTimer, playDead, Off
			showUserMsg("Choose a Hero Interface > timeLimit exceeded")
			
			return
		}

		err := atenderErrorReiniciar()

		if (err = 0){
			setTimer, playDead, 2000
			return
		}

		if (err = 1) {
			setTimer, playDead, Off
			showUserMsg("Play Button or Lobby BattleGrounds Button > Time limit exceeded")
			
			return
		}

		if (err = 2) {
			setTimer, playDead, Off
			showUserMsg("Lobby Error Notification > timeLimit exceeded")
			
			return
		}

	}
	showDebugMsg("Choose a hero interface ready")
	

	randomSleep(100, 300)
	moveToRegion(chooseHeroTitleRegion)
	randomSleep(200, 600)
	

	choosenHeroRegion := seleccionaHeroeEntre(2, 3)
	if (choosenHeroRegion = -1){
		setTimer, playDead, Off
		showDebugMsg("choosenHeroRegion > -1")
		return
	}
	clickRegion(choosenHeroRegion, 90)
	randomSleep(100, 400)
	clickRegion(confirmBtnRegion, 30)
	showDebugMsg("Waiting Cards Battle Ground")


	seguir := aguardaTablero(360000)
	if (!seguir){

		if (!hayError()){
			setTimer, playDead, Off
			showUserMsg("Waiting Cards BattleGround > timeLimit exceeded")
			
			return
		}
		
		err := atenderErrorReiniciar()

		if (err = 0){
			setTimer, playDead, 2000
			return
		}

		if (err = 1) {
			setTimer, playDead, Off
			showUserMsg("Play Button or Lobby BattleGrounds Button > Time limit exceeded")
			
			return
		}

		if (err = 2) {
			setTimer, playDead, Off
			showUserMsg("Lobby Error Notification > timeLimit exceeded")
			
			return
		}

	}
	showDebugMsg("Cards Battle Ground interface ready")
	
	
	Sleep, 5000
	
	
	showDebugMsg("Waiting dead...")
	err := aguardaGreenDead(1500000)
	
	if (err = 1){
		setTimer, playDead, Off
		showUserMsg("Waiting Dead > timeLimit exceeded")
		
		return
	}

	if (err = 2){	

		err := atenderErrorReiniciar()
		
		if (err = 0){
			setTimer, playDead, 2000
			return
		}

		if (err = 1){
			setTimer, playDead, Off
			showUserMsg("Play Button or Lobby BattleGrounds Button > Time limit exceeded")
			
			return
		}

		if (err = 2){
			setTimer, playDead, Off
			showUserMsg("Lobby Error Notification > timeLimit exceeded")
			
			return
		}

	}

	showDebugMsg("Death detected")
	randomSleep(5000, 7000)
	clickRegion(confirmBtnRegion, 30)
	clickRegion(confirmBtnRegion, 30)
	err := aguardaDeadScreenOff(600000)
	if (err = 0){
		registra("GAME END!")

		return
	}
	
	if (err = 1){
		setTimer, playDead, Off
		showUserMsg("Resolving Dead Screen> timeLimit exceeded")
		
		return

	}
	
	if (err = 2){	

		err := atenderErrorReiniciar()
		
		if (err = 0){
			setTimer, playDead, 2000
			return
		}

		if (err = 1){
			setTimer, playDead, Off
			showUserMsg("Play Button or Lobby BattleGrounds Button > Time limit exceeded")
			
			return
		}

		if (err = 2){
			setTimer, playDead, Off
			showUserMsg("Lobby Error Notification > timeLimit exceeded")
			
			return
		}

	}
	
}



detectaTablero(){

	Global leftBar


	static color1 := 0x1719FF ;(Red=FF Green=19 Blue=17)
	static color2 := 0x3D33D7 ;(Red=D7 Green=33 Blue=3D)
	static color3 := 0x2D31AE ;(Red=AE Green=31 Blue=2D)
	static color4 := 0xFFFFFF ;(Red=FF Green=FF Blue=FF)

	static coleccion := [color1, color2, color3, color4]

	return buscaPixelesRegion(leftBar, coleccion, 2)


}


detectaGreeDead(){

	Global greenDeadRegion
	static greenDeadColor :=  0x00FF53  ;(Red=53 Green=FF Blue=00)

	PixelSearch, fx, fy, greenDeadRegion.x1, greenDeadRegion.y1, greenDeadRegion.x2, greenDeadRegion.y2, greenDeadColor, , fast
	if(ErrorLevel){
		return false
	}

	return true
}

detectaGreeDead2(){

	Global deathScreenPurpleRegion
	region :=  deathScreenPurpleRegion

	ImageSearch, fx, fy, region.x1, region.y1, region.x2, region.y2, *32 resources/deathScreenPurple.jpg
	if(ErrorLevel){
		return false
	}

	return true

}




aguardaGreenDead(timeLimit:=2000000){
	
	startTime := A_TickCount 
	loop{

		if (detectaGreeDead2()){

			return 0
		
		}else{
			
			elapsedTime  := (A_TickCount - startTime)
			
			if (elapsedTime  >= timeLimit){
				return 1 
			}
			
			if (hayError()){
				return 2
			}

		}

		Sleep, 10000

	}

}


aguardaDeadScreenOff(timeLimit:=60000){
	
	startTime := A_TickCount 
	loop{

		Sleep, 3000
		
		if (!detectaGreeDead2()){

			return 0
		
		}else{
			
			elapsedTime  := (A_TickCount - startTime)
			
			if (elapsedTime  >= timeLimit){
				return 1 
			}
			
			if (hayError()){
				return 2
			}

			click
			randomSleep(80, 90)

		}

		
	}

}



aguardaTablero(timeLimit:=120000){

	startTime := A_TickCount 
	loop{

		if (detectaTablero()){

			return true
		
		}else{
			
			elapsedTime  := (A_TickCount - startTime)
			if (elapsedTime  >= timeLimit){
				return false 
			}
		}

	}

}

seleccionaHeroeEntre(min:=2, max:=4){

	Global chosesHero1Region, chosesHero2Region, chosesHero3Region, chosesHero4Region

	Random, choosenHero, min, max
	Switch (choosenHero)
	{
	Case 1:
	    return chosesHero1Region
	Case 2:
	    return chosesHero2Region
	Case 3:
	    return chosesHero3Region
	Case 4:
	    return chosesHero4Region
	Default:
	    return -1
	}

}


detectaChooseHeroInterface(){

	Global chooseHeroTitleRegion

	static color1 := 0xE9E8E8 ;(Red=E8 Green=E8 Blue=E9)
	static color2 := 0x5095C6 ;(Red=C6 Green=95 Blue=50)

	static coleccion := [color1, color2]

	return buscaPixelesRegion(chooseHeroTitleRegion, coleccion, 2)

}


aguardaChooseHeroInterface(timeLimit:=70000){

	startTime := A_TickCount 
	loop{

		if (detectaChooseHeroInterface()){

			return true
		
		}else{
			
			elapsedTime  := (A_TickCount - startTime)
			if (elapsedTime  >= timeLimit){
				return false 
			}
		}

	}

}


detectaBattleGroundsBtn(){

	Global battleGroundsBtnRegion

	static colorInactivo1 := 0x7D84A1 ;(Red=A1 Green=84 Blue=7D)
	static colorInactivo2 := 0x1F354C ; (Red=4C Green=35 Blue=1F)
	static colorInactivo3 := 0x345C89 ; (Red=89 Green=5C Blue=34)
	static colorInactivo4 := 0x85C0DD ; (Red=DD Green=C0 Blue=85)

	static colorActivo1 := 0xC6F7FE ; (Red=FE Green=F7 Blue=C6)
	static colorActivo2 := 0x072743 ; (Red=43 Green=27 Blue=07)
	static colorActivo3 := 0x1F384C ; (Red=4C Green=38 Blue=1F)
	static colorActivo4 := 0x3973AA ; (Red=AA Green=73 Blue=39)


	static coleccionInactivo := [colorInactivo1, colorInactivo2, colorInactivo3, colorInactivo4]
	static coleccionActivo := [colorActivo1, colorActivo2, colorActivo3, colorActivo4]

	if buscaPixelesRegion(battleGroundsBtnRegion, coleccionInactivo, 2){
		return true
	}

	if buscaPixelesRegion(battleGroundsBtnRegion, coleccionActivo, 2){
		return true
	}

	return false

}


aguardabattleGroundsBtn(timeLimit:=5000){

	startTime := A_TickCount 
	loop{

		if (detectaBattleGroundsBtn()){

			return true
		
		}else{
			
			elapsedTime  := (A_TickCount - startTime)
			if (elapsedTime  >= timeLimit){
				return false 
			}
		}

	}

}


detectaBtnPlay(){

	Global playBtnRegion
	static color1 := 0xFFFF6A ;(Red=6A Green=FF Blue=FF)
	static color2 := 0xFF7C27 ;(Red=27 Green=7C Blue=FF)
	static color3 := 0x212221 ;(Red=21 Green=22 Blue=21)
	static color4 := 0xED6837 ;(Red=37 Green=68 Blue=ED)

	coleccion := [color1, color2, color3, color4]

	return buscaPixelesRegion(playBtnRegion, coleccion, 2)

}


aguardaPlayBtn(timeLimit:=5000){


	startTime := A_TickCount 
	loop{

		if (detectaBtnPlay()){

			return true
		
		}else{
			
			timeSince := (A_TickCount - startTime)
			if (timeSince >= timeLimit){
				return false 
			}
		}

	}

}






hayError(){

	Global errorNotificacionRegion
	
	static color1 := 0x484C50 ;(Red=50 Green=4C Blue=48)
	static color2 := 0xFFFFFF ;(Red=FF Green=FF Blue=FF)
	static color3 := 0x000000 ;(Red=00 Green=00 Blue=00)
	;static color4 := 0x56D5ED ;(Red=ED Green=D5 Blue=56)
	static color5 := 0x34373C ;(Red=3C Green=37 Blue=34)
	;static color6 := 0x4AC1E6 ;(Red=E6 Green=C1 Blue=4A)
	coleccion := [color1, color2, color3, color5]

	static escluirColor1 := 0x0EF90D ; ;verde  (Red=0D Green=F9 Blue=0E)
	static escluirColor2 := 0x2A22AA ; rojo sandre

	escluye := [escluirColor1, escluirColor2]
	if (buscaPixelesRegion(errorNotificacionRegion, coleccion, 0)){
		
		loop, % escluye.Length() {
			
			if(pixelSearchDesdeArribaIzquierda(errorNotificacionRegion, escluye[A_Index], 16)){
				return false
			}
		}

		showDebugMsg("Error detected")
		CaptureScreen(1, 1, "img\" . A_Now . ".jpg")
		return true

	}else{

		return false
	}

}

atenderErrorReiniciar(timeLimit:=300000){

	Global errorNotificacionBtnRegion

	clickRegion(errorNotificacionBtnRegion, 5)

	startTime := A_TickCount
	loop{

		Sleep, 20000

		if (!hayError()){

			break
		
		}else{
			
			timeSince := (A_TickCount - startTime)

			if (timeSince >= timeLimit){
				return 2 
			}

			clickRegion(errorNotificacionBtnRegion, 5)
		
		}

	}


	seguir := aguardabattleGroundsBtn(180000)
	if (seguir){
		randomSleep(100, 300)
		clickRegion(battleGroundsBtnRegion, 30)
		return 0
	}


	seguir := aguardaPlayBtn(360000)
	if (seguir){
		randomSleep(100, 300)
		clickRegion(playBtnRegion, 60)
		return 0
	}
	
	return 1 ;error

}




;#############################################################

pixelSearchDesdeArribaIzquierda(region, colorID, variacion:=0){
	
	PixelSearch, fx, fy, region.x1, region.y1, region.x2, region.y2, colorID, variacion, fast
	if(ErrorLevel){

		return false
	}

	return {"x":fx, "y":fy}
}

buscaPixelesRegion(region, coleccionPixeles, variacion := 0){

	loop, % coleccionPixeles.Length(){
		
		PixelSearch, fx, fy, region.x1, region.y1, region.x2, region.y2, coleccionPixeles[A_Index], variacion, fast
		if (ErrorLevel){
			return false
		}

	}

	return true	

}


crearRegion(x1, y1, x2, y2){

	if (x1<0 or y1<0 or x2<0 or y2<0){
		return -1
	}

	if(x2 < x1){
		temp := x1
		x1 := x2
		x2 := temp
	}

	if(y2 < y1){
		temp := y1
		y1 := y2
		y2 := temp
	}

	return {"x1":x1, "y1":y1, "x2":x2, "y2":y2}

}


clickRegion(region:=0, inset:=0){

	if (!region.x1 or !region.y1 or !region.x2 or !region.y2){
		return -1 
	}


	Random, rx, region.x1 + inset, region.x2 - inset
	Random, ry, region.y1 + inset, region.y2 - inset
	MouseMove, rx, ry
	randomSleep(80, 120) 

	Click
	randomSleep(30, 80) 
}


moveToRegion(region:=0, inset:=0){

	if (!region.x1 or !region.y1 or !region.x2 or !region.y2){
		return -1 ;invalid input
	}


	Random, rx, region.x1+inset, region.x2-inset
	Random, ry, region.y1+inset, region.y2-inset
	MouseMove, rx, ry
	randomSleep(80, 120) 

}


makeSquare(cc:="E0E0E0") {
	
	Gui, New, +HwndhwndSquare +AlwaysOnTop -Caption +ToolWindow +E0x08000000 +E0x00000020
	Gui, Color, %cc%
	return hwndSquare

}


drawSquare(parentId:=0, hwndSquare:=0, x1:=0, y1:=0, x2:=0, y2:=0, T:=3){
    
    if (!hwndSquare or x1<0 or y1<0 or x2<0 or y2<0)
        return -1
    if (parentId != 0){
        win := WinExist("ahk_id " parentId)
        if !win
            return -1
        WinGetPos, wx, wy, _, _, ahk_id %win%
        x1+=wx
        y1+=wy
        x2+=wx
        y2+=wy

    }

    W := x2 - x1
    H := y2 - y1
    w2:=W-T
    h2:=H-T
    Gui, %hwndSquare%: +LastFound 
    Gui, %hwndSquare%: Show, w%W% h%H% x%x1% y%y1% NA
    WinSet, Transparent, 255
    WinSet, Region, 0-0 %W%-0 %W%-%H% 0-%H% 0-0 %T%-%T% %w2%-%T% %w2%-%h2% %T%-%h2% %T%-%T%


}

hideSquare(hwndSquare){

	if (!hwndSquare)
		return

	Gui, %hwndSquare%:Hide

}

randomSleep(min:=30, max:=1000){
    Random, rt, min, max
    Sleep, rt
}

mostrarColeccionCuadrados(winHwnd, coleccion){
	
		if (!WinExist("ahk_id " winHwnd)){
			return -1
		}
		ids := []
		loop, % coleccion.Count(){

			ids[A_Index] := makeSquare()
			r := drawSquare(winHwnd, ids[A_Index], coleccion[A_Index].x1, coleccion[A_Index].y1, coleccion[A_Index].x2, coleccion[A_Index].y2)
		}

		return ids
	
}


ocultarColeccionCuadrados(ids){

	loop, % ids.Count(){

		hideSquare(ids[A_Index]) 
	
	}
			
}

showDebugMsg(msg:=""){
	
	Tooltip, % msg
	setTimer, quitarTooltip, -2000
	registra(msg)
	return

	quitarTooltip:
		Tooltip
	return

}

showUserMsg(msg){

	static toolX := A_ScreenWidth//2
	static toolY := A_ScreenHeight//2

	Tooltip, %msg%, toolX, toolY

	registra(msg)
	registra("-", 1)
	CaptureScreen(1, 1, "img\" . A_Now . ".jpg")
}

countGame(){

	Global gameCount
	static tTnicio := 0
	
	if(!tTnicio){
		tTnicio := A_TickCount
	}

	elapsed := A_TickCount - tTnicio
	t := time(elapsed)

	Tooltip, time played: %t% - Game: %gameCount%, 200, 200, 7

}



time(tMilliseconds){

    static 1h := 1000*60*60
    static 1m := 1000*60
    static 1s := 1000

    h := tMilliseconds//1h      
    rest := Mod(tMilliseconds, 1h) 

    m := rest//1m
    rest := Mod(rest, 1m)

    s := rest//1s
    rest := Mod(rest, 1s)

    ;rest have ms left

    h := addZero(h)
    m := addZero(m)
    s := addZero(s)

    return h ":" . m . ":" s

}

addZero(t){
	if t<10
		return "0" . t
	return t
}	
