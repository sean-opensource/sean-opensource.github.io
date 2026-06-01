---
layout: post
title: Use PowerShell Remoting Safely with WinRM
date: 2026-06-29 09:00 +1000
categories: [PowerShell]
tags: [powershell, windows-server, winrm, security]
description: Enable PowerShell remoting where needed, run remote commands, and avoid common WinRM security mistakes.
---

PowerShell remoting is the standard way to run PowerShell commands on remote
Windows systems. It uses Windows Remote Management (WinRM), so enable it only
where it is needed and keep the default security boundaries unless your
environment requires a reviewed exception.

## Enable Remoting on the Target

From an elevated PowerShell window on a target computer:

```powershell
Enable-PSRemoting -Force
```

Windows Server platforms enable PowerShell remoting by default. On other
supported Windows systems, `Enable-PSRemoting` starts WinRM, creates a listener,
and configures the firewall exception.

## Test Connectivity

```powershell
Test-WSMan -ComputerName Server01
Enter-PSSession -ComputerName Server01
```

Leave the interactive session with `Exit-PSSession`.

## Run One Command on Several Servers

```powershell
$servers = "Server01", "Server02", "Server03"

Invoke-Command -ComputerName $servers -ScriptBlock {
    Get-Service -Name WinRM |
        Select-Object MachineName, Name, Status, StartType
}
```

Use `Invoke-Command` when you need repeatable checks instead of an interactive
shell.

## Understand the Default Ports

| Transport | Port |
| --- | --- |
| HTTP | `5985` |
| HTTPS | `5986` |

Authentication and message encryption still matter when using HTTP. Review the
Microsoft WinRM security guidance before changing listeners or firewall scope.

## Avoid Broad TrustedHosts Entries

In a domain environment, prefer Kerberos and computer names that resolve
correctly. Do not set `TrustedHosts` to `*` as a routine fix. If you must use
TrustedHosts for a reviewed workgroup scenario, add only specific hosts.

## Troubleshooting Checklist

```powershell
Test-WSMan -ComputerName Server01
Get-Service -Name WinRM
Get-WSManInstance winrm/config/listener -Enumerate
```

Also confirm name resolution, firewall scope, network profile, and account
permissions.

## References

- [Enable-PSRemoting](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-7.6)
- [WinRM security considerations](https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/winrm-security?view=powershell-7.5)
- [Remote requirements](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_requirements?view=powershell-7.5)
