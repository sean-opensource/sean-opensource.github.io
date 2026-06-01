---
layout: post
title: Manage Persistent Network Drives with PowerShell
date: 2026-07-20 09:00 +1000
categories: [PowerShell]
tags: [powershell, windows, storage]
description: Inspect, map, remap, and remove persistent Windows network drives with PowerShell.
---

`New-PSDrive` can create Windows mapped drives that remain available in File
Explorer. Use a small script to check the current state before replacing a
mapping.

## Inspect Existing Drives

```powershell
Get-PSDrive -PSProvider FileSystem
Get-PSDrive -Name V -ErrorAction SilentlyContinue
```

## Map a Persistent Drive

```powershell
New-PSDrive `
    -Name V `
    -PSProvider FileSystem `
    -Root \\VM-server\Folder-01 `
    -Persist `
    -Scope Global
```

`-Persist` creates a Windows mapped network drive. The drive letter must be
available and the root must be a UNC path such as `\\Server\Share`.

## Remap a Drive Safely

```powershell
$existing = Get-PSDrive -Name V -ErrorAction SilentlyContinue

if ($existing) {
    Remove-PSDrive -Name V -Force
}

New-PSDrive `
    -Name V `
    -PSProvider FileSystem `
    -Root \\VM-server\Folder-02 `
    -Persist `
    -Scope Global
```

Review the current root before removing a mapping that another script may
depend on.

## Use a Stored Credential

```powershell
$credential = Get-Secret `
    -Name NetworkShareCredential `
    -Vault SecretStore

New-PSDrive `
    -Name V `
    -PSProvider FileSystem `
    -Root \\VM-server\Folder-01 `
    -Persist `
    -Scope Global `
    -Credential $credential
```

See [Store PowerShell Credentials Safely with SecretStore](/posts/store-powershell-credentials-safely-secretstore/)
for the vault setup.

## Run Scripts in the Right Scope

Microsoft notes that a persistent mapping created inside a script may not
remain after the script scope ends. Use `-Scope Global`, and dot-source a script
when you intentionally want its mapping to remain in the calling session:

```powershell
. .\Map-Drive.ps1
```

Mapped drives are user-specific. A drive created in an elevated session may
not appear in a non-elevated session.

## References

- [New-PSDrive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7.6)
- [Get-PSDrive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psdrive?view=powershell-7.6)
- [Remove-PSDrive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-psdrive?view=powershell-7.6)
