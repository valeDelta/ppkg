Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
pause

$PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False



function set-delta {
    $username = "DeltaAdmin"
    $password = ConvertTo-SecureString Read-Host "Inserire la password per l'utente DeltaAdmin" -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
}
function set-saidea {
    $username = "Sadiea"
    $password = ConvertTo-SecureString Read-Host "Inserire la password per l'utente Saidea" -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
}

$client = Read-Host "
che utente locale vuoi creare?:
1: delta
2: saidea
3: lasciare utente locale
"

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


Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"

Remove-Item -Path C:\temp\config.ps1 -Recurse