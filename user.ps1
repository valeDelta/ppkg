$username = "Saidea"
$password = ConvertTo-SecureString "SaleChimico.18!" -AsPlainText -Force 
New-LocalUser -Name $username -Password $password -FullName $username

Add-LocalGroupMember -Group "Administrators" -Member "Saidea"


$username = "Utente"
New-LocalUser -Name $username -FullName $username

Add-LocalGroupMember -Group "Administrators" -Member "Utente"




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
