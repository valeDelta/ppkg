Unregister-ScheduledTask -TaskName "continue" -Confirm:$False #elimino l'attività pianificata

# impostazioni lingua, regione, fuso orario e sincronizzazione orologio
Set-TimeZone -id "W. Europe Standard Time"
$region = "it-IT"
Set-Culture $region
Set-WinSystemLocale $region
Set-WinUserLanguageList $region, "it-IT" -force -wa silentlycontinue
Set-WinHomeLocation 118
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
net start w32time
w32tm /resync

# inserimento password all'account admin locale
$pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
if ($pass -eq "") { 
    Set-LocalUser -Name "DeltaAdmin" -PasswordNeverExpires $TRUE
}
else {
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    Set-LocalUser -Name "DeltaAdmin" -Password $password -FullName "DeltaAdmin" -AccountNeverExpires -PasswordNeverExpires $True
}

# controllo connesione internet per scaricare programmi aggiuntivi
if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") { 
    

    #richiesta installazione total commander
    # $q = Read-Host "si vuole installare total commander? (y/n)"
    # if ($q -eq "y") { 
    #     Invoke-WebRequest 'https://totalcommander.ch/1156/newcert/tcmd1156x64.exe' -OutFile "$MA\totalcmd.exe"
    #     Start-Process -FilePath "$MA\totalcmd.exe" -ArgumentList '/S'
    # }

    # installazione programmi basilari tramite winget
    winget install 7zip.7zip
    winget update --all

    # scarico ed eseguo bat per rimozione applicazioni di default (incerto se funziona o meno)
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/5_blotware%20removal.ps1' -OutFile "$MA\rimozione.ps1"
    Start-Process powershell.exe -ArgumentList "C:\management\rimozione.ps1"

}

pause