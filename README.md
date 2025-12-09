# Windows Configuration Scripts (ppkg) — v2.8.3

Automated collection of PowerShell and batch scripts to prepare and configure Windows machines for deployment. The repository removes default apps, configures Italian locale settings, disables Xbox/Copilot/Meet Now, and applies Windows updates via scheduled tasks.

## Contents

- [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1) — Reset DeltaAdmin password, set OOBE registry keys, download config scripts from GitHub.
- [2_sara.ps1](2_sara.ps1) — Remove Microsoft Office completely using SaRAcmd.
- [3_start.ps1](3_start.ps1) — Register scheduled tasks for first-logon configuration.
- [4_config.ps1](4_config.ps1) — Main config: set Italian locale/timezone, install 7-Zip, download utilities, run app removal.
- [update.ps1](update.ps1) — Install Windows updates via PSWindowsUpdate module.
- [test.bat](test.bat) — Remove Xbox apps, disable Copilot/Meet Now, privacy tweaks.
- [finale/](finale/) — Compiled `.ppkg` provisioning packages for enterprise deployment.

## Requirements

- **Administrator privileges** for all scripts.
- **PowerShell 5.1+** with execution policy allowing scripts.
- **Internet connectivity** for downloads.
- Local admin user named **"DeltaAdmin"**.
- **Windows 10/11**.

## Workflow

1. **[1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1)**
   - Clears DeltaAdmin password.
   - Sets OOBE flags to skip setup screens.
   - Downloads [4_config.ps1](4_config.ps1) and [update.ps1](update.ps1) to `C:\management\`.

2. **[2_sara.ps1](2_sara.ps1)** (Optional)
   - Downloads and runs SaRAcmd to remove Office.

3. **[3_start.ps1](3_start.ps1)**
   - Creates two scheduled tasks: "continue" and "update".
   - Tasks trigger at next user logon.

4. **First Logon (Automatic)**
   - **"continue" task** runs [4_config.ps1](4_config.ps1):
     - Sets timezone/language to Italian (it-IT).
     - Installs 7-Zip via winget.
     - Downloads teleassistenza and netscan utilities.
     - Optionally installs Total Commander.
     - Runs [test.bat](test.bat) to remove Xbox/Copilot.
   - **"update" task** runs [update.ps1](update.ps1):
     - Installs PSWindowsUpdate module.
     - Checks and installs all Windows updates.

## What Each Script Does

| Script | Purpose |
|--------|---------|
| [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1) | Initialize system: reset password, skip OOBE, download core scripts. |
| [2_sara.ps1](2_sara.ps1) | Remove Microsoft Office completely. |
| [3_start.ps1](3_start.ps1) | Register scheduled tasks for automatic first-logon configuration. |
| [4_config.ps1](4_config.ps1) | Finalize config: Italian locale, software installation, utility downloads. |
| [update.ps1](update.ps1) | Install Windows updates automatically. |
| [test.bat](test.bat) | Remove Xbox apps, disable Copilot/Meet Now, privacy hardening. |

## Key Features

✅ **Automated Workflow** — All actions trigger via scheduled tasks at first logon.  
✅ **Italian Localization** — Timezone, language, culture set to Italy (it-IT).  
✅ **Bloatware Removal** — Xbox, Copilot, Meet Now disabled.  
✅ **Software Installation** — 7-Zip, Total Commander (optional), utilities.  
✅ **Windows Updates** — Automatic update installation via PSWindowsUpdate.  
✅ **PPKG Support** — Enterprise-ready provisioning packages in [finale/](finale/).  

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Scripts won't run | `Set-ExecutionPolicy Bypass -Scope Process -Force` |
| DeltaAdmin not found | Create: `New-LocalUser -Name DeltaAdmin -Password ([securestring]::new())` |
| Scheduled tasks don't trigger | Restart computer. Verify DeltaAdmin account exists. |
| Office removal fails | Ensure no Office apps running. Re-run [2_sara.ps1](2_sara.ps1). |
| Copilot still visible | Restart: `taskkill /f /im explorer.exe & start explorer` |

## Safety Notes

⚠️ **Test in a VM first** — Scripts make irreversible system changes.  
⚠️ **Review [test.bat](test.bat)** — Comment out lines if you need disabled features.  
⚠️ **Backup your system** — Create restore point before execution.  
