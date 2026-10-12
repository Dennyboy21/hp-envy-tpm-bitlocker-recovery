#Requires -Version 5.1
<#
.SYNOPSIS
  Collects a minimally identifying, read-only Windows TPM/BitLocker/power snapshot.
.DESCRIPTION
  Does not clear, reset, suspend, resume or alter TPM, BitLocker, firmware or
  power settings. Outputs sanitized summary JSON to local-diagnostics/ (gitignored).
  This is a portfolio example for use on personally owned/authorized Windows PCs.
.NOTES
  No BitLocker passwords, recovery key IDs, serial numbers, hostnames, usernames,
  event message text, or full raw HTML reports are included in the output.
#>
[CmdletBinding()]
param([string]$OutputDirectory = (Join-Path $PSScriptRoot '..\local-diagnostics'))

$ErrorActionPreference = 'Stop'
if (-not (Test-Path -LiteralPath $OutputDirectory)) {
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
}

$report = [ordered]@{
    CollectedAtLocal = (Get-Date).ToString('yyyy-MM-ddTHH:mm:sszzz')
    TPM = $null
    BitLocker = $null
    AvailableSleepStates = @()
    RelevantSystemEventCounts = @()
    Warnings = @()
}

try {
    $tpm = Get-Tpm
    $report.TPM = [ordered]@{
        Present = [bool]$tpm.TpmPresent
        Ready = [bool]$tpm.TpmReady
        Enabled = [bool]$tpm.TpmEnabled
        Activated = [bool]$tpm.TpmActivated
        Owned = [bool]$tpm.TpmOwned
        Manufacturer = $tpm.ManufacturerIdTxt
    }
} catch { $report.Warnings += 'TPM status was unavailable on this system.' }

try {
    # This API returns drive protection metadata; we deliberately omit protectors,
    # recovery passwords, numerical password IDs, and full unfiltered object dumps.
    $volume = Get-BitLockerVolume -MountPoint 'C:'
    $report.BitLocker = [ordered]@{
        VolumeStatus = "$($volume.VolumeStatus)"
        ProtectionStatus = "$($volume.ProtectionStatus)"
        EncryptionPercentage = $volume.EncryptionPercentage
        EncryptionMethod = "$($volume.EncryptionMethod)"
    }
} catch { $report.Warnings += 'BitLocker volume status was unavailable; try an elevated PowerShell session.' }

try {
    # `powercfg /a` reports available sleep-state names only, not credentials.
    $report.AvailableSleepStates = @(powercfg.exe /a | Select-Object -First 35)
} catch { $report.Warnings += 'Powercfg sleep-state query failed.' }

try {
    $events = Get-WinEvent -FilterHashtable @{
        LogName = 'System'
        StartTime = (Get-Date).AddDays(-7)
    } -ErrorAction SilentlyContinue |
      Where-Object { $_.ProviderName -match 'TPM|BitLocker|Kernel-Boot|SecureBoot' }

    # Aggregate by provider and Event ID. Do not export event messages or identities.
    $report.RelevantSystemEventCounts = @($events |
        Group-Object -Property ProviderName, Id |
        ForEach-Object {
            [pscustomobject]@{
                EventClass = $_.Name
                Count = $_.Count
            }
        } | Sort-Object EventClass)
} catch { $report.Warnings += 'System event summary was unavailable.' }

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$path = Join-Path $OutputDirectory "safe-snapshot-$stamp.json"
$report | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $path -Encoding UTF8
Write-Host "Read-only summary saved locally: $path"
Write-Warning 'Review even sanitized output before manually sharing or publishing it.'
