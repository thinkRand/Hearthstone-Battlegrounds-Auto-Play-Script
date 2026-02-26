#Include screenCapture.ahk

iniLog(){
	
	if !(FileExist("log\"))
		FileCreateDir, log


	if !(FileExist("log\logs.txt"))
		FileAppend, , log\logs.txt, UTF-8


	if !(FileExist("img\"))
		FileCreateDir, img

}

registra(text, close:=0) {

	static logs := false

	if (close = 1){
		if (logs = false){
			return 0
		}
		logs.Close()
		logs := false
		return 0
	}

	if (logs = false){
		logs := FileOpen("log\logs.txt", "a", "UTF-8")
		if (!IsObject(logs)){
			Tooltip, logs cant be open > %A_LastError%
			Sleep, 3000
			return 1
		}
	}

	FormatTime, OutputVar , A_NowUTC, yyyy/MM/dd, hh:mm:ss
	logs.WriteLine(OutputVar . " - " . text)

}