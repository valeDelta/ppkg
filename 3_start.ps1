if (Get-ChildItem -Path "C:\management" -Filter "config.ps1") { #controllo se esistono gli script di configurazione e update
    Set-ExecutionPolicy Unrestricted -Scope LocalMachine

    # creo le azioni da eseguire
    $action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\management\config.ps1 -WindowStyle Maximized"
    $action1 = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument "C:\management\update.ps1 -WindowStyle Hidden"
    
    #creo il trigger e impostazioni per l'attività
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $task = New-ScheduledTaskPrincipal -RunLevel Highest -UserId DeltaAdmin

    # registro le attività
    Register-ScheduledTask -Action $action -Trigger $trigger -Principal $task -TaskName "continue"
    Register-ScheduledTask -Action $action1 -Trigger $trigger -Principal $task -TaskName "update"
} 
else { 
    exit
}