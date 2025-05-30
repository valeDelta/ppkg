﻿Unregister-ScheduledTask -TaskName "update" -Confirm:$False

# Set-WinUserLanguageList it-IT -force
# Set-WinHomeLocation -GeoId 118
# Set-Culture it-IT
# Set-TimeZone -id "W. Europe Standard Time"
# Set-WinUILanguageOverride -Language it-IT


Install-PackageProvider -Name Nuget -force -Scope CurrentUser
Install-Module -Name PSWindowsUpdate -force -Scope CurrentUser
Import-Module PSWindowsUpdate
Set-Location -Path C:\Windows\System32
Get-WindowsUpdate -Install -AcceptAll


Remove-Item -Path C:\temp\update.ps1 -Recurse

Write-Information "Update completato, controllare comuque windows update"
Pause