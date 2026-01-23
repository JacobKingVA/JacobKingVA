<#
.SYNOPSIS
    This PowerShell script ensures that Windows 11 must be configured to prioritize ECC Curves with longer key lengths first.

.NOTES
    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-23
    Last Modified   : 2026-01-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000052

.TESTED ON
    Date(s) Tested  : 2026-01-23
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000052).ps1 
#>

# Registry path
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002'

# Ensure the key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# ECC Curves (REG_MULTI_SZ)
$eccCurves = @(
    'NistP384',
    'NistP256'
)

# Create or update the registry value
New-ItemProperty `
    -Path $regPath `
    -Name 'EccCurves' `
    -PropertyType MultiString `
    -Value $eccCurves `
    -Force | Out-Null

