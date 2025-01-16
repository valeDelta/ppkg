$username = "Saidea"
$password = ConvertTo-SecureString "SaleChimico.18!" -AsPlainText -Force 
New-LocalUser -Name $username -Password $password -FullName $username

Add-LocalGroupMember -Group "Administrators" -Member "Saidea"


$username = "Utente"
New-LocalUser -Name $username -FullName $username

Add-LocalGroupMember -Group "Administrators" -Member "Utente"