
; 打开某个软件，写一个函数，传入路径，打开成功返回ture，失败返回false

#SingleInstance force	;; only one running ahk instance
SetTitleMatchMode,3		;;窗口名称匹配模式, 3完全相同, 2包含即可, 1以它开头
TablacusSpace=0
winIndex=1

;;;;;;;  周期性地按键，保持屏幕唤醒,防止休眠或睡眠 ;;;;;;;;
#Persistent
SetTimer, Timely5min, 300000	;5分钟



; WinGet, id, list,,, Program Manager
;PostMessage, 0x111,1000,,, ahk_exe AhkTestMFC.exe
;PostMessage, 0x111,512,, ToolbarWindow3214, ahk_exe Q-dir.exe
;ControlClick, x793 y553, ahk_class MjxyMainFrame_0


;;; 识别当前计算机是哪个 ;;;;;
RecoginzeComputer()









;;;;;;;;;;;;;;;;;;;;;;;;;; 111 下面是切换窗口的按键 ;;;;;;;;;;;;;;;;;

!1::WinMyActiveOrOpen("ahk_exe Code.exe","Visual Studio Code")		;;;;;;;;;;;;;;;;;;;;;;;  alt+1, 打开vsCode  ;;;;;;;;;;;;;;;;

!2::WinMyActiveOrOpen("ahk_exe devenv.exe","Visual Studio")	;;;;;;;;;;;;;;;;;;  alt+2,打开vs

!f2::WinMyActiveOrOpen("ahk_exe ONENOTE.EXE","OneNote")	;;;;;;;;;;;;;;;;;;  alt+f2, 打开noenote  ;;;;;;;;;;;;;;;;

!w::WinMyActiveOrOpen("ahk_exe ConEmu64.exe", "cmder") 	;;;;  alt+w  打开 cmder

!+s::WinMyActiveOrOpen("ahk_exe powershell.exe","Windows PowerShell")		;;;;;;;;;;;;;; alt+shift+s,打开powershell窗口 ;;;;;;;;;;;;;;;;

!E::WinMyActiveOrOpen("ahk_class CabinetWClass","explorer.exe")	;;;;;;  alt+e 打开资源管理器  ;;;;;;;;;;;;;;;;

!q::WinMyActiveOrOpen("ahk_class TablacusExplorer","Tablacus Explorer")	;;;;;;  alt+e打 Tablacus Explorer  ;;;;;;;;;;;;;;;;

!a::WinMyActiveOrOpen("ahk_exe YoudaoNote.exe", "有道云笔记")	;;;;;;  alt+a 打开 有道云笔记  ;;;;;;;;;;;;;;;;

!s::WinMyActiveOrOpen("ahk_exe Typora.exe", "Typora")	;;;;;;  alt+s 打开 Typora  ;;;;;;;;;;;;;;;;

CapsLock & f::WinMyActiveOrOpen("ahk_exe Everything.exe", "搜索 Everything", "C:\Program Files (x86)\Everything\Everything.exe", "C:\Program Files\Everything\Everything.exe") ; cap+F打开everything

!t:: Run control	;;;;;;;;; alt+t 打开控制面板








;!p:: Run %A_Desktop%\shortcut\Sticky Notes	;;;;;;;;;;;;;;;;;;  alt+p, 打开Sticky Notes. 这是打开微软商店应用的方法  ;;;;;;;;;;;;;;;;


;;;;; alt+x,在这种浏览器之间切换，360，qq，搜狗 ;;;;;;;;;;;;;;;;;;;;;;
!x::
	AddBrowserGroup()
	GroupActivate, BrowserGroup
return








;;;;;;;;;;;;;;;;;;;;;;;  alt+f1, 转换为alt+shift+esc. windows默认alt+esc是切换到上一个窗口，shift+alt+esc是相反方向 ;;;;;;;;;;;
!f1::
Send !+{esc}
return






;;;;;;;;;;;;;;;;;;;;;;;  alt+d, 当前窗口最小化. alt+shift+d,将上次最小化的窗口还原 ;;;;;;;;;;;;;
curAltDWindow = 0
!d::
	WinGet,curAltDWindow, ID, A
	; MsgBox %curAltDWindow%
	WinMinimize, A
return
!+d::
	; WinRestore, ahk_id, %curAltDWindow%
	WinMaximize, ahk_id %curAltDWindow%
	WinActivate, ahk_id %curAltDWindow%
return







