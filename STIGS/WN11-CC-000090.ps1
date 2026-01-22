<#
.SYNOPSIS
    This PowerShell script ensures that Group Policy objects must be reprocessed even if they have not changed.
.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-22
    Last Modified   : 2026-01-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.TESTED ON
    Date(s) Tested  : 2026-01-22
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000090).ps1 
#>

# Requires administrative privileges

$basePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GroupPolicy"
$subKey   = "{35378EAC-683F-11D2-A89A-00C04FBBCFA2}"
$regPath  = Join-Path $basePath $subKey

$valueName = "NoGPOListChanges"
$valueData = 0

# Ensure the base key exists
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -Force | Out-Null
}

# Ensure the subkey exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Create or update the DWORD value
New-ItemProperty `
    -Path $regPath `
    -Name $valueName `
    -PropertyType DWord `
    -Value $valueData `
    -Force | Out-Null
