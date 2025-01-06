@echo off
REM Set working directory to the script's location
cd /d %~dp0

REM Define variables
set VM_NAME=MyVM_%RANDOM%
set VM_PATH=C:\HyperV\%VM_NAME%
set VHD_PATH=C:\HyperV\%VM_NAME%\%VM_NAME%.vhdx
set ISO_PATH=%~dp0download\Win11_24H2_English_x64.iso
set DIRECTORY_PATH=%~dp0
set RETURN_FILE_PATH=C:\Danu\out\DanuAI_Installer.exe
set HOST_DESTINATION=%~dp0out\DanuAI_Installer.exe
set ISO_DOWNLOAD_URL=https://software-download.microsoft.com/Windows11_Pro.iso

REM Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Run as administrator.
    exit /b 1
)

REM Check if the ISO file exists, download if missing
if not exist "%ISO_PATH%" (
    echo ISO file not found. Downloading Windows 11 Pro ISO...
    powershell -Command "Invoke-WebRequest -Uri '%ISO_DOWNLOAD_URL%' -OutFile '%ISO_PATH%' -ErrorAction Stop" || (
        echo Failed to download the ISO file. Verify your internet connection and try again.
        exit /b 1
    )
    echo ISO download complete.
)

REM Create VM directory
if not exist "%VM_PATH%" mkdir "%VM_PATH%"

REM Create Hyper-V virtual machine
echo Creating Hyper-V virtual machine...
powershell -Command "New-VM -Name '%VM_NAME%' -MemoryStartupBytes 2GB -Path '%VM_PATH%' -Generation 2 -ErrorAction Stop" || (
    echo Failed to create the virtual machine. Ensure that Hyper-V is enabled on your system.
    exit /b 1
)

REM Create a virtual hard disk
echo Creating virtual hard disk...
powershell -Command "New-VHD -Path '%VHD_PATH%' -SizeBytes 20GB -Dynamic -ErrorAction Stop" || (
    echo Failed to create the virtual hard disk. Verify that the path is valid and there is enough disk space available.
    exit /b 1
)

REM Attach the virtual hard disk using SCSI
echo Attaching the virtual hard disk...
powershell -Command "Add-VMHardDiskDrive -VMName '%VM_NAME%' -Path '%VHD_PATH%' -ControllerType SCSI -ErrorAction Stop" || (
    echo Failed to attach the virtual hard disk. Ensure that the VM name is correct and try again.
    exit /b 1
)

REM Attach an ISO for installation
echo Attaching ISO for OS installation...
powershell -Command "Add-VMDvdDrive -VMName '%VM_NAME%' -Path '%ISO_PATH%' -ErrorAction Stop" || (
    echo Failed to attach the ISO file. Verify that the ISO path is correct and accessible.
    exit /b 1
)

REM Set boot order to boot from DVD first
echo Setting boot order...
powershell -Command "
    $vmDvd = Get-VMDvdDrive -VMName '%VM_NAME%' -ErrorAction Stop;
    $vmHdd = Get-VMHardDiskDrive -VMName '%VM_NAME%' -ErrorAction Stop;
    if (-not $vmDvd) { Write-Error 'DVD drive not found for VM'; exit 1 }
    if (-not $vmHdd) { Write-Error 'Hard disk drive not found for VM'; exit 1 }
    Set-VMFirmware -VMName '%VM_NAME%' -FirstBootDevice $vmDvd;
" || (
    echo Failed to set boot order. The VM may not boot from the installation media.
    exit /b 1
)

REM Start the VM to install the OS
echo Starting the virtual machine...
powershell -Command "Start-VM -Name '%VM_NAME%' -ErrorAction Stop" || (
    echo Failed to start the virtual machine. Check if the VM is properly configured.
    exit /b 1
)

REM Wait for OS installation to complete
echo Waiting for OS installation to complete...
set /a retry_count=0
set max_retries=20
:wait_for_os
powershell -Command "if ((Get-VM -Name '%VM_NAME%').State -eq 'Off') { exit 0 } else { exit 1 }"
if %errorlevel% neq 0 (
    set /a retry_count+=1
    if %retry_count% geq %max_retries% (
        echo OS installation timeout. Exiting...
        exit /b 1
    )
    timeout /t 30 >nul
    goto wait_for_os
)

REM Further steps...
