#rimozzione password all'utente
Set-LocalUser -name Delta -Password ([securestring]::new())
Set-LocalUser -Name "Delta" -PasswordNeverExpires $true # imposto la password dell'utente locale per non scadere mai


#modifica chiavi di registro per le richieste delle impostazioni di privacy
# usare il percorso corretto sotto HKLM:\
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force

# prova di modifica regione pre desktop
Set-TimeZone -id "W. Europe Standard Time"
$region = "it-IT"
Set-Culture $region
Set-WinSystemLocale $region
Set-WinUserLanguageList $region, "it-IT" -force -wa silentlycontinue
Set-WinHomeLocation 118
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
net start w32time
w32tm /resync

# creo cartella management per scaricare script e programmi necessari
mkdir "C:\management\" | Set-Location 

#controllo connesione internet ed eventuale connessione a wifi predefinita
If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
 $LASTEXITCODE = 0
}
else {
  $ProfileName = "DELTAMOBILE"
  $Password = "GigaFiniti2022"

  # creazione del profilo wifi
  $WProfile = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
  <name>$ProfileName</name>
  <SSIDConfig>
    <SSID>
      <name>$ProfileName</name>
    </SSID>
  </SSIDConfig>
  <connectionType>ESS</connectionType>
  <connectionMode>auto</connectionMode>
  <MSM>
    <security>
      <authEncryption>
        <authentication>WPA2PSK</authentication>
        <encryption>AES</encryption>
        <useOneX>false</useOneX>
      </authEncryption>
      <sharedKey>
        <keyType>passPhrase</keyType>
        <protected>false</protected>
        <keyMaterial>$Password</keyMaterial>
      </sharedKey>
    </security>
  </MSM>
</WLANProfile>
"@

  # percorso file
  $filePath = "$env:USERPROFILE\$ProfileName.xml"

  # Salva il profilo (ignora errori)
  $WProfile | Out-File -FilePath $filePath -Encoding UTF8 2>$null

  # Aggiunge il profilo Wi-Fi (ignora errori)
  netsh wlan add profile filename="$filePath" user=all | Out-Null

  # Prova a connettersi (non blocca mai lo script)
  netsh wlan connect name="$ProfileName" | Out-Null

  $LASTEXITCODE = 0
}

if ($LASTEXITCODE -eq 0) {
    # attesa 30 secondi per stabilire la connessione
    Start-Sleep -Seconds 30 

    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\management\update.ps1' # scarico script di update
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/4_config.ps1' -OutFile 'C:\management\config.ps1' # scarico script di configurazione
    Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "C:\Users\Public\Desktop\teleassistenza.exe" #scarico programma teleassistenza
    Invoke-WebRequest 'https://github.com/valeDelta/ppkg/raw/refs/heads/main/netscan.exe' -OutFile "C:\management\netscan.exe" # scarico netscan
  }

# disabilito fastboot
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Type DWord

# rimozione lingua olandese se presente (possibile non necessario)
$LangList = Get-WinUserLanguageList
if ($LangList.languagetag -ccontains "nl-NL") {
  $MarkedLang = $LangList | Where-Object LanguageTag -eq "nl-NL"
  $LangList.Remove($MarkedLang)
  Set-WinUserLanguageList $LangList -Force
}