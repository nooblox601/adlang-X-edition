' ADLANG Base Interpreter
Option Explicit
Dim fso, arquivo, linha
Set fso = CreateObject("Scripting.FileSystemObject")
Set arquivo = fso.OpenTextFile("script.ad", 1)
Do Until arquivo.AtEndOfStream
  linha = arquivo.ReadLine
  If InStr(linha, "falar(") > 0 Then
    Dim msg : msg = Mid(linha, InStr(linha, "(") + 1)
    msg = Replace(msg, ")", "")
    msg = Replace(msg, "'", "")
    MsgBox msg
  End If
Loop
arquivo.Close
