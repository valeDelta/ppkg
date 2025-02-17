Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
pause

#da rimuovere nella prossima versione del ppkg 1.5
Set-TimeZone -id "W. Europe Standard Time"
Set-WinUserLanguageList it-IT -force
Set-WinHomeLocation -GeoId 118
Set-Culture it-IT

$PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False



function set-delta {
    $username = "DeltaAdmin"
    $pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
}
function set-saidea {
    $username = "Sadiea"
    $pass = Read-Host "Inserire la password per l'utente Saidea"
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
}

$client = Read-Host "
che utente locale vuoi creare?:
1: delta
2: saidea
3: lasciare utente locale
"

Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"

Remove-Item -Path C:\temp\config.ps1 -Recurse

 Switch ($client)
{
    "1"  { 
        set-delta
     }
    "2"{ 
       set-saidea
     }
     "3"{
        exit
     }
}