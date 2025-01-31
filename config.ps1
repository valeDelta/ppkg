Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
pause

$PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False

Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile 'C:\Users\Public\Desktop\teleassistenza.exe'

Remove-Item -Path C:\temp\config.ps1 -Recurse