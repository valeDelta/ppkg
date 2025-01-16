Set-WinHomeLocation -GeoId 118
Set-WinUILanguageOverride -Language it-IT
Set-Culture it-IT

Unregister-ScheduledTask -TaskName update -Confirm:$False

Install-PackageProvider -Name Nuget -force -Scope CurrentUser
Install-Module -Name PSWindowsUpdate -force -Scope CurrentUser
Import-Module PSWindowsUpdate
Get-WindowsUpdate -AcceptAll -Install

Set-Location C:\
Remove-Item -Path C:\temp -Recurse

Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile 'C:\Users\Public\Desktop\teleassistenza.exe'

