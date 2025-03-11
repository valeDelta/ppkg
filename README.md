# Windows Configuration Scripts V1.6

## Description

Scripts to implement in a windows configuration designer pakage to automate a plain configuration of windows.

## Scripts

### rimuovi_pwd_utente.ps1

Removes the password for the local user "Utente" and configures regional settings, language, and timezone.

### sara.ps1

run the SaRAcmd tool to clear all preintalled office versions

### start.ps1

Configures the system to run the `update.ps1` script at logon and sets the execution policy to unrestricted.

### update.ps1

Updates the system by installing the PSWindowsUpdate module, importing it, and applying available Windows updates. It also sets the regional settings, language, and timezone.

## Usage

1. Clone the repository to a local directory.
2. Run the `rimuovi_pwd_utente.ps1` script to remove the password for the local user "Utente" and configure regional settings.
3. Run the `start.ps1` script to configure the system to run the `update.ps1` script at logon.
4. Run the `update.ps1` script to update the system.

## Notes

* These scripts are designed to be run in a specific order, with `rimuovi_pwd_utente.ps1` and `start.ps1` being run first, followed by `update.ps1`.
* The `sara.ps1` script is not provided in the code snippets, so its usage is unknown.
* Be cautious when running these scripts, as they make significant changes to the system configuration.