;;;;; 需要以管理员身份运行脚本 ;;;
#IfWinActive ahk_exe mymain.exe
MButton::
WinActivateBottom 梦幻西游手游
return
#IfWinActive


/*
;;; 任务栏，同一程序有多个窗口时，点击直接进入其中一个窗口。
#If MouseIsOver("ahk_class Shell_TrayWnd")
~LButton::
sleep 200
IfWinExist ahk_class TaskListThumbnailWnd
{
	;MsgBox aa
	ControlClick,, ahk_class TaskListThumbnailWnd
}
return
#If
*/



















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  222下面的是特殊功能按键，大部分为cap+某个键  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;; cap+g 挂起当前窗口进程；cap+shift+g，继续当前窗口进程
CapsLock & g::

	MouseGetPos,,, MouseWinID, control
	WinGet, active_id, PID, ahk_id %MouseWinID%
	CopyPID=%active_id%
	run, pssuspend %active_id%
	;MsgBox id=%active_id%
return


; cap+1 将窗口挂起，并将其pid写入context\1.txt
CapsLock & 1::
{
	MouseGetPos,,, MouseWinID, control
	WinGet, active_id, PID, ahk_id %MouseWinID%
	CopyPID=%active_id%
	run, pssuspend %active_id%
	FileAppend, %active_id%`n, context\1.txt
	;MsgBox id=%active_id%
}
return

; cap+2, 将cap+1挂起的写入1.txt中的pid全部恢复，并清空1.txt
CapsLock & 2::
Loop, read, context\1.txt
{
    last_line := A_LoopReadLine
	;MsgBox %last_line%
	run, % "pssuspend -r "+last_line
}
FileDelete, context\1.txt
return

; cap+3 将窗口挂起，并将其pid写入context\3.txt
CapsLock & 3::
{
	MouseGetPos,,, MouseWinID, control
	WinGet, active_id, PID, ahk_id %MouseWinID%
	CopyPID=%active_id%
	run, pssuspend %active_id%
	FileAppend, %active_id%`n, context\3.txt
	;MsgBox id=%active_id%
}
return

; cap+4, 将cap+3挂起的写入3.txt中的pid全部恢复，并清空3.txt
CapsLock & 4::
Loop, read, context\3.txt
{
    last_line := A_LoopReadLine
	;MsgBox %last_line%
	run, % "pssuspend -r "+last_line
}
FileDelete, context\3.txt
return


; !r::
; 	;对于挂起的窗口，卡死了，此时这种方式获取鼠标所在位置的窗口，获取到的是dwm.exe，windows的桌面窗口管理器
; 	MouseGetPos,,, MouseWinID,control
; 	WinGet, active_id, PID, ahk_id %MouseWinID%
; 	CopyPID=%active_id%
; 	MsgBox id=%active_id%
; 	run, % "pssuspend -r "+CopyPID

; 	;获取当前激活窗口的id，如果是挂起的窗口卡死了，还是会
; 	; WinGet, active_id, PID, A
; 	; CopyPID=%active_id%
; 	; run, pssuspend %active_id%
; 	; MsgBox id=%active_id%



; 	;显示捕获到的窗口的信息。
; 	;WinGetTitle, title, ahk_id %MouseWinID%
; 	;WinGetClass, class, ahk_id %MouseWinID%
; 	;MsgBox PID=%active_id% `nahk_id %MouseWinID%`nahk_class %class%`n%title%`nControl: %control%
; return



;; cap+m 挂起所有yx窗口 ;;
CapsLock & m::
if GetKeyState("Shift")
{
	tooltip, 正在解挂进程，请等待约3秒
	for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
	{
		tooltip,
		if(process.Name="mymain.exe" or process.Name="飓风梦幻西游web助手.exe" or process.Name="SSKMH.exe")
		{
			thisPID := process.handle
			run, % "pssuspend -r "+thisPID
		}
	}
}
else
{
	tooltip, 正在挂起进程，请等待约3秒
	for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
	{
		tooltip,
		if(process.Name="mymain.exe" or process.Name="飓风梦幻西游web助手.exe" or process.Name="SSKMH.exe")
		{
			thisPID := process.handle
			run, pssuspend %thisPID%
		}
	}
}
return



