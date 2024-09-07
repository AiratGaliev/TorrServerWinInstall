# Function to check if script is running with admin privileges
function Test-Admin {
    $principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Restart script with admin privileges if not running as admin
if (-not (Test-Admin)) {
    Write-Host "Restarting script with admin privileges..."
    $arguments = "& '" + $myInvocation.MyCommand.Definition + "'"
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    exit
}

# Variables
$downloadUrl = "https://github.com/YouROK/TorrServer/releases/latest/download/TorrServer-windows-amd64.exe"
$installPath = "$env:LOCALAPPDATA\TorrServer"
$torrServerExecutable = "$installPath\TorrServer-windows-amd64.exe"
$nssmUrl = "https://nssm.cc/release/nssm-2.24.zip"
$nssmZip = "$installPath\nssm.zip"
$nssmDir = "$installPath\nssm-2.24"

# Stop and remove existing TorrServer service if it exists
$serviceName = "TorrServer"
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Stopping and removing existing TorrServer service..."
    Stop-Service -Name $serviceName -Force
    sc.exe delete $serviceName
}

# Check if install path exists, create if not
if (-not (Test-Path -Path $installPath)) {
    Write-Host "Creating installation directory $installPath"
    New-Item -ItemType Directory -Path $installPath
}

# Remove any existing nssm files and directories
if (Test-Path -Path $nssmDir) {
    Write-Host "Removing existing nssm directory..."
    Remove-Item -Path $nssmDir -Recurse -Force -ErrorAction Stop
}

# Download TorrServer
Write-Host "Downloading TorrServer..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $torrServerExecutable -ErrorAction Stop

# Grant execution permissions
Write-Host "Granting execution permissions..."
icacls $torrServerExecutable /grant Everyone:F

# Download and unzip nssm
Write-Host "Downloading nssm (Non-Sucking Service Manager)..."
Invoke-WebRequest -Uri $nssmUrl -OutFile $nssmZip -ErrorAction Stop

Write-Host "Checking nssm zip file..."
if (-Not (Test-Path -Path $nssmZip)) {
    Write-Host "Failed to download nssm zip file."
    exit 1
}

Write-Host "Unzipping nssm..."
try {
    Expand-Archive -Path $nssmZip -DestinationPath $installPath -Force
} catch {
    Write-Host "Failed to unzip nssm: $_"
    exit 1
}

# Verify nssm.exe exists
$nssmExe = "$nssmDir\win64\nssm.exe"
if (-Not (Test-Path -Path $nssmExe)) {
    Write-Host "nssm.exe not found."
    exit 1
}

# Install TorrServer as a Windows service
Write-Host "Installing TorrServer as a Windows service..."
& $nssmExe install $serviceName $torrServerExecutable

# Start TorrServer service
Write-Host "Starting TorrServer service..."
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Start-Service -Name $serviceName
    Write-Host "TorrServer is installed and running as a Windows service."
} else {
    Write-Host "Failed to install TorrServer service."
}