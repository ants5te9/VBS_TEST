
'標準モジュール
'※ Adobe Reader XI環境で実行
'※ その他環境では動作しない可能性があります。
Option Explicit

Private Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Long, ByVal lpEnumFunc As Long, lParam As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWndParent As Long, ByVal hWndChildAfter As Long, ByVal lpszClass As String, ByVal lpszWindow As String) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetWindow Lib "user32" (ByVal hWnd As Long, ByVal wCmd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private Const GW_HWNDNEXT As Long = 2
Private Const TCM_SETCURFOCUS As Long = &H1330
Private Const WM_COMMAND As Long = &H111
Private Const AppPath As String = "C:\Program Files (x86)\Adobe\Reader 11.0\Reader\AcroRd32.exe" 'Adobe Readerのパス
Private hPage As Long

Public Sub Sample()

'セルのクリア
  Cells.Clear
'ファイルリスト作成
  Dim dlg As FileDialog
  Dim fd_path As String  'フォルダのフルパス
  Dim fl_name As String  'ファイル名
   Dim i As Long  'ファイル名を出力する行番号

  Set dlg = Application.FileDialog(msoFileDialogFolderPicker)
  'キャンセル時にはマクロを終了
   If dlg.Show = False Then Exit Sub
 
   'フォルダのフルパスを格納
   fd_path = dlg.SelectedItems(1)

  'フォルダ内の一つ目のファイル名を取得
   fl_name = Dir(fd_path & "\*")
  If fl_name = "" Then
    MsgBox fd_path & " にはファイルが存在しません。"
    Exit Sub
  End If

  'Worksheets.Add Before:=Sheets(1)

  Range("A1").Value = fd_path
引用するにはまずログインしてください
bibouroku_yoko
bibouroku_yoko

2015-11-06
pdfをtextに変換　特定行をエクセルに抽出マクロ

'標準モジュール
'※ Adobe Reader XI環境で実行
'※ その他環境では動作しない可能性があります。
Option Explicit

Private Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Long, ByVal lpEnumFunc As Long, lParam As Long) As Long
Private Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWndParent As Long, ByVal hWndChildAfter As Long, ByVal lpszClass As String, ByVal lpszWindow As String) As Long
Private Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hWnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long
Private Declare Function GetWindow Lib "user32" (ByVal hWnd As Long, ByVal wCmd As Long) As Long
Private Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal lpString As String, ByVal cch As Long) As Long
Private Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private Const GW_HWNDNEXT As Long = 2
Private Const TCM_SETCURFOCUS As Long = &H1330
Private Const WM_COMMAND As Long = &H111
Private Const AppPath As String = "C:\Program Files (x86)\Adobe\Reader 11.0\Reader\AcroRd32.exe" 'Adobe Readerのパス
Private hPage As Long

Public Sub Sample()

'セルのクリア
  Cells.Clear
'ファイルリスト作成
  Dim dlg As FileDialog
  Dim fd_path As String  'フォルダのフルパス
  Dim fl_name As String  'ファイル名
   Dim i As Long  'ファイル名を出力する行番号

  Set dlg = Application.FileDialog(msoFileDialogFolderPicker)
  'キャンセル時にはマクロを終了
   If dlg.Show = False Then Exit Sub
 
   'フォルダのフルパスを格納
   fd_path = dlg.SelectedItems(1)

  'フォルダ内の一つ目のファイル名を取得
   fl_name = Dir(fd_path & "\*")
  If fl_name = "" Then
    MsgBox fd_path & " にはファイルが存在しません。"
    Exit Sub
  End If

  'Worksheets.Add Before:=Sheets(1)

  Range("A1").Value = fd_path
  Range("A2").Value = "のファイル一覧"
  Range("A4").Value = "ファイル名"

  'A5セルから下にファイル名を書き出し
  i = 5
  Do Until fl_name = ""
    Cells(i, 1).Value = fl_name
    i = i + 1
    '次のファイル名を取得
     fl_name = Dir
  Loop

  'MsgBox Sheets(1).Name & "にファイル名一覧を作成しました。"

'========================

  Dim num, j As Long
  Dim filename1 As Variant
 
 For j = 5 To Range("A65536").End(xlUp).Row

'  num = GetPDFPages("C:\Test\001.pdf")
 filename1 = Cells(j, 1).Value
