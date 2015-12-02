#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>

;;;;;;;;;
;Globals;
;;;;;;;;;
$left = 1852
$top = 1060
$fontColor = 0xFF0000
$fontSize = 10
$fontWeight = 600
$fontAttrib = 0
$fontName = ""

; Constants
$fileIni = "settings.ini"
$time = @HOUR & ":" & @MIN & ":" & @SEC
$quit = 0


;;;;;;;;;;;;;;;
;Program Start;
;;;;;;;;;;;;;;;
initSettings()

Opt("GUIOnEventMode", 1)

;set as child of invisible parent
;hack for no taskbar icon
$hParent = GUICreate("Parent")
$hGUI = GUICreate("CLock", -1, -1, $left, $top, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_LAYERED), $hParent)

;make background transparent
GUISetBkColor(0x000000)
_WinAPI_SetLayeredWindowAttributes($hGUI, 0x000000, 255)

;create label for text
GUISetFont($fontSize, $fontWeight, $fontAttrib, $fontName, $hGUI, 3)
$label = GUICtrlCreateLabel($time, 0, 0)
GUICtrlSetColor($label, $fontColor)

;create right click menu for exit
$contextMenu = GUICtrlCreateContextMenu($label)
$menuItemExit = GUICtrlCreateMenuItem("Exit", $contextMenu)
GUICtrlSetOnEvent($menuItemExit, "quit")

GUISetState()

; Update loop
While 1
   If $quit = 1 Then Exit

   $time = @HOUR & ":" & @MIN & ":" & @SEC
   GUICtrlSetData($label, $time)
   Sleep(1000)
WEnd

; Read settings from ini file
Func initSettings()
   $left = IniRead($fileIni, "Default", "X", $left)
   $top = IniRead($fileIni, "Default", "Y", $top)
   $fontName = IniRead($fileIni, "Default", "Font", $fontName)
   $fontColor = IniRead($fileIni, "Default", "Color", $fontColor)
   $fontSize = IniRead($fileIni, "Default", "Size", $fontSize)
EndFunc

Func quit()
   $quit = 1
EndFunc