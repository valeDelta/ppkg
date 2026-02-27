#rimozzione password all'utente
Set-LocalUser -name Delta -Password ([securestring]::new())
Set-LocalUser -Name "Delta" -PasswordNeverExpires $true # imposto la password dell'utente locale per non scadere mai

#modifica chiavi di registro per le richieste delle impostazioni di privacy
# usare il percorso corretto sotto HKLM:\
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force

#controllo connesione internet ed eventuale connessione a wifi predefinita
If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    
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

    #netsh wlan set profileorder name="$ProfileName" interface="Wi-Fi" priority=1

    #netsh wlan set profileparameter name="$ProfileName" connectionmode=auto

    # Export the profile to an XML file
    # salvare in UTF8 per compatibilità con netsh
    $WProfile | Out-File -FilePath "$env:USERPROFILE\$ProfileName.xml" -Encoding UTF8

    # Add the profile to the Wi-Fi interface
    netsh wlan add profile filename="$env:USERPROFILE\$ProfileName.xml" user=all

    # Connect to the Wi-Fi network
    netsh wlan connect name="$ProfileName"
}

# attesa 30 secondi per stabilire la connessione
Start-Sleep -Seconds 30 

mkdir "C:\management\" | Set-Location 
Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\management\update.ps1' # scarico script di update
Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/4_config.ps1' -OutFile 'C:\management\config.ps1' # scarico script di configurazione
Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "C:\Users\Public\Desktop\teleassistenza.exe" #scarico programma teleassistenza
Invoke-WebRequest 'https://github.com/valeDelta/ppkg/raw/refs/heads/main/netscan.exe' -OutFile "C:\management\netscan.exe" # scarico netscan


# disabilito fastboot
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0

# rimozione lingua olandese se presente (possibile non necessario)
$LangList = Get-WinUserLanguageList
if ($LangList.languagetag -ccontains "nl-NL") {
    $MarkedLang = $LangList | Where-Object LanguageTag -eq "nl-NL"
    $LangList.Remove($MarkedLang)
    Set-WinUserLanguageList $LangList -Force
}