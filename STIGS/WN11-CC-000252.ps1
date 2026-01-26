<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 must be configured to disable Windows Game Recording and Broadcasting.

.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-26
    Last Modified   : 2026-01-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000252

.TESTED ON
    Date(s) Tested  : 2026-01-26
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000252).ps1 
#>

# Define registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
$Name    = "AllowGameDVR"
$Value   = 0

# Create the key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the DWORD value
New-ItemProperty `
    -Path $RegPath `
    -Name $Name `
    -Value $Value `
    -PropertyType DWord `
    -Force | Out-Null
