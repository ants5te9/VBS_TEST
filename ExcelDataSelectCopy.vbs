Option Explicit
Const xlDown = -4121

'===============================================================================
' Configuration
'===============================================================================
Const FlNmBase = "C:\work\Test\GitHub\VBS_TEST\cp_2\base.xlsx"
Const FlNmTmpl = "C:\work\Test\GitHub\VBS_TEST\cp_2\template.xlsx"
Const FlNmRslt = "C:\work\Test\GitHub\VBS_TEST\cp_2\rslt.xlsx"

' Sheet Name
Const StNmTmpl = "Template"

' Row number for compare and copy
Const CpyFmLnB = 4
Const CpyToLnB = 6
Dim CpyFmR, CpyToR
CpyFmR = Array("B","C","D","E","F","G","H","I","J","K","L","N","P","R","U")
CpyToR = Array("B","D","F","G","H","I","J","K","L","M","N","S","Q","W","O")

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
	Dim oBkFm: Set oBkFm = oXlsApp.Application.Workbooks.Open(FlNmBase)
	Dim oBkTp: Set oBkTp = oXlsApp.Application.Workbooks.Open(FlNmTmpl)
	Dim oBkTo: Set oBkTo = oXlsApp.Application.Workbooks.Open(FlNmRslt)
	Dim oShtTp: Set oShtTp = oBkTp.Worksheets(StNmTmpl)
	Dim oShtFm

	If UBound(CpyFmR) = UBound(CpyToR) Then ' config check
		For Each oShtFm In oBkFm.Sheets
			oXlsApp.Application.StatusBar = "Sheet: " & oShtFm.Name

			' --Get LastLine number
			Dim nCmpEndLnFm: nCmpEndLnFm = oShtFm.Range("A1").End(xlDown).Row
			'MsgBox "Sheet: " & oShtFm.Name & vbCrLf & "LastLn: "& nCmpEndLnFm & ", CopyCol: " & UBound(CpyFmR)

			' --Execute control_functions-------------------------------
			'oXlsApp.Application.ScreenUpdating = False
			Dim result: result = SelectDataCopy(oShtFm, oShtTp, oBkTo, nCmpEndLnFm)
			'oXlsApp.Application.ScreenUpdating = True
			' ----------------------------------------------------------
		Next
	End If
	oXlsApp.Application.StatusBar = "Script Finish!"
	MsgBox "Script Finish!"

	' --wait 1second
	WScript.Sleep(1000)
	' --Clear Object
	Set oShtFm = Nothing
	Set oShtTp = Nothing
	oBkTp.Close(): Set oBkTp = Nothing
	oBkTo.Close(): Set oBkTo = Nothing
	oBkFm.Close(): Set oBkFm = Nothing
End Sub

'===============================================================================
' Procedure: SelectDataCopy
'===============================================================================
Function SelectDataCopy(oShtFm, oShtTp, oBkTo, nCmpEndLnFm)
	Dim oShtTo
	Dim Ln, LnTo, idx
	
	' Copy template sheet to ResultBook
	oShtTp.Copy , oBkTo.Worksheets(oBkTo.Worksheets.Count)
	Set oShtTo = oBkTo.Worksheets(oBkTo.Worksheets.Count)
	oShtTo.Name = oShtFm.Name

	' Data Copy
	For Ln = CpyFmLnB To nCmpEndLnFm
		'MsgBox "Ln: " & Ln & " - " & nCmpEndLnFm
		LnTo = CpyToLnB + Ln - CpyFmLnB
		For idx = 0 To UBound(CpyFmR)-1
			oShtFm.Range(CpyFmR(idx)&CStr(Ln)).Copy oShtTo.Range(CpyToR(idx)&CStr(LnTo))
			'MsgBox "idx: " & idx & vbCrLf & oShtFm.Range(CpyFmR(idx)&CStr(Ln)).Value
		Next
	Next

	oBkTo.Save
	
	SelectDataCopy = True
End Function