;;;;;;;;;;;;;;;;;;;; cap+c,color,屏幕取色以及获取鼠标所在窗口的信息 ;;;;;;;;;
CapsLock & c::
CoordMode, Mouse, Client
Gui, Destroy
MouseGetPos, MouseX, MouseY, thisWinId
PixelGetColor, color, %MouseX%, %MouseY%, RGB
StringRight color_16,color,6
color_10 = % ToBase(color,10)
color_R := color_10//65536
color_G := Mod(color_10,65536)//256
color_B := Mod(color_10,256)
WinGetClass, thisWinClass, ahk_id %thisWinId%
WinGetTitle, thisWinTitle, ahk_id %thisWinId%
WinGet, thisWinExe, ProcessName, ahk_id %thisWinId%
WinGet, thisWinPID, PID, ahk_id %thisWinId%
clipboard = %MouseX%, %MouseY%
text= 窗口名：%thisWinTitle%`n当前鼠标相对活动窗口左上角位置为: (%MouseX%, %MouseY%)   `nRGB值为:  %color_16%`nR: %color_R%   G: %color_G%   B: %color_B%`n当前窗口id：%thisWinId%`nPID=%thisWinPID%`nahk_class %thisWinClass%`nahk_exe %thisWinExe%`n%MouseX%, %MouseY% 已复制到粘贴板
Gui, Add,Edit,, %text%
Gui, Show,, CurrentWindowInfo
return

GuiEscape:
GuiClose:
ButtonCancel:
Gui, Destroy  ; All of the above labels will do this.
return


;;;;;;;;;;;;;;;;;;;;;;;  Cap+a, 复制，打开有道词典，粘贴  ;;;;;;;;;;;;;;;;
CapsLock & a::	
SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可
;clipboard = 
SendInput ^c  
;ClipWait 
WinMyActiveOrOpen("ahk_exe PowerWord.exe","金山词霸2016")
;ControlFocus,Edit1,ahk_exe YoudaoDict.exe
sleep 300
;ControlSend, RICHEDIT50W1, test, ahk_exe YoudaoDict.exe
SendInput ^v
SendInput {Enter}
return


;金山词霸，按esc关闭
#IfWinActive ahk_exe PowerWord.exe
ESC::WinMinimize A
#IfWinActive


;;;;;;;;;;;;   Cap+s,  ctrl+s, 然后重新加载正在运行的ahk脚本  ;;;;;;;;;;;;;;;;;;;;;;
CapsLock & S::
Send ^s
sleep 300
Reload
;MsgBox load all.ahk success
return


;;;;;;;;;;;;;;;;;;;; Cap+b 保存，然后 run 1-Pending\test.bat ;;;;;;;;;
CapsLock & B::
Send ^s
sleep 300
Run, %WorkingPath%\0-pending\test.bat,%WorkingPath%\0-pending\
return


;;;;;;;;;;;;;;;;;;;; Ctrl+鼠标左键，如果在vs中，则转换为f12(转到定义) ;;;;;;;;;
#IfWinActive, ahk_exe devenv.exe
~^LButton::
	Click
	Send {F12}
return
#IfWinActive



;;;;;;;;;;;;;;;;;;;; Cap+鼠标左右键，如果在资源管理器中，则转换为alt+左右，前进后退。Cap+中键，转换为alt+上，向上 ;;;;;;;;;
#IfWinActive, ahk_exe explorer.exe
CapsLock & RButton::Send !{Right}
CapsLock & LButton::Send !{Left}
CapsLock & MButton::Send !{Up}
#IfWinActive

;;;;;;;;;;;;;;;;;;;; Cap+鼠标左右键，如果在Q-Dir中，同样转换为alt+左右，前进后退。Cap+中键，转换为alt+上，向上。不起作用 ;;;;;;;;;
#IfWinActive, ahk_exe Q-Dir.exe
CapsLock & RButton::Send !{Right}
CapsLock & LButton::Send !{Left}

CapsLock & MButton::
ControlSend, SysListView322, !{Up}, ahk_exe Q-Dir.exe
return
;{Click}+
#IfWinActive






;;;;;;;;;;;;;;;;;;;; Cap+左，home，行首，   cap+右，end ，行尾;;;;;;;;;
CapsLock & I::Send {Up}
CapsLock & Left::
CapsLock & J::
if GetKeyState("Shift")    
	Send {ShiftDown}{Home}{ShiftUp}
else
    Send {Home}
return


; 上下左右
;;;;;;;;;; cap+K 换成下， 
CapsLock & k::Send {Down}
CapsLock & Right::
CapsLock & L::
if GetKeyState("Shift")
{
	Send {ShiftDown}{End}{ShiftUp}}
}
else
    Send {End}
return




