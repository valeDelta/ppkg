Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
pause

$PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False


function remove {
    param (
        $username
    )
    $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "Unregister-ScheduledTask -TaskName 'remove' -Confirm:$False
    remove-localuser -Name '$username' -confirm:$false"
    $trigger = New-ScheduledTaskTrigger -AtLogOn -User "$username"
    $task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId $username
    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "remove"
}
function set-delta {
    $username = "DeltaAdmin"
    $pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
    remove($username)   
}
function set-saidea {
    $username = "Saidea"
    $pass = Read-Host "Inserire la password per l'utente Saidea"
    $password = ConvertTo-SecureString $pass -AsPlainText -Force 
    New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
    Add-LocalGroupMember -Group "Administrators" -Member $username
    remove($username)
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