# Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
#pause

# $PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False

#non funziona se non sul desktop
#Set-WinHomeLocation -GeoId 118

# Imposta GeoID (Nazione) su 118 = Italia

Write-Host "Imposto GeoID per nuovo profilo utente (HKU\.DEFAULT)..."
Set-ItemProperty -Path "HKU\.DEFAULT\Control Panel\International\Geo" -Name Nation -Value 118

Write-Host "Imposto GeoID per utente corrente (HKCU)..."
Set-ItemProperty -Path "HKCU:\Control Panel\International\Geo" -Name Nation -Value 118

Write-Host "Fatto. Riavvia il sistema se vuoi assicurarti che tutto venga preso."

#sync time
net start w32time
w32tm /resync


# function remove {
#     param (
#         $username
#     )
#     $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "Unregister-ScheduledTask -TaskName 'remove' -Confirm:$False"
#     $action1 = new-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "remove-localuser -Name '$username' -confirm:$false"
#     $trigger = New-ScheduledTaskTrigger -AtLogOn -User "$username"
#     $task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId "$username"
#     Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "remove"
#     Register-ScheduledTask -Action $action1 -Trigger $trigger -Principal $task -TaskName "remove1"



# }
# function set-delta {
#     $username = "DeltaAdmin"
#     $pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
#     $password = ConvertTo-SecureString $pass -AsPlainText -Force 
#     New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
#     Add-LocalGroupMember -Group "Administrators" -Member $username
#     remove($username)   
# }

# Set-Location C:\Windows\System32
# $username = "Saidea"
# $pass = Read-Host "Inserire la password per l'utente Saidea"
# if($null -eq $pass) { $password = ([securestring]::new()) }
# else {$password = ConvertTo-SecureString $pass -AsPlainText -Force }
# New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
# Add-LocalGroupMember -Group "Administrators" -Member $username
# remove("Utente")
# Pause


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