;;;;;;;;;;;;;;;;;;;;; alt+z，在窗口最大化与缩小状态之间切换  ;;;;;;;;;;;;;;;;;;;;;   
; WinStatus:=0    
; !z::    
; if WinStatus=0    
; {         
;     WinMaximize , A         
;     WinStatus:=1    
; }    
; else    
; {         
;     WinRestore ,A         
;     WinStatus:=0    
; }    
; return



;;;;;;;;;;;;;;;;;;;;;;;  alt+`, 在当前的同类程序的不同窗口间切换
!`::
SwitchToSimilarWindow()
return


SwitchToSimilarWindow()
{
	WinGetClass, CurrentWinClass, A
	WinActivateBottom ahk_class %CurrentWinClass%
}








;;; ctrl+cap, 切换， 远程桌面，Ericom 和本机outlook之间循环切换
#UseHook, On	;这个对Ericom有用
ctrl & CapsLock::
if(pcName = "KLA-laptop")	;远程电脑上的ahk忽略该命令，防止重复响应
{
	SetTitleMatchMode, 2	;窗口名称匹配模式，包含
	if(pcName = "KLA-laptop")
		tooltip, laptop Switching..
	if(pcName = "SIMU")
		tooltip, SIMU Switching..
	GroupAdd, RDPGroup, ahk_class TscShellContainerClass
	GroupAdd, RDPGroup, Ericom Blaze Client
	GroupAdd, RDPGroup, ahk_class OpusApp
	GroupActivate, RDPGroup
	tooltip,
	SetTitleMatchMode,3		;窗口名称匹配模式，完全匹配
	Send {CtrlUp}
	return
}
#UseHook, Off






;;;  三次ctrl 显示word， 或者outlook, 或者ppt
#IfWinActive ahk_exe Listary.exe
Ctrl::
HideSomeWindows()
ActiveOfficeGroup()
return
#IfWinActive




;;;;;;;;;;;;;;;;;;;; cap+t,测试 ;;;;;;;;;

CapsLock & t::

return


; ; 隐藏阴阳师的所有窗口
; CapsLock & 6::
; 	Loop, 10
; 	{
; 		WinHide, 阴阳师-网易游戏
; 	}
; return
; 
; 
; ; 显示阴阳师的所有窗口
; CapsLock & 7::
; 	Loop, 10
; 	{
; 		; SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可
; 		WinShow 阴阳师-网易游戏
; 	}
; return



; 阴阳师 4个窗口， 排成两行。 最好登录之后再用，登录之前的窗口有很多奇怪的小窗口。
CapsLock & 5::

	if winIndex = 1
	{
		posBase_x := 64
		posBase_y := 0
		winIndex++
	}
	else if winIndex = 2
	{
		posBase_x := 960
		posBase_y := 0
		winIndex++
	}
	else if winIndex = 3
	{
		posBase_x := 64
		posBase_y := 524
		winIndex++
	}
	else if winIndex = 4
	{
		posBase_x := 960
		posBase_y := 524
		winIndex = 1
	}
		
	WinMove, A, ,posBase_x ,posBase_y, 851, 509
	; 851 不重要，多少都行。 851是通过window spy观察到的

return





; 隐藏一组窗口，包括阴阳师等
!Space::
	AddHideGroup()
	HideSomeWindows()
	WinHide, ahk_exe onmyoji.exe
return

; 显示这组隐藏的窗口
^!Space::
	AddHideGroup()
	WinShow, ahk_group HideGroup
return

HideSomeWindows()
{
    global
	AddHideGroup()
	WinHide, ahk_group HideGroup
}

AddHideGroup()
{
	SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可
	AddHideGroupContainMode("onmyoji.exe", "阴阳师-网易游戏")
	SetTitleMatchMode, 3	;;;;窗口名称匹配模式为3, 完全匹配
}



; 根据exe和title找到满足条件的窗口，返回包含窗口id的数组
; wins := FindWinsWithExeTitle("SunloginRemote.exe","桌面控制")
; Loop % wins.Length()
;     MsgBox % wins[A_Index]
FindWinsWithExeTitle(exeName, titleName)
{
	DetectHiddenWindows, On
	SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可

	wins := []
	WinGet, winId, list, ahk_exe %exeName%
	Loop, %winId%
	{
		
		this_id := winId%A_Index%
		WinGetTitle, thisTitle, ahk_id %this_id%
		if InStr(thisTitle, titleName)
		{
			wins.Push(this_id)
			;MsgBox index=%A_Index% pos=%pos%  titlename=%titleName%  thisTitle=%thisTitle%  exeName=%exeName%   ahk_id=%this_id%
		}
	}

	DetectHiddenWindows, Off
	return wins
}


