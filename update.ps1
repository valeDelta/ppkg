Unregister-ScheduledTask -TaskName "update" -Confirm:$False

Install-PackageProvider -Name Nuget -force -Scope CurrentUser
Install-Module -Name PSWindowsUpdate -force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install

Set-Location C:\
Remove-Item -Path C:\temp\sara.zip -Recurse
Remove-Item -Path C:\temp\SaRAcmd -Recurse
Remove-Item -Path C:\temp\update.ps1 -Recurse

Write-Information "Update completato, controllare comuque windows update"
Pause