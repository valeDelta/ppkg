If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    Set-Location "C:\management\"
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile 'C:\management\sara.zip'
    Expand-Archive 'C:\management\sara.zip' 'C:\management\' -Force
    Rename-Item 'C:\management\SaRAcmd-main' 'C:\management\SaRAcmd' -Force
    if (Get-ChildItem -Path "C:\management" -Filter "SaRAcmd") {
        Set-Location C:\management\SaRAcmd
        .\SaRAcmd -S OfficeScrubScenario -AcceptEula -OfficeVersion All
    }
    else {
        exit
    }

    # rimosso l'eliminazione di sara
    # Set-Location C:\
    # Remove-Item -Path C:\management\sara.zip -Recurse
    # Remove-Item -Path C:\management\SaRAcmd -Recurse
}
else {
    exit
}