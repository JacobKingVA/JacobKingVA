<#
.SYNOPSIS
    This PowerShell script ensures that printing over HTTP is prevented. This prevents the client computer from printing over HTTP, which allows the computer to print to printers on the intranet as well as the internet.

.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/JacobKingVA
    Date Created    : 2026-01-22
    Last Modified   : 2026-01-22
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 2026-01-22
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : PowerShell ISE v1.0

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN111-CC-000110).ps1 
#>

# Requires administrative privileges

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$valueName = "DisableHTTPPrinting"
$valueData = 1

# Ensure the registry key exists
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
