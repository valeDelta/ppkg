# Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
#pause

# $PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False

#non funziona se non sul desktop
Set-WinHomeLocation -GeoId 118

#sync time
net start w32time
w32tm /resync


# function remove {
#     param (
#         $username
#     )
#     $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "Unregister-ScheduledTask -TaskName 'remove' -Confirm:$False
#     remove-localuser -Name '$username' -confirm:$false"
#     $trigger = New-ScheduledTaskTrigger -AtLogOn -User "$username"
#     $task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId $username
#     Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "remove"
# }
# function set-delta {
#     $username = "DeltaAdmin"
#     $pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
#     $password = ConvertTo-SecureString $pass -AsPlainText -Force 
#     New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
#     Add-LocalGroupMember -Group "Administrators" -Member $username
#     remove($username)   
# }
# function set-saidea {
#     Set-Location C:\Windows\System32
#     $username = "Saidea"
#     $pass = Read-Host "Inserire la password per l'utente Saidea"
#     if($null -eq $pass) { $password = ([securestring]::new()) }
#     else {$password = ConvertTo-SecureString $pass -AsPlainText -Force }
#     New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
#     Add-LocalGroupMember -Group "Administrators" -Member $username
#     #remove($"Utente")
#     Pause
# }

# $client = Read-Host "
# che utente locale vuoi creare?:
# 1: delta
# 2: saidea
# 3: lasciare utente locale
# "
# if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") { 
#     Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"
# }

# Remove-Item -Path C:\temp\config.ps1 -Recurse

#  Switch ($client)
# {
#     "1"  { 
#         set-delta
#      }
#     "2"{ 
#        set-saidea
#        pause
#      }
#      "3"{
#         exit
#      }
# }