If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    Set-Location "C:\temp\"
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile 'C:\temp\sara.zip'
    Expand-Archive 'C:\temp\sara.zip' 'C:\temp\' -Force
    Rename-Item 'C:\temp\SaRAcmd-main' 'C:\temp\SaRAcmd' -Force
    if(Get-ChildItem -Path "C:\temp" -Filter "SaRAcmd"){
        Set-Location C:\temp\SaRAcmd
        .\SaRAcmd -S OfficeScrubScenario -AcceptEula -OfficeVersion All
    }
    else{
        exit
    }
    Set-Location C:\
    Remove-Item -Path C:\temp\sara.zip -Recurse
    Remove-Item -Path C:\temp\SaRAcmd -Recurse
}
else{
    exit
}