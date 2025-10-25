@echo off
REM register.bat - Registra a associação de arquivos .ad para run.exe (deve ser executado com privilégios de usuário)
SETLOCAL ENABLEDELAYEDEXPANSION

REM Caminho do run.exe (local do batch)
SET "RUN=%~dp0run.exe"
REM Remove barra final se houver
IF "%RUN:~-1%"=="\" SET "RUN=%RUN:~0,-1%"

echo Registrando associação de arquivo .ad para: "%RUN%"
assoc .ad=ADLANGFile

REM Define comando de abertura (usa aspas e %%1 como argumento para o arquivo)
ftype ADLANGFile="%RUN%" "%%1"

REM Registra também no Registro (melhora compatibilidade com Explorador)
reg add "HKCR\.ad" /ve /d "ADLANGFile" /f >nul 2>&1
reg add "HKCR\ADLANGFile\DefaultIcon" /ve /d "%RUN%,0" /f >nul 2>&1
reg add "HKCR\ADLANGFile\shell\open\command" /ve /d "\"%RUN%\" \"%%1\"" /f >nul 2>&1

echo Associação criada com sucesso.
echo.
echo Dica: se quiser desfazer, execute unregister.bat neste mesmo diretório.
pause
