---
layout: post
title: Map a Network Drive with New-PSDrive
date: 2022-06-14 00:33 +1000
categories: [PowerShell]
tags: [powershell, windows, storage]
description: Map a persistent Windows network drive from PowerShell with New-PSDrive.
redirect_from:
  - /posts/welcome/
---
Use `New-PSDrive` to map a network share to an available Windows drive letter.
Run the command in the user context that needs the mapped drive. Add credentials
only when the current Windows session does not already have access to the share.

Required parameters to create a network connection:

| Parameter | Description |
| --- | --- |
| `Name` | Must be an available drive letter |
| `PSProvider` | Set to `FileSystem` for network shares and folders |
| `Root` | The network location that you want to map |
| `Persist` | Makes the drive available outside PowerShell, including File Explorer |

```powershell
New-PSDrive -Name V -PSProvider FileSystem -Root \\VM-server\Folder-01 -Persist
```

To provide alternate credentials, collect them interactively rather than
storing a password in the script:

```powershell
$credential = Get-Credential
New-PSDrive -Name V -PSProvider FileSystem -Root \\VM-server\Folder-01 -Persist -Credential $credential
```