; 输入exe的名字和窗口title的名字，返回窗口id，单个窗口
FindWinExeTitle(exeName, titleName)
{
	DetectHiddenWindows, On
	SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可


	WinGet, winId, list, ahk_exe %exeName%
	Loop, %winId%
	{
		
		this_id := winId%A_Index%
		WinGetTitle, thisTitle, ahk_id %this_id%
		if InStr(thisTitle, titleName)
		{
			DetectHiddenWindows, Off
			; MsgBox index=%A_Index% pos=%pos%  titlename=%titleName%  thisTitle=%thisTitle%  exeName=%exeName%   ahk_id=%this_id%
			return this_id
		}
	}
}


; 输入exe的名字和窗口title的名字，返回窗口id，单个窗口
FindWinExeTitleExact(exeName, titleName)
{
	DetectHiddenWindows, On
	SetTitleMatchMode, 2	;;;;窗口名称匹配模式为2，包含即可


	WinGet, winId, list, ahk_exe %exeName%
	Loop, %winId%
	{
		
		this_id := winId%A_Index%
		WinGetTitle, thisTitle, ahk_id %this_id%
		; if InStr(thisTitle, titleName)
		if thisTitle = titleName
		{
			DetectHiddenWindows, Off
			; MsgBox index=%A_Index% pos=%pos%  titlename=%titleName%  thisTitle=%thisTitle%  exeName=%exeName%   ahk_id=%this_id%
			return this_id
		}
	}
}


InStrMsgBox(Haystack, Needle)
{
	If InStr(%Haystack%, %Needle%)
		MsgBox, The string was found.
	Else
		MsgBox, The string was not found.
}

; 传入exe的名字和窗口title的名字（窗口名包含即可）,将符合条件的所有window（可以是多个）加入HideGroup
; 这里之所以不写成通用函数，主要是循环里面要处理，如果搞成函数则需要返回一个数组。看看能不能搞个函数名作为参数传进去。
AddHideGroupContainMode(exeName, titleName)
{
	DetectHiddenWindows, On

	WinGet, winId, list, ahk_exe %exeName%
	Loop, %winId%
	{
		this_id := winId%A_Index%
		WinGetTitle, thisTitle, ahk_id %this_id%
		if InStr(thisTitle, titleName)
		{
			; MsgBox index=%A_Index% pos=%pos%  titlename=%titleName%  thisTitle=%thisTitle%  exeName=%exeName%
			GroupAdd, HideGroup, ahk_id %this_id%
		}
	}

	DetectHiddenWindows, Off
}








; ctrl+alt+x, 打开微信开发者工具，
#if pcName = "KLA-laptop"
^!x::
; ifWinExist ahk_exe qiyu.exe
SetTitleMatchMode,2	;include
IfWinExist ahk_exe wechatdevtools.exe
{
	GroupAdd, WxKfHideGroup, ahk_exe wechatdevtools.exe
	WinHide, ahk_group WxKfHideGroup
}
else
{
	GroupAdd, WxKfGroup, 微信开发者工具
	WinShow, ahk_group WxKfGroup
	WinActivate, ahk_group WxKfGroup
	; WinShow ahk_class Chrome_WidgetWin_1
}
SetTitleMatchMode,3	;exact
return
#if





