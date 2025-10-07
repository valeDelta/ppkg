Unregister-ScheduledTask -TaskName "update" -Confirm:$False

Install-PackageProvider -Name Nuget -Confirm:$false -Force

Install-Module -Name PSWindowsUpdate -Confirm:$false -Force
# Import-Module PSWindowsUpdate
# Set-Location -Path C:\Windows\System32
Get-WindowsUpdate

Install-WindowsUpdate -AcceptAll -Install -IgnoreReboot | Select-Object KB, Result, Title, Size


# Remove-Item -Path C:\temp\update.ps1 -Recurse

Write-Information "Update completato, controllare comuque windows update"
Pause