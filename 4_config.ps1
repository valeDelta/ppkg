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


# scarico la teleassistenza
if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") { 
    Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"
    Invoke-WebRequest 'https://github.com/valeDelta/ppkg/raw/refs/heads/main/netscan.exe' -OutFile "C:\management\netscan.exe"
}

# inserimento password all'account admin locale
$pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
if ($pass -eq "") { 
    Set-LocalUser -Name "DeltaAdmin" -PasswordNeverExpires $TRUE
}
else {
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    Set-LocalUser -Name "DeltaAdmin" -Password $password -FullName "DeltaAdmin" -AccountNeverExpires -PasswordNeverExpires $True
}

$q = Read-Host "si vuole installare total commander? (y/n)"
if ($q -eq "y") { 
    Invoke-WebRequest 'https://totalcommander.ch/1156/newcert/tcmd1156x64.exe' -OutFile "c:\management\totalcmd.exe"
    Start-Process -FilePath 'C:\management\totalcmd.exe' -ArgumentList '/S'
}
elseif ($q -eq "n") {
    continue
}

# installazione programmi basilari
#winget install Google.Chrome
winget install 7zip.7zip

# disabilito fastboot
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0

# scarico e eseguo bat per rimozione applicazioni di default
if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/test.bat' -OutFile "c:\management\rimozione.bat"
    Start-Process -FilePath 'C:\management\rimozione.bat' -Verb RunAs
}

pause