Option Explicit
Const xlDown = -4121

'===============================================================================
' Configuration
'===============================================================================
Const FlNm = "C:\work\Test\GitHub\VBS_TEST\cp_1\dbuf.xlsx"

' Target Sheet Name
Const StNm = "Sample"

' Row number for idx
Dim TimBufR
TimBufR = Array(3,4,5,6)
Dim TimBufOfs
TimBufOfs = 5
Dim TimBufNum
TimBufNum = 32

'===============================================================================
' Script Main.
'===============================================================================
Dim oXlsApp: Set oXlsApp = CreateObject("Excel.Application")
If oXlsApp Is Nothing Then
	' Error
	MsgBox "Excel cannot start."
Else
	' OK
	ExcelCtrlFunc()

	' --Excel quit
	oXlsApp.Application.StatusBar = ""
	oXlsApp.Quit
	Set oXlsApp = Nothing
End If


'===============================================================================
' Procedure: Excel control
'===============================================================================
Sub ExcelCtrlFunc()
	' --Set top of Window
	oXlsApp.Application.Visible = true
	' --wait 1second
	WScript.Sleep(1000)

	' --Open xlBooks and Get target xlSheets
	Dim oBk: Set oBk = oXlsApp.Application.Workbooks.Open(FlNm)
	Dim oSht: Set oSht = oBk.Worksheets(StNm)

	' --Get LastLine number
	Dim nCmpEndLn: nCmpEndLn = oSht.Range("A1").End(xlDown).Row

	' --Execute control_functions-------------------------------
	Dim result: result = constructTimeBufFunc(oSht, nCmpEndLn)
	oXlsApp.Application.StatusBar = "Script Finish!"
	MsgBox "Script Finish!"
	' ----------------------------------------------------------

	' --wait 1second
	WScript.Sleep(1000)
	' --Clear Object
	Set oSht = Nothing
	Set oBk = Nothing
End Sub

'===============================================================================
' Procedure: Check and Copy
'===============================================================================
Function constructTimeBufFunc(oSht, nCmpEndLn)
	Dim nCmpLn

	constructTimeBufFunc = True
End Function
