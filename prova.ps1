Write-Warning "Prima di eseguire lo script controllare che il PC sia collegato ad una rete internet"
pause

$PD = "C:\Users\Public\Desktop"
$APP = "D:\applicativi\generali"
Unregister-ScheduledTask -TaskName continue -Confirm:$False
Unregister-ScheduledTask -TaskName update -Confirm:$False

Set-WinHomeLocation -GeoId 118
Set-WinUILanguageOverride -Language it-IT
Set-Culture it-IT

function Set-generico {
 #utente gia creato
 #probabile ninite gia fatto
    Write-Output "gen"
    exit
}


function interno {
    Write-Output "preparo il computer per uso interno"

    $path = "D:\applicativi\interno"

    $name = Read-Host "Inserire nuovo nome PC"

    Start-Process -wait -FilePath "$path\Notes_1101_Win_Italian.exe" -ArgumentList '/S /v"/qb+"'
    Start-Process -Wait -FilePath "$path\Notes_1101FP5_Win.exe" -NoNewWindow  -PassThru -ArgumentList '/s','/v"/qn"'
    Start-Process -wait -FilePath "$path\anyconnect-win-4.9.04043-core-vpn-webdeploy-k9.exe" -ArgumentList '/s'
    Start-Process -wait -FilePath "$APP\MSTeamsSetup.exe" -ArgumentList '/s' -PassThru
    Start-Process -wait -FilePath "$APP\OfficeSetup.exe" -PassThru
    winget install "3CX" --source msstore --accept-package-agreements --scope machineTT

    Add-Computer -DomainName "local.deltainformatica.eu"

    Rename-LocalUser -Name Utente -NewName DeltaAdmin   
    $pwd = ConvertTo-SecureString "DeltaSudo2024!" -AsPlainText -Force
    Set-LocalUser -name DeltaAdmin -FullName DeltaAdmin -Password $pwd

    Rename-Computer -NewName $name -Restart
}

 function itas{
    #rinominare il PC prima con ITAS_%SERIAL%
    #applicativi itas (M.A., cisco vpn, horizon, okta, crowd strike,
    #aggiungere il wifi?
    #dopo il restart l'aggiunta a dominio

    Write-Output "itas"
    exit
}

 function inser{
    #mg
    Write-Output "preparo il computer per inser s.p.a."

    $path = "D:\applicativi\Inser"

    $name = Read-Host "Inserire nuovo nome PC"
    $p = Read-Host "inserire la password per l'utente locale saidea"

    Copy-Item -Path "$APP\assistenza.exe" -Destination $PD -Force
    Copy-Item -Path "$path\Inser-DesktopFSL.rdp" -Destination $PD -Force
    Start-Process -wait -FilePath "$path\epi_win_live_installer.exe" -ArgumentList '/s' -PassThru
    Start-Process -wait -FilePath "$APP\MSTeamsSetup.exe" -ArgumentList '/s' -PassThru

    $CK = Get-Content -Path "$path\crowd inser\Key Crowdstrike.txt"
    Start-Process -wait -FilePath "$path\crowd inser\WindowsSensor.LionLanner" -ArgumentList '/install /silent CID=$CK' -PassThru

    Start-Process -wait -FilePath "$path\inser_me" -ArgumentList '/s' -PassThru

    Rename-LocalUser -Name Utente -NewName Saidea   
    $pwd = ConvertTo-SecureString $p -AsPlainText -Force
    Set-LocalUser -name Saidea -FullName Saidea -Password $pwd

    Rename-Computer -NewName $name -Restart
}

function salute{
    Write-Output "preparo il PC per cooperazione salute"

    $path = "D:\applicativi\coopsalute"

    Copy-Item -Path "$APP\assistenza.exe" -Destination $PD -Force
    Copy-Item -Path "$path\ALLITUDE" -Destination $PD -Force
    Copy-Item -Path "$path\wildix" -Destination $PD -Force
    Start-Process -wait -FilePath "$path\RemoteDesktop_1.2.5709.0_x64.msi" -ArgumentList '/qn /noresta' -PassThru
    msiexec /i "$path\RemoteDesktop_1.2.5709.0_x64.msi" /qn /promptrestart

    Rename-LocalUser -Name Utente -NewName Saidea
    $pwd = ConvertTo-SecureString 'NotteQuiete.2017' -AsPlainText -Force
	pause
    Set-LocalUser -name Saidea -FullName Saidea -Password $pwd
   
    exit
    
}

function coopsol {
    Rename-LocalUser -name Utente -NewName Saidea
    $pwd = ConvertTo-SecureString '$aidea2000.46$' -AsPlainText -Force
    Set-LocalUser -name Saidea -FullName Saidea -Password $pwd
    Restart-Computer
}


$client = Read-Host "inserire cliente PC:
 1 Generico
 2 interno
 3 inser
 4 coop salute
 5 coop 90
 "


 Switch ($client)
{
    "generico"  { 
        Set-generico
     }
    "1"{ 

        Set-generico

     }

    "interno" {
        interno
     }
    "2"{
        interno
    }

    "inser" {
        inser
    }
    "3"{
        inser
    }

    "coop salute" {
        salute
    }
    "4"{
        salute
    }
    "coop 90" {
        coopsol
    }
    "5"{
        coopsol
    }
}

