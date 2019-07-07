Option Explicit
Const xlDown = -4121

'===============================================================================
' Configuration
'===============================================================================
Const FlNm = "C:\work\Test\GitHub\VBS_TEST\cp_1\dbuf.xlsx"

' Target Sheet Name
Const StNm = "Sample"
' Output Sheet Name
Const StNmOut = "TimeBuf"

' Row number for idx
Dim TimBufR
TimBufR = Array(1,2,3,4)
Dim TimBufOfs
TimBufOfs = 3
Dim TimBufStp
TimBufStp = 5
Dim TimBufNum
TimBufNum = 32

Dim IdxLoopMax
IdxLoopMax = 255
'===============================================================================
' Script Main.
'===============================================================================
Dim oXlsApp: Set oXlsApp = CreateObject("Excel.Application")
If oXlsApp Is Nothing Then
	' Error
	WScript.Echo "Excel cannot start."
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
	Dim nCmpEndLn: nCmpEndLn = oSht.Range("A3").End(xlDown).Row

	' --Execute control_functions-------------------------------
	Dim result: result = constructTimeBufFunc(oBk, oSht, nCmpEndLn)
	oXlsApp.Application.StatusBar = "Script Finish!"
	WScript.Echo "Script Finish!"
	' ----------------------------------------------------------

	' --wait 1second
	WScript.Sleep(1000)
	' --Clear Object
	Set oSht = Nothing
	Set oBk = Nothing
End Sub

'===============================================================================
' Class: TimeBufClass
'===============================================================================
Class TimBufClass
	Dim Tid
	Dim Cid
	Dim TimVal
	
	Private Sub Class_Initialize()
		Tid = 0
		Cid = 0
		TimVal = 0
	End Sub
	
	Private Sub Class_Terminate()
	End Sub
	
	Public Property Let setTid(aTid)
		Tid = aTid
	End Property
	Public Property Let setCid(aCid)
		Cid = aCid
	End Property
	Public Property Let setTim(aTimeVal)
		TimVal = aTimeVal
	End Property
	
	Public Function getTid()
		getTid = Tid
	End Function
	Public Function getCid()
		getCid = Cid
	End Function
	Public Function getTimeVal()
		getTimeVal = TimVal
	End Function
	Public Function show(str)
		WScript.Echo str & "(Tid,Cid)=(" & Tid & "," & Cid & ") Time: " & TimVal
	End Function

End Class

'===============================================================================
' Procedure: main
'===============================================================================
Function constructTimeBufFunc(oBk, oSht, nCmpEndLn)
	Dim nCmpLn, iCmp
	Dim objDict: Set objDict = CreateObject("Scripting.Dictionary")

	' Regist informations.
	Dim nIdx, nIdxOld, nIdxLoopCnt
	nIdxLoopCnt= 0
	nIdxOld = 0
	For nCmpLn = 3 To nCmpEndLn  ' Loop for each lines.
		Dim isOldData
		isOldData = vbFalse
		For iCmp = 0 To TimBufNum - 1
			nIdxOld = nIdx
			nIdx = oSht.Cells(nCmpLn, TimBufOfs + (iCmp * TimBufStp) + TimBufR(0)).value
			If nIdx <> "" Then
				Dim sKey
				If (nIdx = 0) And (nIdxOld = IdxLoopMax) Then
					nIdxLoopCnt = nIdxLoopCnt + 1
				ElseIf (iCmp <> 0) And (nIdx <> (nIdxOld + 1)) Then
					isOldData = vbTrue
				End If
				sKey = nIdxLoopCnt & "_" & nIdx

				If isOldData = vbFalse Then
					Dim cTm: Set cTm = New TimBufClass
					cTm.setTid = oSht.Cells(nCmpLn, TimBufOfs + (iCmp * TimBufStp) + TimBufR(1)).value
					cTm.setCid = oSht.Cells(nCmpLn, TimBufOfs + (iCmp * TimBufStp) + TimBufR(2)).value
					cTm.setTim = oSht.Cells(nCmpLn, TimBufOfs + (iCmp * TimBufStp) + TimBufR(3)).value

					' Add dictionary.
					If Not(objDict.Exists(sKey)) Then
						objDict.Add sKey, cTm
					Else
'						cTm.show("Already Exist: Ln:" & nCmpLn & " K:" & sKey & " - ")
					End If
					Set cTm = Nothing
				Else
'					WScript.Echo "isOldData: " & isOldData & "(" & nIdx & "<-" & nIdxOld & ")"
				End If
			End If
		Next
		' 
		oXlsApp.Application.StatusBar = "Step1: " & nCmpLn & "/" & nCmpEndLn & " collected " & objDict.Count & " items.  Processing..."
	Next

	'--Output collected data.
	Dim outSt: Set outSt = oBk.Sheets.Add(, oSht)
	outSt.Name = StNmOut
	outSt.Cells(iCmp+2, 1).value = "Idx"
	outSt.Cells(iCmp+2, 2).value = "Tid"
	outSt.Cells(iCmp+2, 3).value = "Cid"
	outSt.Cells(iCmp+2, 4).value = "TimeVal"

	Dim aryTmp
	aryTmp = objDict.Keys
	For iCmp = 0 To objDict.Count -1
'		objDict(aryTmp(iCmp)).show("Idx: " & aryTmp(iCmp))
		outSt.Cells(iCmp+2, 1).value = aryTmp(iCmp)
		outSt.Cells(iCmp+2, 2).value = objDict(aryTmp(iCmp)).getTid
		outSt.Cells(iCmp+2, 3).value = objDict(aryTmp(iCmp)).getCid
		outSt.Cells(iCmp+2, 4).value = objDict(aryTmp(iCmp)).getTimeVal
	Next
	outSt = Nothing

	constructTimeBufFunc = True
End Function
