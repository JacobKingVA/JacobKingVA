<#
.SYNOPSIS
    This PowerShell script ensures that the Remote Desktop Session Host MUST require secure RPC communications.

.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-22
    Last Modified   : 2026-01-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

.TESTED ON
    Date(s) Tested  : 2026-01-20
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000285).ps1 
#>

# Requires administrative privileges

# Base paths
$tsBasePath        = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$tsClientPath      = Join-Path $tsBasePath "Client"
$usbBlockClassPath = Join-Path $tsClientPath "UsbBlockDeviceBySetupClasses"
$usbSelectIfPath   = Join-Path $tsClientPath "UsbSelectDeviceByInterfaces"

# Helper function to ensure a registry key exists
function Ensure-RegistryKey {
    param ([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
}

# Ensure all required keys exist
Ensure-RegistryKey $tsBasePath
Ensure-RegistryKey $tsClientPath
Ensure-RegistryKey $usbBlockClassPath
Ensure-RegistryKey $usbSelectIfPath

# Terminal Services settings
New-ItemProperty -Path $tsBasePath -Name "KeepAliveEnable"    -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $tsBasePath -Name "KeepAliveInterval"  -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $tsBasePath -Name "fEncryptRPCTraffic" -PropertyType DWord -Value 1 -Force | Out-Null

# Terminal Services Client settings
New-ItemProperty -Path $tsClientPath -Name "fEnableUsbBlockDeviceBySetupClass"      -PropertyType DWord -Value 1  -Force | Out-Null
New-ItemProperty -Path $tsClientPath -Name "fEnableUsbNoAckIsochWriteToDevice"       -PropertyType DWord -Value 80 -Force | Out-Null
New-ItemProperty -Path $tsClientPath -Name "fEnableUsbSelectDeviceByInterface"       -PropertyType DWord -Value 1  -Force | Out-Null

# USB block device setup class
New-ItemProperty `
    -Path $usbBlockClassPath `
    -Name "1000" `
    -PropertyType String `
    -Value "{3376f4ce-ff8d-40a2-a80f-bb4359d1415c}" `
    -Force | Out-Null

# USB select device interface
New-ItemProperty `
    -Path $usbSelectIfPath `
    -Name "1000" `
    -PropertyType String `
    -Value "{6bdd1fc6-810f-11d0-bec7-08002be2092f}" `
    -Force | Out-Null
