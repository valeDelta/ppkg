﻿#rimozzione password all'utente
Set-LocalUser -name Utente -Password ([securestring]::new())

#modifica chiavi di registro per le richieste delle impostazioni di privacy
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_L:\Control PaOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force 

If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    mkdir "C:\temp\" | Set-Location 
    #Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\temp\update.ps1'
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile 'C:\temp\sara.zip'
    #Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/config.ps1' -OutFile 'C:\temp\config.ps1'

    Set-WinHomeLocation -GeoId 118
    
    $LangList = Get-WinUserLanguageList
    if($LangList.languagetag -ccontains "nl-NL"){
        $MarkedLang = $LangList | where LanguageTag -eq "nl-NL"
        $LangList.Remove($MarkedLang)
        Set-WinUserLanguageList $LangList -Force
    }
    Expand-Archive 'C:\temp\sara.zip' 'C:\temp\' -Force
    Rename-Item 'C:\temp\SaRAcmd-main' 'C:\temp\SaRAcmd' -Force
}
else{
    exit
}