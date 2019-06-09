Option Explicit
Const xlDown = -4121

'===============================================================================
' Setup the target Excel files.
Const FlNmFm = "C:\Users\Test\Before.xlsx"
Const FlNmTo = "C:\Users\Test\After.xlsx"

' Target Sheet Name
Const StNmCmp = "Sample"

' Rownumber for compare and copy
Dim CmpFmR, CmpToR, CpyFmR, CpyToR
CmpFmR = Array(1,2,3,6,7)
CmpToR = Array(1,2,3,6,7)
CpyFmR = Array(10,11,12,13)
CpyToR = Array(11,12,13,14)

'===============================================================================
' Excel Start.
Dim oXlsApp
Set oXlsApp = CreateObject("Excel.Application")
If oXlsApp Is Nothing Then
 ' Error
 MsgBox "Excel cannott start."
Else
 Dim oBkFm, oBkTo, oShtFm, oShtTo
 Dim nCmpLnFm, nCmpLnTo, nCmpEndLnFm, nCmpEndLnTo
 Dim brkForFlg

 ' OK
 ' --Set top of Window
 oXlsApp.Application.Visible = true
 ' --wait 1seconds
 WScript.Sleep(1000)

 ' --Open Books
 Set oBkFm = oXlsApp.Application.Workbooks.Open(FlNmFm)
 Set oBkTo = oXlsApp.Application.Workbooks.Open(FlNmTo)

 ' --Select Sheets
 Set oShtFm = oBkFm.Worksheets(StNmCmp)
 Set oShtTo = oBkTo.Worksheets(StNmCmp)

 ' --Get LastLine number
 nCmpEndLnFm = oShtFm.Range("A1").End(xlDown).Row
 nCmpEndLnTo = oShtTo.Range("A1").End(xlDown).Row

' msgbox "B: " & oShtFm.Cells(1, 12).value & " , A: " & oShtTo.Cells(1, 12).value
' msgbox "B: " & nCmpEndLnFm & " , A: " & nCmpEndLnTo
' msgbox UBound(CmpFmR) & ", " & UBound(CmpToR) & ", " & UBound(CpyFmR) & ", " & UBound(CpyToR)


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

 ' ===== Finish =====
 MsgBox "Script Finish!"
 ' --wait 3seconds
 WScript.Sleep(3000)
 ' --Excel quit
 oXlsApp.Quit
 ' --Clear Object
 Set oBkFm = Nothing
 Set oBkTo = Nothing
 Set oShtFm = Nothing
 Set oShtTo = Nothing
 Set oXlsApp = Nothing
End If

