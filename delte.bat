@set @x=0; /*
@echo off
ver |>NUL find /v "5." && if "%~1"=="" cscript.exe //nologo //e:jscript "%~f0"& exit /b
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="pers"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="nut" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="nut" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="nut"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="per"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="nur" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="nur" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="nur"' DELETE
wmic product where name="Wazuh Agent" call uninstall /nointeractive
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\spoolsv.exe" /v Debugger /f
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe" /v Debugger /f
taskkill /f /IM StartMenuExperienceHost.exe /t
takeown /f C:\ProgramData\USOShared
cacls C:\ProgramData\USOShared /e /c /g %username%:f
takeown /f C:\ProgramData\Reference
cacls C:\ProgramData\Reference /e /c /g %username%:f
schtasks /Delete /TN "\FoxsUpdate" /F
schtasks /Delete /TN "\AutoUpdate" /F
schtasks /Delete /TN "\UpdateDir" /F
schtasks /Delete /TN "\DirectUpdate" /F
schtasks /Delete /TN "\UpdateDirect" /F
schtasks /Delete /TN "\UpdateTaskMachine" /F
attrib -h -s -r C:\ProgramData\Packag /d /s
attrib -h -s -r C:\ProgramData\Dackag /d /s
attrib -h -s -r C:\ProgramData\USOShared /d /s
attrib -h -s -r C:\ProgramData\Reference /d /s
rd /S /Q \\.\C:\ProgramData\NUL..\
rd /S /Q \\.\C:\ProgramData\Package..\
rd /S /Q \\.\C:\ProgramData\Dackage..\
rd /S /Q \\.\C:\ProgramData\Distribution..\
rd /S /Q \\.\C:\ProgramData\USOShared\NUL.{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}
rd /S /Q C:\ProgramData\Classic.{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}
rd /S /Q C:\ProgramData\Packag
rd /S /Q C:\ProgramData\Dackag
rd /S /Q C:\ProgramData\Reference
rd /S /Q C:\ProgramData\SoftwareDistribution
del /S /Q C:\ProgramData\USOShared\store.vbs
del /S /Q C:\ProgramData\USOShared\libssl-1_1.dll
del /S /Q C:\ProgramData\USOShared\libcrypto-1_1.dll 
del /S /Q C:\ProgramData\USOShared\StartMenuExperienceHost.exe
del /S /Q C:\ProgramData\VC_redist.x86.exe
del /S /Q %tmp%\wazuh-agent-4.7.0-1.msi && RD /S /Q "C:\Program Files (x86)\ossec-agent"
del/a/f "%~f0"
exit /B 
::
*/new ActiveXObject('Shell.Application').ShellExecute (WScript.ScriptFullName,'Admin','','runas',1);