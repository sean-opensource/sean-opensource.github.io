---
layout: post
title: Back Up and Validate ADFS Claim Rules Before a Change
date: 2026-07-27 09:00 +1000
categories: [PowerShell, ADFS]
tags: [powershell, adfs, windows-server]
description: Export ADFS relying-party claim rules, compare a proposed change, and keep a timestamped rollback file.
---

ADFS claim-rule changes affect authentication behavior. Back up the current
rules, review the target trust explicitly, and compare the proposed rule text
before applying a change.

Run these commands from a system with the ADFS PowerShell module and the
required administrative access.

## Select the Trust Explicitly

```powershell
$trustName = "Example Application"
$trust = Get-AdfsRelyingPartyTrust -Name $trustName
```

Do not use a broad wildcard when changing production claim rules.

## Create a Timestamped Backup

```powershell
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$backupFolder = ".\adfs-backups"
$backupPath = Join-Path $backupFolder "$timestamp-$trustName.xml"

New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null
$trust | Export-Clixml -Path $backupPath

$rulesPath = Join-Path $backupFolder "$timestamp-$trustName.rules.txt"
$trust.IssuanceTransformRules | Set-Content -Path $rulesPath
```

The XML file preserves the trust object for review. The text file is a simple
diff artifact for the exact rule text.

## Compare Proposed Rules

```powershell
$currentRules = $trust.IssuanceTransformRules
$proposedRules = Get-Content -Path ".\proposed.rules.txt" -Raw

Compare-Object `
    -ReferenceObject ($currentRules -split "`r?`n") `
    -DifferenceObject ($proposedRules -split "`r?`n")
```

Have another administrator review the diff and confirm the target relying
party before applying the change.

## Apply Only After Review

```powershell
Set-AdfsRelyingPartyTrust `
    -TargetName $trustName `
    -IssuanceTransformRules $proposedRules

(Get-AdfsRelyingPartyTrust -Name $trustName).IssuanceTransformRules
```

Test the application sign-in path and retain the backup according to your
change-management process.

## Next Steps

For copying rules between two reviewed trusts, see
[Copy ADFS Claim Rules](/posts/ADFS-powershell/).

## References

- [Get-AdfsRelyingPartyTrust](https://learn.microsoft.com/en-us/powershell/module/adfs/get-adfsrelyingpartytrust?view=windowsserver2025-ps)
- [Set-AdfsRelyingPartyTrust](https://learn.microsoft.com/en-us/powershell/module/adfs/set-adfsrelyingpartytrust?view=windowsserver2025-ps)
- [Export-Clixml](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/export-clixml?view=powershell-7.6)
