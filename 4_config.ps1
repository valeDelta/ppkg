# Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
#pause

$PD = "C:\Users\Public\Desktop"
# $APP = "D:\applicativi\generali"

Unregister-ScheduledTask -TaskName "continue" -Confirm:$False

Set-LocalUser -Name "Utente" -PasswordNeverExpires $true

#non funziona se non sul desktop
$region = "it-IT"
Set-Culture $region
Set-WinSystemLocale $region
Set-WinUserLanguageList $region, "it-IT" -force -wa silentlycontinue
Set-WinHomeLocation 118
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

#sync time
net start w32time
w32tm /resync

Get-AppxPackage -AllUsers "MSTeams" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider" | -AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.Copilot" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxGamingOverlay" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage -AllUsers
Get-AppxPackage -AllUsers "Microsoft.XboxGameCallableUI" | Remove-AppxPackage -AllUsers
Get-AppPackage -AllUsers "Microsoft.GamingApp" | Remove-AppPackage -AllUsers
Get-AppPackage -AllUsers "Microsoft.OutlookForWindows" | Remove-AppPackage -AllUsers


if ((Get-NetConnectionProfile).IPv4Connectivity -contains "Internet" -or (Get-NetConnectionProfile).IPv6Connectivity -contains "Internet") { 
    Invoke-WebRequest 'https://logins.livecare.net/liveletexecustomunified/GSTTQX6918RZR83K' -OutFile "$PD\teleassistenza.exe"
    Set-Location "C:\temp\"
}


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

function set-saidea {
    $username = "Saidea"
    $pass = Read-Host "Inserire la password per l'utente Saidea"
    if ($pass -eq "") { 
        New-LocalUser -Name $username -FullName $username -AccountNeverExpires -NoPassword
        $adsi = [ADSI]"WinNT://$env:COMPUTERNAME/$username,user"
        $adsi.Put("PasswordExpired", 0)
        $adsi.SetInfo()
        Set-LocalUser -Name $username -PasswordNeverExpires $TRUE
    }
    else {
        $password = ConvertTo-SecureString $pass -AsPlainText -Force 
        New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
    }
    Add-LocalGroupMember -Group "Administrators" -Member $username
    Write-Warning "ricordarsi di cancellare l'utente 'Utente' "
    Pause
}

function set-delta {
    $username = "DeltaAdmin"
    $pass = Read-Host "Inserire la password per l'utente DeltaAdmin"
    if ($pass -eq "") { 
        New-LocalUser -Name $username -FullName $username -AccountNeverExpires -NoPassword
        $adsi = [ADSI]"WinNT://$env:COMPUTERNAME/$username,user"
        $adsi.Put("PasswordExpired", 0)
        $adsi.SetInfo()
        Set-LocalUser -Name $username -PasswordNeverExpires $TRUE
    }
    else {
        $password = ConvertTo-SecureString $pass -AsPlainText -Force 
        New-LocalUser -Name $username -Password $password -FullName $username -AccountNeverExpires -PasswordNeverExpires
    }
    Add-LocalGroupMember -Group "Administrators" -Member $username
    Write-Warning "ricordarsi di cancellare l'utente 'Utente' "
    Pause
}


$client = Read-Host "
che utente locale vuoi creare?:
1: saidea
2: delta
3: lasciare utente locale
"

# Remove-Item -Path C:\temp\config.ps1 -Recurse

Switch ($client) {
    "1" { 
        set-saidea
    }
    "2" { 
        set-delta
       
    }
    "3" {
        exit
    }
}