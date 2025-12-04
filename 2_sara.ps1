$MA = "C:\management" # percorso cartella management
If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    Set-Location "$MA"
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile "$MA\sara.zip"
    Expand-Archive "$MA\sara.zip" "$MA\" -Force
    Rename-Item "$MA\SaRAcmd-main" "$MA\SaRAcmd" -Force
    if (Get-ChildItem -Path "$MA" -Filter "SaRAcmd") {
        Set-Location "$MA\SaRAcmd"
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