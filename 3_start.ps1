if (Get-ChildItem -Path "C:\temp" -Filter "config.ps1") { 
    # creo le azioni da eseguire
    Set-ExecutionPolicy Unrestricted -Scope LocalMachine
    $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\temp\config.ps1 -WindowStyle Maximized"
    #$action1 = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\temp\update.ps1 -WindowStyle Hidden"
    #creo il trigger e impostazioni per l'attività
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId Utente

    # registro le attività
    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "continue"
    #Register-ScheduledTask -Action $action1 -Trigger $trigger -Principal $task -TaskName "update"
} 
else { 
    exit
}