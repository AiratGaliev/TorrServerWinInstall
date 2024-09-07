# TorrServer Installation Script

## Overview

This repository contains a PowerShell script designed to automate the installation and configuration of TorrServer as a Windows service. Using the `nssm` (Non-Sucking Service Manager), the script handles the setup process, including downloading required files, configuring permissions, and ensuring that TorrServer runs automatically on system startup.

## Features

- **Automatic Download**: Downloads the latest version of TorrServer and `nssm` directly from their respective sources.
- **Service Management**: Checks for an existing TorrServer service, removes it if found, and installs a new one.
- **Permissions Handling**: Sets the necessary file permissions for TorrServer to run properly.
- **Service Setup**: Configures TorrServer to start automatically with Windows.

## Getting Started

Follow the instructions in the `README.md` file to use the script. Ensure you have the necessary administrative privileges and adjust your PowerShell execution policy if required.

## Prerequisites

- **PowerShell**: Ensure you have PowerShell 5.1 or higher installed on your system. You can check your PowerShell version by running the command:

 `Get-Host | Select-Object Version`

- **Administrative Privileges**: The script needs to be run with administrative rights to install the service and make system-level changes.

## How to Use

### 1. Download the Script

Download the `InstallTorrServer.ps1` script to your local machine.

### 2. Open PowerShell as Administrator

To run the script with administrative privileges:
1. Open PowerShell as Administrator. To do this, search for "PowerShell" in the Start menu, right-click on "Windows PowerShell," and select "Run as administrator."

### 3. Run the Script

Navigate to the directory where the `InstallTorrServer.ps1` script is located and execute it by running:

`.\InstallTorrServer.ps1`

### 4. Follow the Prompts

The script will:
- Check if the TorrServer service already exists and remove it if necessary.
- Download the TorrServer executable and `nssm` ZIP file.
- Extract `nssm` and set up TorrServer as a Windows service.
- Start the TorrServer service and ensure it runs automatically at startup.

## Troubleshooting

- **Script Execution Policy Error**: If you encounter an error related to script execution policies, you may need to adjust your PowerShell execution policy. You can temporarily change the policy by running:

`Set-ExecutionPolicy RemoteSigned`

After running the script, you may want to revert to the original execution policy for security reasons. To restore the default policy:

`Set-ExecutionPolicy Restricted`

- **File Access Errors**: If you receive errors related to file access, ensure that no other processes are using the files or directories involved. You might need to restart your machine to clear any locks on the files.

- **nssm Extraction Issues**: If the script fails to extract `nssm`, check if the ZIP file is corrupted or incomplete. You may need to delete any partially downloaded files and re-run the script.

## License

This script is provided "as-is" without warranty of any kind. Use at your own risk. For more information on TorrServer and `nssm`, refer to their official documentation and repositories.

- **TorrServer**: [GitHub Repository](https://github.com/YouROK/TorrServer)
- **nssm**: [Official Website](https://nssm.cc/)

## Contact

If you have any questions or need further assistance, feel free to open an issue on the script's repository or contact the author.

---

Enjoy your TorrServer installation!
