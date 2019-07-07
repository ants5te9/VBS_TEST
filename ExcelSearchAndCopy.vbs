Option Explicit
Const xlDown = -4121

'===============================================================================
' Configuration
'===============================================================================
Const FlNmFm = "C:\work\Test\GitHub\VBS_TEST\cp_1\Before.xlsx"
Const FlNmTo = "C:\work\Test\GitHub\VBS_TEST\cp_1\After.xlsx"

' Target Sheet Name
Const StNmCmp = "Sample"

' Row number for compare and copy
Dim CmpFmR, CmpToR, CpyFmR, CpyToR
CmpFmR = Array(1,2,3,6,7)
CmpToR = Array(1,2,3,6,7)
CpyFmR = Array(10,11,12,13)
CpyToR = Array(11,12,13,14)

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
	Dim oBkFm: Set oBkFm = oXlsApp.Application.Workbooks.Open(FlNmFm)
	Dim oShtFm: Set oShtFm = oBkFm.Worksheets(StNmCmp)
	Dim oBkTo: Set oBkTo = oXlsApp.Application.Workbooks.Open(FlNmTo)
	Dim oShtTo: Set oShtTo = oBkTo.Worksheets(StNmCmp)

	' --Get LastLine number
	Dim nCmpEndLnFm: nCmpEndLnFm = oShtFm.Range("A1").End(xlDown).Row
	Dim nCmpEndLnTo: nCmpEndLnTo = oShtTo.Range("A1").End(xlDown).Row

'	msgbox "B: " & oShtFm.Cells(1, 12).value & " , A: " & oShtTo.Cells(1, 12).value
'	msgbox "B: " & nCmpEndLnFm & " , A: " & nCmpEndLnTo
'	msgbox UBound(CmpFmR) & ", " & UBound(CmpToR) & ", " & UBound(CpyFmR) & ", " & UBound(CpyToR)

	' --Execute control_functions-------------------------------
	Dim result: result = CheckAndCopy_1(oShtFm, oShtTo, nCmpEndLnFm, nCmpEndLnTo)
	MsgBox "Script Finish!"
	' ----------------------------------------------------------

	' --wait 1second
	WScript.Sleep(1000)
	' --Clear Object
	Set oShtTo = Nothing
	Set oShtFm = Nothing
	Set oBkTo = Nothing
	Set oBkFm = Nothing
End Sub

'===============================================================================
' Procedure: Check and Copy
'===============================================================================
Function CheckAndCopy_1(oShtFm, oShtTo, nCmpEndLnFm, nCmpEndLnTo)
	Dim brkForFlg
	Dim nCmpLnFm, nCmpLnTo

	' Loop with Target sheet
	brkForFlg = 0
	For nCmpLnTo = 2 To nCmpEndLnTo
		If brkForFlg = 0 Then

		' Loop with Source sheet
		Dim brkForFlgFm, iCmp
		brkForFlgFm = 0
		For nCmpLnFm = nCmpLnTo To nCmpEndLnFm
		If brkForFlgFm = 0 Then
			' ------- Check Row in compare array -------------------------------------
			Dim bMatch, sCmpFm, sCmpTo
			bMatch = 1
			sCmpFm = ""
			sCmpTo = ""
			For iCmp = 0 To UBound(CmpFmR)
				sCmpFm = sCmpFm & oShtFm.Cells(nCmpLnFm, CmpFmR(iCmp)).value & " - "
				sCmpTo = sCmpTo & oShtTo.Cells(nCmpLnTo, CmpToR(iCmp)).value & " - "
				If oShtTo.Cells(nCmpLnTo, CmpToR(iCmp)).value <> oShtFm.Cells(nCmpLnFm, CmpFmR(iCmp)).value Then
					bMatch = 0
				End If
			Next

			'     MsgBox "Ln(" & nCmpLnTo & "," & nCmpLnFm & ") match: " & bMatch & vbCrLf & sCmpTo & vbCrLf & sCmpFm
			' ------- Copy Row in copy array ----------------------------------------
			If bMatch = 1 Then
				Dim bWrote
				bWrote = 0
				For iCmp = 0 To UBound(CpyFmR)
					If oShtTo.Cells(nCmpLnTo, CpyToR(iCmp)).value <> "" Then
					' not write
					Else
						If CpyFmR(iCmp) = 10 Then
							' Copy only value
							oShtTo.Cells(nCmpLnTo, CpyToR(iCmp)).value = oShtFm.Cells(nCmpLnFm, CpyFmR(iCmp)).value
						Else
							' Copy with property
							oShtFm.Cells(nCmpLnFm, CpyFmR(iCmp)).Copy oShtTo.Cells(nCmpLnTo, CpyToR(iCmp))
						End If
					End If
				Next

				' Next line in target sheet
				brkForFlgFm = 1
			End If
		End If

		oXlsApp.Application.StatusBar = "(" & nCmpLnTo & "/" & nCmpEndLnTo & ", " & nCmpLnFm & "/" & nCmpEndLnFm & ") Processing..."
	Next

	End If
	Next

	CheckAndCopy_1 = True
End Function

Function CheckAndCopy_2(oShtFm, oShtTo, nCmpEndLnFm, nCmpEndLnTo)
 Dim objDict: Set objDict = CreateObject("Scripting.Dictionary")

End Function