; for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
; {
; 	tooltip,
; 	if(process.Name="mymain.exe" or process.Name="飓风梦幻西游web助手.exe" or process.Name="SSKMH.exe")
; 	{
; 		run, % "pssuspend -r "+thisPID
; }

	
; CAP+H 隐藏当前激活的窗口
CapsLock & H::
WinGet, WinId, ID, A
WinHide, ahk_id %WinId%
return

; alt+n 将当前激活的窗口隐藏再显示，等于说将任务栏的位置移到同类的最右侧
!N::
WinGet, WinId, ID, A
WinHide, ahk_id %WinId%
WinShow, ahk_id %WinId%
return

;;;;;;;;;;;;;;;;;;;;;;;  Cap+d, Windows资源管理器中，聚焦至地址栏，下拉显示与当前文件处于同一父目录的文件夹 ;;;;;;;;
CapsLock & D::
IfWinActive ahk_exe explorer.exe
{
	if(pcOS = "win10")
	{
		ControlFocus,ToolbarWindow323,A
		Send, {LEFT}{LEFT}{DOWN}
	}
	else if(pcOS = "win7")
	{
		ControlFocus,DirectUIHWND3,A
		Send, {TAB}{TAB}{LEFT}{LEFT}{DOWN}
	}
}
return



; 鼠标手势 资源管理器中，左右，前进后退，上，上一级目录。
#IfWinActive, ahk_exe explorer.exe
rbutton::      
minGap  = 60 ; 设定的识别阈值，大于此阈值，说明在某方向上有移动  
mousegetpos xpos1,ypos1  
Keywait, RButton, U  
mousegetpos xpos2, ypos2  
if (abs(xpos1-xpos2) < minGap and abs(ypos1-ypos2)<minGap) ; nothing 没有运动，直接输出rbutton   
	send, {rbutton}  
else if (xpos1-xpos2 > minGap and abs(ypos1-ypos2)<minGap) ; left  前进
	Send !{Right}
else if (xpos2-xpos1 > minGap and abs(ypos1-ypos2)<minGap) ; right 后退 
	Send !{Left}
else if (abs(xpos1-xpos2)< minGap and (ypos1-ypos2)>minGap) ; up alt+up  
	Send !{Up}
else if (abs(xpos1-xpos2)< minGap and (ypos2-ypos1)>minGap) ; down  Enter
	Send {Enter}
else    
send, {rbutton}  
return
#IfWinActive


;;;; Cap+左右键 在visual studio 中，Cap+左键前进，Cap+右键后退 (左键之所以设置为前进，是因为它仿佛是ctrl+左键)
#IfWinActive, ahk_exe devenv.exe
CapsLock & RButton::Send ^-			;后退
CapsLock & LButton::Send ^+-		;前进
#IfWinActive



;;函数，鼠标手势,在vscode中，将左右转换为alt+left和alt+right
#IfWinActive, ahk_exe Code.exe
rbutton::
	minGap  = 60 ; 设定的识别阈值，大于此阈值，说明在某方向上有移动  
	mousegetpos xpos1,ypos1  
	Keywait, RButton, U  
	mousegetpos xpos2, ypos2  
	if (abs(xpos1-xpos2) < minGap and abs(ypos1-ypos2)<minGap) ; nothing 没有运动，直接输出rbutton   
		send, {rbutton}  
	else if (xpos1-xpos2 > minGap and abs(ypos1-ypos2)<minGap) ; left  前进
	{
		Send !{Right}
		tooltip, forward
		SetTimer, RemoveToolTip, 400
	}
	else if (xpos2-xpos1 > minGap and abs(ypos1-ypos2)<minGap) ; right 后退 
	{
		Send !{Left}
		tooltip, back
		SetTimer, RemoveToolTip, 400
	}
	else    
		send, {rbutton}  
	return
#IfWinActive




;;;;;;;;;;;;;;;;;;;; alt+C，转换为alt+f4，或者ctrl+w, 关闭 ;;;;;;;;;
~!c::
AddBrowserGroup()
IfWinActive ahk_class TablacusExplorer
	Send ^w
else IfWinActive ahk_group BrowserGroup			;浏览器
	Send ^w
else IfWinActive ahk_class Chrome_WidgetWin_1	;vscode
	Send ^w
else IfWinActive ahk_class WeChatMainWndForPC	;微信
{
	sleep 300
	WinClose ahk_class WeChatMainWndForPC
	sleep 200
}
else IfWinActive ahk_exe HBuilderX.exe			;HBuilderX.exe
	Send !c
else IfWinActive ahk_exe idea64.exe			;idea.exe
	Send !c
else IfWinActive ahk_exe QQ.exe
	Send !c
else IfWinActive ahk_exe MySQLWorkbench.exe
	Send !c

else  ; 其他的不管
	return



;;;;;;;;;;;;;;; Tablacus 设置ctrl+d为删除
#IfWinActive, ahk_class TablacusExplorer
^d::Send, {Delete}
#IfWinActive







;
;
;IfWinNotExist ahk_exe TE64.exe
;	MsgBox Tablacus Explorer is not running!
;else IfWinActive ahk_exe TE64.exe
;	WinActivate ahk_exe TE64-2.exe
;else
;	WinActivate ahk_exe TE64.exe
return
#IfWinActive
;Run %A_Desktop%\shortcut\Tablacus Explorer


;; 小写变大写
CapsLock & u::  
clipboard = ; 清空剪贴板
Send, ^c
ClipWait, 2
if ErrorLevel
{
    MsgBox, The attempt to copy text onto the clipboard failed.
    return
}
str= %clipboard%
clipboard:=StringUpper(str)
Send ^v
return


StringUpper(ByRef InputVar, T = "")
{
	StringUpper, InputVar, InputVar, %T%
	return InputVar
}


;; 左右键一起按，同时按，在同类窗口中切换。
#if pcName = "KLA-laptop"
	~LButton & RButton::
	HideSomeWindows()
	return

	~RButton & LButton::
	HideSomeWindows()
	return
#if pcName = "JiuChong"
	~LButton & RButton::
	return

	~RButton & LButton::
	return
#if

;; 中键+左键，切换同类窗口。
~MButton & RButton::
SwitchToSimilarWindow()
return


~RButton & MButton::
SwitchToSimilarWindow()
return


;;;;;;;;;;;;;;;;;;;;;;; 333 下面是输入转换和函数 ;;;;;;;;;;;;;;;;;;;;;;;;;

::···::```

::3282::328247921

::5356::535674963

::32qq::328247921@qq.com

::53qq::535674963@qq.com

::1307::13071806202

::gao7::gao725224

::Gao7::Gao725224

::4113::411323199303135850




;; Functions

RecoginzeComputer()
{
	global		;将这里面的变量都定义为global。
	if FileExist("C:\Users\liugao")	;;;;;KLA-laptop
	{
		WorkingPath=C:\Users\liugao\1-working
		pcName=KLA-laptop
		pcOS=win10
		MsgBox Load Successful,   KLA-laptop, win10.
	}
	if FileExist("C:\Users\autologonuser")	;;;;SIMU
	{
		WorkingPath=D:\1-working
		pcName=SIMU
		pcOS=win7
		; MsgBox Load Successful,   SIMU, win7.
	}
	if FileExist("C:\Users\JiuChong")	;;;JiuChong
	{
		WorkingPath=D:\OneDrive - business\1-working
		pcName=JiuChong
		pcOS=win10
		; MsgBox Load Successful,   JiuChong, win10.
	}
	if FileExist("C:\Users\myAcer")	;;;myAcer
	{
		WorkingPath=\\jiuchong\OneDrive - business\1-working
		pcName=myAcer
		pcOS=win10
		; MsgBox Load Successful,   myAcer, win10.
	}
	if FileExist("C:\Users\ps4800")	;;;ps4800
	{
		pcName=ps4800
		pcOS=win10
		; MsgBox Load Successful,   ps4800, win10.
	}
	
}



;;;;; 按 alt+某个键 打开窗口，如果某个程序有多个窗口，则再按时会在这些窗口间切换
myWinActive(WinTitle)
{
	IfWinNotActive, %WinTitle%
	{
		WinActivate, %WinTitle%
	}
	else
	{
		WinActivateBottom, %WinTitle%
	}
	return
}




; ;;;;; 程序未运行，就打开它，运行了，就激活窗口
; ;用法示例： !f1::WinMyActiveOrOpen("ahk_exe notepad++.exe","Notepad++")， 其中Notepad++是位于桌面上的shortc文件夹下面的快捷方式名
; WinMyActiveOrOpen(WinTitle, shortName)
; {
; 	IfWinExist %WinTitle%
; 	{
; 		myWinActive(WinTitle)
; 	}
; 	else{
; 		tooltip, 正在打开 %shortName%
; 		Run, %A_Desktop%\shortcut\%shortName%,,UseErrorLevel
; 		if(A_LastError != 0){
; 			sleep 500
; 			tooltip, "打开失败"
; 			sleep 1000
; 			tooltip,
; 		}
; 		sleep 1000
; 		tooltip,
; 	}
		
; }


;;;;; 程序未运行，就打开它，运行了，就激活窗口
;用法示例： WinMyActiveOrOpen("ahk_exe Everything.exe", "Everything", "C:\Program Files\Everything\Everything.exe")
; WinTitle用于检测是否存在该窗口，shortName用于toolTip提示，exePath用于打开exe的路径，依次尝试exePath1、2、3
WinMyActiveOrOpen(WinTitle, shortName="", exePath1="", exePath2="", exePath3=""){
	IfWinExist %WinTitle%
	{
		myWinActive(WinTitle)
	}
	else{
		tooltip, 正在打开%shortName%
		Run, %A_Desktop%\shortcut\%shortName%,,UseErrorLevel
		if(A_LastError != 0)
			Run, %shortName%,,UseErrorLevel
		if(A_LastError != 0)
			Run, %exePath1%,,UseErrorLevel
		if(A_LastError != 0)
			Run, %exePath2%,,UseErrorLevel
		if(A_LastError != 0)
			Run, %exePath3%,,UseErrorLevel
		if(A_LastError != 0)
		{
			sleep 600
			tooltip, "打开失败"
		}
		sleep 800
		tooltip,
	}
}


;;;;; 16进制转换为10进制 ;;;;;;;;
ToBase(n,b){
    return (n < b ? "" : ToBase(n//b,b)) . ((d:=Mod(n,b)) < 10 ? d : Chr(d+55))
}

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

;判断鼠标是否在wintitle对应的窗口上，返回true和false
MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


;;;;;;;  周期性地按键，保持屏幕唤醒,不用了 ;;;;;;;;
Timely5min:
if(pcName = "KLA-laptop")
{
	;Send {CtrlUp}{AltUp}
}
return



Timely30s:
SetTitleMatchMode,3
ifWinExist TeamViewer
WinHide
ifWinExist Session timeout!
WinHide
return







;;;;;;;;;;;;;; 模拟spy， 读取鼠标所在位置的数据
#Persistent
;SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ToolTip, ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
return


AddBrowserGroup()
{
	global
	GroupAdd, BrowserGroup, ahk_exe liebao.exe
	GroupAdd, BrowserGroup, ahk_class 360se6_Frame
	GroupAdd, BrowserGroup, ahk_class SE_SogouExplorerFrame
	GroupAdd, BrowserGroup, ahk_class QQBrowser_WidgetWin_1
	GroupAdd, BrowserGroup, ahk_exe UCBrowser.exe
	GroupAdd, BrowserGroup, ahk_exe chrome.exe
}

ActiveOfficeGroup()
{
	global
	GroupAdd, OfficeGroup, ahk_class OpusApp			;word
	GroupAdd, OfficeGroup, ahk_class rctrl_renwnd32		;outlook
	GroupAdd, OfficeGroup, ahk_class PPTFrameClass		;ppt
	GroupActivate, OfficeGroup
}



;先将所有符合条件的 WinTitle 加入 group， 再隐藏。
;这样速度快，而且在函数内加入的group name是临时变量，不会重复。
;GroupHide("ahk_class OrayUI")
GroupHide(WinTitle)
{
	GroupAdd, HideGroupTmp, %WinTitle%
	WinHide, ahk_group HideGroupTmp
}


;先将所有符合条件的 WinTitle 加入 group， 再显示。
;这样速度快，而且在函数内加入的group name是临时变量，不会重复。
;GroupShow("ahk_class OrayUI")
GroupShow(WinTitle)
{
	DetectHiddenWindows, On
	GroupAdd, ShowGroupTmp, %WinTitle%
	WinShow, ahk_group ShowGroupTmp
	DetectHiddenWindows, Off
}


; 代码回收

; Ctrl版的上下左右，不好使，因为按键的时候会有奇怪的粘滞感，经常输入错误。
	; ^I::Send {Up}
	; ^+I::Send {ShiftDown}{Up}{ShiftUp}

	; ;;;;;;;;;; cap+i 换成下
	; ^+K::Send {ShiftDown}{Down}{ShiftUp}
	; ^K::Send {Down}

	; ;;;;;;;; cap+J 换成left
	; ^J::Send ^{Left}
	; ^+J::Send {ShiftDown}^{Left}{ShiftUp}

	; ;;;;;;; cap+L 换成right
	; ^L::Send ^{Right}
	; ^+L::Send {ShiftDown}^{Right}{ShiftUp}

; 挂起梦幻西游的所有进程（挂起之后会提示网络断开，需要重新扫码登录）
    ; tooltip, 正在挂起进程，请等待约3秒
    ; for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
    ; {
    ;     tooltip,
    ;     if(process.Name="mymain.exe" or process.Name="飓风梦幻西游web助手.exe" or process.Name="SSKMH.exe")
    ;     {
    ;         thisPID := process.handle
    ;         run, pssuspend %thisPID%
    ;     }
    ; }

	; ; 解挂进程（没生效，不知道为啥）
    ; tooltip, 正在解挂进程，请等待约3秒
    ; for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
    ; {
    ;     tooltip,
    ;     if(process.Name="mymain.exe" or process.Name="飓风梦幻西游web助手.exe" or process.Name="SSKMH.exe")
    ;     {
    ;         thisPID := process.handle
    ;         run, % "pssuspend -r "+thisPID
    ;     }
    ; }


