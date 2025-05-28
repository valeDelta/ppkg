If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
    mkdir "C:\temp\" | Set-Location 
    Invoke-WebRequest 'https://github.com/valeDelta/SaRAcmd/archive/refs/heads/main.zip' -OutFile 'C:\temp\sara.zip'
    Expand-Archive 'C:\temp\sara.zip' 'C:\temp\' -Force
    Rename-Item 'C:\temp\SaRAcmd-main' 'C:\temp\SaRAcmd' -Force
    if(Get-ChildItem -Path "C:\temp" -Filter "SaRAcmd"){
        Set-Location C:\temp\SaRAcmd

        If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
        .\SaRAcmd -S OfficeScrubScenario -AcceptEula -OfficeVersion All
        }
        else{
            exit
        }
    }
    else{
        exit
    }
}
else{
    exit
}