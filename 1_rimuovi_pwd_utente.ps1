#rimozzione password all'utente
Set-LocalUser -name DeltaAdmin -Password ([securestring]::new())

#modifica chiavi di registro per le richieste delle impostazioni di privacy
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "PrivacyConsentStatus" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipMachineOOBE" -Value 1 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "ProtectYourPC" -Value 3 -PropertyType DWORD -Force 
New-ItemProperty -Path "HKLM:\HKEY_L:\Control PaOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" -Name "SkipUserOOBE" -Value 1 -PropertyType DWORD -Force 

If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    mkdir "C:\management\" | Set-Location 
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/update.ps1' -OutFile 'C:\management\update.ps1'
    Invoke-WebRequest 'https://raw.githubusercontent.com/valeDelta/ppkg/refs/heads/main/4_config.ps1' -OutFile 'C:\management\config.ps1'
    
    $LangList = Get-WinUserLanguageList
    if ($LangList.languagetag -ccontains "nl-NL") {
        $MarkedLang = $LangList | Where-Object LanguageTag -eq "nl-NL"
        $LangList.Remove($MarkedLang)
        Set-WinUserLanguageList $LangList -Force
    }

    
}
else {
    exit
}