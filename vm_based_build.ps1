# Ensure script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script requires administrative privileges. Run as administrator." -ErrorAction Stop
}

# Define variables
$VMName = "MyVM_$((Get-Random).ToString())"
$VMPath = "C:\HyperV\$VMName"
$VHDPath = "$VMPath\$VMName.vhdx"
$ISOPath = "$PSScriptRoot\download\Win11_24H2_English_x64.iso"
$DirectoryPath = "$PSScriptRoot"
$ReturnFilePath = "C:\Danu\out\DanuAI_Installer.exe"
$HostDestination = "$PSScriptRoot\out\DanuAI_Installer.exe"
$ISODownloadUrl = "https://software-download.microsoft.com/Windows11_Pro.iso"

# Check if the ISO file exists, download if missing
if (-not (Test-Path -Path $ISOPath)) {
    Write-Host "ISO file not found. Downloading Windows 11 Pro ISO..."
    Invoke-WebRequest -Uri $ISODownloadUrl -OutFile $ISOPath -ErrorAction Stop
    Write-Host "ISO download complete."
}

# Create VM directory
if (-not (Test-Path -Path $VMPath)) {
    New-Item -ItemType Directory -Path $VMPath | Out-Null
}

# Create Hyper-V virtual machine
Write-Host "Creating Hyper-V virtual machine..."
New-VM -Name $VMName -MemoryStartupBytes 2GB -Path $VMPath -Generation 2 -ErrorAction Stop

# Create a virtual hard disk
Write-Host "Creating virtual hard disk..."
New-VHD -Path $VHDPath -SizeBytes 20GB -Dynamic -ErrorAction Stop

# Attach the virtual hard disk using SCSI
Write-Host "Attaching the virtual hard disk..."
Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath -ControllerType SCSI -ErrorAction Stop

# Attach an ISO for installation
Write-Host "Attaching ISO for OS installation..."
Add-VMDvdDrive -VMName $VMName -Path $ISOPath -ErrorAction Stop

# Set boot order to boot from DVD first
Write-Host "Setting boot order..."
$vmDvd = Get-VMDvdDrive -VMName $VMName -ErrorAction Stop
$vmHdd = Get-VMHardDiskDrive -VMName $VMName -ErrorAction Stop
if (-not $vmDvd -or -not $vmHdd) {
    Write-Error "Failed to retrieve boot devices" -ErrorAction Stop
}
Set-VMFirmware -VMName $VMName -FirstBootDevice $vmDvd

# Start the VM to install the OS
Write-Host "Starting the virtual machine..."
Start-VM -Name $VMName -ErrorAction Stop

# Wait for OS installation to complete
Write-Host "Waiting for OS installation to complete..."
$RetryCount = 0
$MaxRetries = 20
do {
    Start-Sleep -Seconds 30
    $RetryCount++
    if ($RetryCount -ge $MaxRetries) {
        Write-Error "OS installation timeout. Exiting..."
        break
    }
} while ((Get-VM -Name $VMName).State -ne "Off")

# Copy directory to the VM
Write-Host "Copying directory to the virtual machine..."
if ((Get-VMIntegrationService -VMName $VMName | Where-Object { $_.Name -eq "Guest Service Interface" }).Enabled -ne $true) {
    Write-Error "Integration Services are not enabled. Enable them and try again."
}
Copy-VMFile -Name $VMName -SourcePath $DirectoryPath -DestinationPath "C:\Danu" -FileSource Host -Recurse -ErrorAction Stop

# Run the build.bat file on the VM
Write-Host "Running the build.bat file on the virtual machine..."
Invoke-VMScript -VMName $VMName -ScriptText "cmd /c C:\Danu\build.bat" -ErrorAction Stop

# Copy file from VM to host
Write-Host "Copying output file from the virtual machine to the host..."
Copy-VMFile -Name $VMName -SourcePath $ReturnFilePath -DestinationPath $HostDestination -FileSource Guest -ErrorAction Stop

# Delete the VM if file copy was successful
Write-Host "Deleting the virtual machine..."
Remove-VM -Name $VMName -Force -RemoveVHD -ErrorAction Stop

Write-Host "VM setup, script execution, file retrieval, and cleanup complete."
