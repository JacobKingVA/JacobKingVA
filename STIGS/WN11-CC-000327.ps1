<#
.SYNOPSIS
    This PowerShell script ensures that PowerShell Transcription must be enabled on Windows 11.

    Author          : Jacob King
    LinkedIn        : linkedin.com/in/jkingva/
    GitHub          : github.com/jacobkingva
    Date Created    : 2026-01-23
    Last Modified   : 2026-01-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000327

.TESTED ON
    Date(s) Tested  : 2026-01-23
    Tested By       : Jacob King
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : Windows PowerShell ISE

.USAGE
    Apply using PowerShell ISE as an administrator. Script success will be reflected in the registry as well as in successful compliance scans.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000327).ps1 
#>

# Registry paths
$basePath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell'
$transcriptionPath = Join-Path $basePath 'Transcription'

# Ensure base key exists
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -Force | Out-Null
}

# Ensure Transcription key exists
if (-not (Test-Path $transcriptionPath)) {
    New-Item -Path $transcriptionPath -Force | Out-Null
}

# Enable PowerShell Transcription
New-ItemProperty `
    -Path $transcriptionPath `
    -Name 'EnableTranscripting' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
