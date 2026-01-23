#rimozzione password all'utente
Set-LocalUser -name DeltaAdmin -Password ([securestring]::new())

#modifica chiavi di registro per le richieste delle impostazioni di privacy
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_L:\Control PaOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force 

#controllo connesione internet ed eventuale connessione a wifi predefinita
If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    continue
}
else {
    $ProfileName = "DELTAMOBILE"
    $Password = "GigaFiniti2022"

    # creazione del profilo wifi
    $Profile = @"
<?xml version="1.0"?>
<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1">
  <name>$ProfileName</name>
  <SSIDConfig>
    <SSID>
      <name>$ProfileName</name>
    </SSID>
  </SSIDConfig>
  <connectionType>ESS</connectionType>
  <connectionMode>manual</connectionMode>
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

    # Export the profile to an XML file
    $Profile | Out-File -FilePath "$env:USERPROFILE\$ProfileName.xml"

    # Add the profile to the Wi-Fi interface
    netsh wlan add profile filename="$env:USERPROFILE\$ProfileName.xml"

    # Connect to the Wi-Fi network
    netsh wlan connect name="$ProfileName"
}

# attesa 30 secondi per stabilire la connessione
Start-Sleep -Seconds 30 

mkdir "C:\management\" | Set-Location 
Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\management\update.ps1' # scarico script di update
Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/4_config.ps1' -OutFile 'C:\management\config.ps1' # scarico script di configurazione
    
# rimozione lingua olandese se presente (possibile non necessario)
$LangList = Get-WinUserLanguageList
if ($LangList.languagetag -ccontains "nl-NL") {
    $MarkedLang = $LangList | Where-Object LanguageTag -eq "nl-NL"
    $LangList.Remove($MarkedLang)
    Set-WinUserLanguageList $LangList -Force
}