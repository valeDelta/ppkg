Unregister-ScheduledTask -TaskName "update" -Confirm:$False

Install-PackageProvider -Name Nuget -force -Scope CurrentUser
Install-Module -Name PSWindowsUpdate -force -Scope CurrentUser
Import-Module PSWindowsUpdate
Set-Location -Path C:\Windows\System32
Get-WindowsUpdate -Install -AcceptAll


Remove-Item -Path C:\temp\update.ps1 -Recurse

Write-Information "Update completato, controllare comuque windows update"
Pause