#rimozzione password all'utente
Set-LocalUser -name Utente -Password ([securestring]::new())

#modifica chiavi di registro per le richieste delle impostazioni di privacy
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_L:\Control PaOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force 

#configuro la regione oraria e lingua 
Set-TimeZone "W. Europe Standard Time"
Set-WinHomeLocation -GeoId 118
Set-WinUILanguageOverride -Language it-IT
Set-Culture it-IT
Set-WinUserLanguageList it-IT -force

If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    mkdir "C:\temp\" | Set-Location 
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\temp\update.ps1'
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile 'C:\temp\sara.zip'
    Expand-Archive 'C:\temp\sara.zip' 'C:\temp\' -Force
    Rename-Item 'C:\temp\SaRAcmd-main' 'C:\temp\SaRAcmd' -Force
}
else{
    exit
}


#cambio directory nella chiavetta e copio la cartella di sara e il file di update
<#
'{0}:\' -f (Get-VOlume | ? DriveType -eq 'Removable').DriveLetter | cd
Copy-Item -Path ".\applicativi\SaRAcmd" -Destination C:\temp\SaRAcmd -Recurse -Force
Copy-Item -Path ".\update.ps1" -Destination C:\temp\update.ps1 -Recurse -Force
#>