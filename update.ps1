# #rimuovere le seguenti righe con la nuova versione del ppkg
# Set-WinHomeLocation -GeoId 118
# Set-WinUILanguageOverride -Language it-IT
# Set-Culture it-IT
# Set-WinUserLanguageList it-IT -force


Unregister-ScheduledTask -TaskName "update" -Confirm:$False

Install-PackageProvider -Name Nuget -force -Scope CurrentUser
Install-Module -Name PSWindowsUpdate -force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install

Set-Location C:\
Remove-Item -Path C:\temp\sara.zip -Recurse
Remove-Item -Path C:\temp\SaRAcmd -Recurse
Remove-Item -Path C:\temp\update.ps1 -Recurse