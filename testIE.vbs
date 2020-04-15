Option Explicit

Const strURL="https://www.deepl.com/ja/translator"
Const strTitle="DeepL翻訳"
'======================================================================
Private Function GetActiveIE(ByVal url)
'URLを指定して起動中のIE取得
  Dim o
  Set GetActiveIE = Nothing
  For Each o In GetObject("new:{9BA05972-F6A8-11CF-A442-00A0C90A8F39}") 'ShellWindows
    If o is Nothing Then
    Else
      If InStr(LCase(o.FullName),"iexplore.exe") > 0 Then
        If LCase(TypeName(o.document)) = "htmldocument" Then
          If o.LocationURL = strURL Then
            Set GetActiveIE = o
            Exit For
          End If
        End If
      End If
    End If
  Next
End Function

'======================================================================
Function GetProcID(ProcessName)
    Dim Service
    Dim QfeSet
    Dim Qfe
    Dim intProcID
    
    Set Service = WScript.CreateObject("WbemScripting.SWbemLocator").ConnectServer
    Set QfeSet = Service.ExecQuery("Select * From Win32_Process Where Caption='" & ProcessName & "'")
 
    intProcID = 0
    For Each Qfe in QfeSet
        intProcID = Qfe.ProcessId
        Exit For
    Next
    GetProcID = intProcID
End Function

'======================================================================
Dim objIE
Dim objLink
Dim objTag
Dim objShell
Dim objWindow
Dim objBtn
Dim objUI
Dim objHTML
Dim TEXT
Dim objWshShell
Dim intProcID
 
Set objIE = GetActiveIE(strTitle)
If objIE is Nothing Then
    Set objIE = CreateObject("InternetExplorer.Application")
    With objIE
        .AddressBar = False
        .MenuBar = False
        .StatusBar = False
        .Toolbar = False
        .Visible = True
    End With
End If

'IEを開く(既に開いている場合はリロード)
objIE.navigate strURL

'ページが読み込まれるまで待つ
Do While objIE.Busy = True Or objIE.readyState <> 4
    WScript.Sleep 1000
Loop

'Msgbox objIE.document.Title
Set objWindow = Nothing
For Each objTag In objIE.document.getElementsByClassName("lmt__textarea")
    ' 左(Input)側textbox
    If InStr(LCase(objtag.outerHTML),"translator-source-input") > 0 Then
        objtag.InnerHTML = "Today is sunny"
    End If
    
    ' 右(Output)側textbox
    If InStr(LCase(objtag.outerHTML),"translator-target-input") > 0 Then
        Set objWindow = objtag
        Exit For
    End If
Next


If objWindow is Nothing Then
    MsgBox "objTag is Nothing"
Else
    ' 翻訳を開始
'    For Each objUI In objIE.document.getElementsByClassName("lmt__language_select__menu")
'        If InStr(LCase(objUI.outerHTML),"translator-target-lang-list") > 0 Then
'            For Each objBtn In objUI.getElementsByTagName("button")
'                If InStr(LCase(objBtn.innerHTML),"日本語") > 0 Then
'                    objBtn.Click
'                End If
'            Next
'        End If
'    Next

    ' 翻訳完了まで待つ
    Do While objWindow.InnerHTML = ""
        WScript.Sleep 1000
    Loop
    
    ' クリップボードにコピーする
    For Each objUI In objIE.document.getElementsByClassName("lmt__target_toolbar__copy")
        'If InStr(LCase(objUI.outerHTML),"クリップボードにコピーする") > 0 Then
            For Each objBtn In objUI.getElementsByTagName("button")
                objBtn.Click
                Exit For
            Next
        'End If
    Next

    Set objHTML = CreateObject("htmlfile")
    TEXT = Trim(objHTML.ParentWindow.ClipboardData.GetData("text"))

    MsgBox TEXT
End If
