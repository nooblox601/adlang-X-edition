Option Explicit

Dim shell, fso, nomeLing, extensao, comando
Dim baseDir, langDir
Dim interpFile, scriptFile, runFile

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

nomeLing = InputBox("Nome da nova linguagem:", "ADLANG IDE", "NovaLang")
If nomeLing = "" Then WScript.Quit

extensao = InputBox("Extensão dos arquivos (sem ponto):", "ADLANG IDE", "adl")
If extensao = "" Then WScript.Quit

comando = InputBox("Comando de impressão (ex: falar):", "ADLANG IDE", "falar")
If comando = "" Then WScript.Quit

baseDir = shell.ExpandEnvironmentStrings("%USERPROFILE%") & "\Documents\Projects\"
langDir = baseDir & nomeLing

If Not fso.FolderExists(baseDir) Then fso.CreateFolder(baseDir)
If Not fso.FolderExists(langDir) Then fso.CreateFolder(langDir)

' ======== Interpretador ========
Set interpFile = fso.CreateTextFile(langDir & "\indexForLanguage.vbs", True)

interpFile.WriteLine "' " & nomeLing & " Interpreter"
interpFile.WriteLine "Option Explicit"
interpFile.WriteLine "Dim fso, arquivo, linha"
interpFile.WriteLine "Set fso = CreateObject(" & Chr(34) & "Scripting.FileSystemObject" & Chr(34) & ")"
interpFile.WriteLine "Set arquivo = fso.OpenTextFile(" & Chr(34) & "script." & extensao & Chr(34) & ", 1)"
interpFile.WriteLine "Do Until arquivo.AtEndOfStream"
interpFile.WriteLine "  linha = arquivo.ReadLine"
interpFile.WriteLine "  If InStr(linha, " & Chr(34) & comando & "(" & Chr(34) & ") > 0 Then"
interpFile.WriteLine "    Dim msg"
interpFile.WriteLine "    msg = Replace(linha, " & Chr(34) & comando & "(" & Chr(34) & ", """")"
interpFile.WriteLine "    msg = Replace(msg, " & Chr(34) & ")" & Chr(34) & ", """")"
interpFile.WriteLine "    msg = Replace(msg, " & Chr(34) & "'" & Chr(34) & ", """")"
interpFile.WriteLine "    MsgBox msg"
interpFile.WriteLine "  End If"
interpFile.WriteLine "Loop"
interpFile.WriteLine "arquivo.Close"
interpFile.Close

' ======== Script exemplo ========
Set scriptFile = fso.CreateTextFile(langDir & "\script." & extensao, True)
scriptFile.Write comando & "(" & Chr(34) & "Olá mundo em " & nomeLing & "!" & Chr(34) & ")"
scriptFile.Close

' ======== Run.bat ========
Set runFile = fso.CreateTextFile(langDir & "\run.bat", True)
runFile.WriteLine "@echo off"
runFile.WriteLine "wscript.exe indexForLanguage.vbs"
runFile.Close

MsgBox "Linguagem criada com sucesso!" & vbCrLf & _
       "Pasta: " & langDir, vbInformation, "ADLANG IDE"


