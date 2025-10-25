@echo off
REM unregister.bat - Remove associação de arquivos .ad
echo Removendo associação .ad (somente se foi criada por este script)...

assoc .ad=
reg delete "HKCR\.ad" /f >nul 2>&1
reg delete "HKCR\ADLANGFile" /f >nul 2>&1

echo Associação removida.
pause