'  num = GetPDFPages(Cells(j, 1).Value)
  num = GetPDFPages(fd_path & "\" & filename1)
  If num = 0& Then
    Debug.Print "Err."
  Else
    Debug.Print "ページ数:" & num
    Cells(j, 2).Value = num
  End If
Next

'=====================PDFの特定行からテキスト抽出
'PDFからテキスト抽出

Dim k As Long
'Dim filename2 As Variant
For k = 5 To Range("A65536").End(xlUp).Row

'aaaaaaaaaa
 'Set sh = CreateObject("WScript.Shell")
 'sh.Run "cmd /c C:\xd2tx213\command\xdoc2txt.exe" & fd_path & " \ " & filename1 & "> C:\xd2tx213\aaa\tmp.txt", 0, True
 
 CreateObject("WScript.Shell").Run "cmd /c C:\xd2tx213\command\xdoc2txt.exe" & fd_path & " \ " & filename1 & "> C:\xd2tx213\aaa\tmp.txt", 0, True
 
 
 'テキストの５行目を出力してエクセルに書き出す
    Dim FSO As Object, buf As String
    Set FSO = CreateObject("Scripting.FileSystemObject")
    '5行目を読み込んで表示します
    With FSO.GetFile("C:\xd2tx213\aaa\tmp.txt").OpenAsTextStream
        .SkipLine
        .SkipLine
        .SkipLine
        .SkipLine
        buf = .ReadLine
        .Close
    End With
    MsgBox buf
    Cells(5, k).Value = buf
    Set FSO = Nothing
Next

End Sub

Public Function GetPDFPages(ByVal PdfPath As String) As Long
  Dim hApp As Long, hDlg As Long, hTab As Long, hPageNum As Long
  Dim cmd As String
  Dim winName As String
  Dim buf As String * 255
  Dim ret As Long
  Dim timeLimit As Date
 
  ret = 0& '初期化
  cmd = """" & AppPath & """" & " " & """" & PdfPath & """"
  Shell cmd, vbNormalFocus 'Adobe Reader起動
  'CreateObject("Shell.Application").ShellExecute """" & PdfPath & """" '関連付けされている場合はこちらでも可
  timeLimit = DateAdd("s", 5, Now()) 'ループの制限時間:5秒
  Do
    hApp = FindWindowEx(0&, 0&, "AcrobatSDIWindow", vbNullString)
    Sleep 500&
    DoEvents
    If Now() > timeLimit Then Exit Do '制限時間を過ぎたらループを抜ける
  Loop While hApp = 0&
  If hApp = 0& Then GoTo Err
  PostMessage hApp, WM_COMMAND, &H1788, 0& '文書のプロパティ表示
  timeLimit = DateAdd("s", 5, Now()) 'ループの制限時間:5秒
  Do
    hDlg = FindWindowEx(0&, 0&, "#32770", "文書のプロパティ")
    Sleep 500&
    DoEvents
    If Now() > timeLimit Then Exit Do '制限時間を過ぎたらループを抜ける
  Loop While hDlg = 0&
  If hDlg = 0& Then GoTo Err
  hTab = FindWindowEx(hDlg, 0&, "GroupBox", vbNullString)
  hTab = FindWindowEx(hTab, 0&, "SysTabControl32", vbNullString)
  If hTab = 0& Then GoTo Err
  SendMessage hTab, TCM_SETCURFOCUS, 0&, 0& '「概要」タブ選択
  EnumChildWindows hDlg, AddressOf EnumChildProc, 0&
  If hPage = 0& Then GoTo Err
  hPageNum = GetWindow(hPage, GW_HWNDNEXT)
  If hPageNum = 0& Then GoTo Err
  If GetWindowText(hPageNum, buf, Len(buf)) = 0& Then GoTo Err
  winName = Left$(buf, InStr(buf, vbNullChar) - 1)
  ret = CLng(winName)
  SendMessage hDlg, WM_COMMAND, vbOK, 0& 'ダイアログを閉じる
  SendMessage hApp, WM_COMMAND, &H1791, 0& 'アプリケーション終了
Err:
  GetPDFPages = ret
End Function

Private Function EnumChildProc(ByVal hWnd As Long, ByVal lParam As Long) As Long
  Dim clsName As String, winName As String
  Dim buf1 As String * 255, buf2 As String * 255
 
  If GetClassName(hWnd, buf1, Len(buf1)) <> 0& Then
    clsName = Left$(buf1, InStr(buf1, vbNullChar) - 1)
    If clsName = "Static" Then
      If GetWindowText(hWnd, buf2, Len(buf2)) <> 0& Then
        winName = Left$(buf2, InStr(buf2, vbNullChar) - 1)
        If winName = "ページ数 :" Then
          hPage = hWnd
          EnumChildProc = False
          Exit Function
        End If
      End If
    End If
  End If
  EnumChildProc = True
End Function
