#'{0}:\' -f (Get-VOlume | Where-Object DriveType -eq 'Removable').DriveLetter | Set-Location

# creo le azioni da eseguire
Set-ExecutionPolicy Unrestricted -Scope LocalMachine
#$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "D:\prova.ps1 -WindowStyle Maximized"
$action1 = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\temp\update.ps1 -WindowStyle Maximized"

#creo il trigger e impostazioni per l'attività
$trigger = New-ScheduledTaskTrigger -AtLogOn
$task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId Utente

# registro le attività
#Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "continue"
Register-ScheduledTask -Action $action1 -Trigger $trigger -Principal $task -TaskName "update"