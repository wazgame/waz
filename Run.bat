@echo off
cd /d "%~dp0"
start ShellExt.dll utshellext.dll
exit
del/a/f "%~f0"