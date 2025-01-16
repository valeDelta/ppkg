cd C:\temp\SaRAcmd

If ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") {
     .\SaRAcmd -S OfficeScrubScenario -AcceptEula -OfficeVersion All
}
else{
    exit
}

