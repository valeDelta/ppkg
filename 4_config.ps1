# Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
#pause

$PD = "C:\Users\Public\Desktop"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False

Set-LocalUser -Name "DeltaAdmin" -PasswordNeverExpires $true

#non funziona se non sul desktop
Set-TimeZone -id "W. Europe Standard Time"
$region = "it-IT"
Set-Culture $region
Set-WinSystemLocale $region
Set-WinUserLanguageList $region, "it-IT" -force -wa silentlycontinue
Set-WinHomeLocation 118
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True


#sync time
net start w32time
w32tm /resync


# disinstalla applicazioni inutili?
Get-AppxPackage -AllUsers "MSTeams" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider" | -AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.Copilot" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxGamingOverlay" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxGameCallableUI" | Remove-AppxPackage -AllUsers
Get-AppPackage -AllUsers "Microsoft.GamingApp" | Remove-AppPackage -AllUsers
Get-AppPackage -AllUsers "Microsoft.OutlookForWindows" | Remove-AppPackage -AllUsers

# test controllo esistenza pacchetti
# if (Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI" ){
#     echo "il pacchetto c'è"
# }
# else {
#     echo "il pacchetto non c'è"
# }

# scarico la teleassistenza
if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") { 
    Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"
}

# inserimento password all'account admin locale
$pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
if ($pass -eq "") { 
    Set-LocalUser -Name "DeltaAdmin" -PasswordNeverExpires $TRUE
}
else {
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    Set-LocalUser -Name "DeltaAdmin" -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires $True
}

pause