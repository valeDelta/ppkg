# Windows Configuration Scripts (ppkg) — v2.8.3

Automated collection of PowerShell and batch scripts used to prepare and configure Windows images / machines for deployment by ppkg file. The repository contains small utilities to remove default apps, configure regional/locale settings, create scheduled tasks to continue configuration at first logon, and apply Windows updates.

## Contents

- [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1) — remove/reset local admin password, set OOBE/privacy registry keys, download `update.ps1` and `4_config.ps1`.
- [2_sara.ps1](2_sara.ps1) — download and run SaRAcmd Office scrub tool to remove preinstalled Office.
- [3_start.ps1](3_start.ps1) — register scheduled tasks to run downloaded config/update scripts at user logon.
- [4_config.ps1](4_config.ps1) — main configuration executed at first logon: timezone, culture, time sync, local admin password prompt, disable fastboot, run app removal batch.
- [update.ps1](update.ps1) — Windows update helper using PSWindowsUpdate.
- [test.bat](test.bat) — batch script to remove built-in apps, disable Copilot/MeetNow, tweak registry and services.


Full workspace tree:
- [.gitignore](.gitignore)
- [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1)
- [2_sara.ps1](2_sara.ps1)
- [3_start.ps1](3_start.ps1)
- [4_config.ps1](4_config.ps1)
- [README.md](README.md)
- [update.ps1](update.ps1)

## Requirements & Preflight

- Run as Administrator for actions that modify users, scheduled tasks, services, or registry.
- PowerShell 5.1+ (or PowerShell Core where supported) and access to the internet for downloads.
- Winget is referenced in comments but not required for current scripts.

## Recommended Usage (order)

1. Review scripts and test in a VM.
2. Run (as admin) [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1) to prepare local admin and download management scripts.
3. Run (as admin) [2_sara.ps1](2_sara.ps1) if Office removal is needed.
4. Run (as admin) [3_start.ps1](3_start.ps1) to register scheduled tasks that will run [4_config.ps1](4_config.ps1) and [update.ps1](update.ps1) at next logon.
5. On first interactive logon, the scheduled task runs [4_config.ps1](4_config.ps1) to finalize configuration.


## Notes & Safety

- These scripts make system-wide changes (users, registry, scheduled tasks, installed packages). Test in a controlled environment before production use.
- Password handling: scripts prompt for admin password in [4_config.ps1](4_config.ps1); ensure secure handling in automation.
- Many operations assume a default local admin named "DeltaAdmin" — adapt to your naming and policies.
- The repository includes an aggressive app-removal batch ([test.bat](test.bat)) — review before executing.

## Where to look for behavior

- OOBE / privacy registry changes: see [1_rimuovi_pwd_utente.ps1](1_rimuovi_pwd_utente.ps1).
- Scheduled task creation: see [3_start.ps1](3_start.ps1).
- Final configuration actions (timezone, culture, time sync): see [4_config.ps1](4_config.ps1).
- Windows update automation: see [update.ps1](update.ps1).
- App removal and registry tweaks: see [test.bat](test.bat).
- Useful snippets and commands: [documentazione/comandi utili.txt.txt](documentazione/comandi utili.txt.txt).