<#
.SYNOPSIS
    This PowerShell script ensures that the network selection user interface (UI) must not be displayed on the logon screen.

.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-23
    Last Modified   : 2026-01-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000120

.TESTED ON
    Date(s) Tested  : 2026-01-23
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000120).ps1 
#>

# Registry path
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'

# Ensure the key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Disable network selection UI
New-ItemProperty `
    -Path $regPath `
    -Name 'DontDisplayNetworkSelectionUI' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
