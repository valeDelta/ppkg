# Windows Configuration Scripts V1.6

## Description

Scripts to implement in a windows configuration designer pakage to automate a plain configuration of windows.

## Scripts

### rimuovi_pwd_utente.ps1

Removes the password for the local user "Utente", set the privacy consent status, remove unwanted languages.

### sara.ps1

run the SaRAcmd tool to clear all preintalled office versions

### start.ps1

Configures the system to run the `4_config.ps1` script at logon and sets the execution policy to unrestricted.
In future updates the script will also run the `update.ps1` script at logon to update automatically windows.

### update.ps1

not implemented at the moment
Updates the system by installing the PSWindowsUpdate module, importing it, and applying available Windows updates.
Future updates will also run the winget tool to update software.

### 4_config.ps1

Sets the region and timezone.
In future updates will run the semi automatic configuration of the system, by installing softwares, creating local admin, adding the PC to domains and so on.

## Usage

1. Clone the repository to a local directory.
2. Run the `1_rimuovi_pwd_utente.ps1` script to remove the password for the local user "Utente" and configure regional settings.
3. Run the `2_sara.ps1` script to clear all preintalled office versions.
4. Run the `3_start.ps1` script to configure the system to run the `4_config.ps1` script at logon.

## Notes

* These scripts are designed to be run in a specific order, first with `1_rimuovi_pwd_utente.ps1` and then `2_sara.ps1`, `3_start.ps1`, the others will run at logon.
* Be cautious when running these scripts, as they make significant changes to the system configuration.