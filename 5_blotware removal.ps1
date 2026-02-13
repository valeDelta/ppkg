Get-AppxPackage -all Microsoft.YourPhone | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.Xbox.TCUI | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.MicrosoftOfficeHub | Remove-AppxPackage -AllUsers
Get-AppxPackage -all MicrosoftCorporationII.MicrosoftFamily | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.XboxGamingOverlay | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.Todos | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Clipchamp.Clipchamp | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.PowerAutomateDesktop | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.GamingApp | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.Windows.DevHome | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.XboxIdentityProvider | Remove-AppxPackage -AllUsers
Get-AppxPackage -all MSTeams | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.OutlookForWindows | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Dell.SupportAssistforPCs | Remove-AppxPackage -AllUsers
Get-AppxPackage -all McAfeeWPSSparsePackage | Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.Copilot| Remove-AppxPackage -AllUsers
Get-AppxPackage -all Microsoft.XboxGameCallableUI | Remove-AppxPackage -AllUsers


#disinstall mcafee
Set-Location "C:\Program Files\McAfee\WebAdvisor"
.\uninstaller.exe /s
Set-Location "C:\Program Files\McAfee"
Set-Location "C:\Program Files\McAfee\wps\1.*"
.\mc-update.exe -uninstall /silent /force
