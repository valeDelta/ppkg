Write-Host "Avvio script di aggiornamento Windows..." -ForegroundColor Cyan

# Lasciamo i messaggi di progresso attivi per debug
$ProgressPreference = 'Continue'

# Controllo provider NuGet
if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Write-Host "NuGet non trovato. Lo installo, tranquillo." -ForegroundColor Yellow
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
} else {
    Write-Host "Provider NuGet già presente." -ForegroundColor Green
}

# Imposta PSGallery come repository trusted (così non ti stressa)
$repo = Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue
if ($repo -and $repo.InstallationPolicy -ne 'Trusted') {
    Write-Host "Imposto PSGallery come repository trusted..." -ForegroundColor Yellow
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
}

# Controlla e installa PSWindowsUpdate
if (!(Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "Modulo PSWindowsUpdate non trovato. Installo..." -ForegroundColor Yellow
    Install-Module -Name PSWindowsUpdate -Force -AllowClobber
} else {
    Write-Host "Modulo PSWindowsUpdate già installato." -ForegroundColor Green
}

# Importa modulo
Import-Module PSWindowsUpdate -Force

# Cerca aggiornamenti
Write-Host "Ricerca aggiornamenti disponibili..." -ForegroundColor Cyan
$Updates = Get-WindowsUpdate -ErrorAction SilentlyContinue

if ($Updates) {
    Write-Host "Aggiornamenti trovati. Procedo con installazione..." -ForegroundColor Green
    Install-WindowsUpdate -AcceptAll -IgnoreReboot -Verbose
} else {
    Write-Host "Nessun aggiornamento disponibile. Che colpo di fortuna." -ForegroundColor Green
}

pause
