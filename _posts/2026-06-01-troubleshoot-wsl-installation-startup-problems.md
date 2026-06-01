---
layout: post
title: Troubleshoot WSL Installation and Startup Problems
date: 2026-06-01 09:00 +1000
categories: [Python, WSL]
tags: [windows, wsl, troubleshooting]
description: Diagnose WSL installation, update, and startup problems with a repeatable PowerShell checklist.
---

When Windows Subsystem for Linux (WSL) does not install or a Linux distribution
will not start, begin with the current WSL state before changing Windows
features. This checklist moves from low-risk checks to the system-level fixes
that require administrator access or a restart.

Run the Windows-side commands in PowerShell or Windows Terminal. Use an
administrator window only where the guide says it is required.

## Step 1: Check the Installed State

Start in a regular PowerShell window:

```powershell
wsl --status
wsl --version
wsl --list --verbose
```

These commands answer three different questions:

| Command | What to check |
| --- | --- |
| `wsl --status` | Default distribution, default WSL version, and kernel details |
| `wsl --version` | Installed WSL component versions |
| `wsl --list --verbose` | Installed distributions, their state, and whether each uses WSL 1 or WSL 2 |

If no distribution is installed, list the available distributions and install
one:

```powershell
wsl --list --online
wsl --install --distribution Ubuntu
```

Restart Windows if the installation command asks you to do so.

## Step 2: Update WSL

An outdated WSL package or kernel can cause avoidable startup problems. Update
WSL from a regular PowerShell window:

```powershell
wsl --update
```

If Microsoft Store delivery is unavailable or the download stalls, retry using
the web download option:

```powershell
wsl --update --web-download
```

For a new distribution installation that stalls, use:

```powershell
wsl --install --web-download --distribution Ubuntu
```

## Step 3: Restart the WSL Virtual Machine

If a distribution normally works but now hangs or fails to launch, shut down
the WSL virtual machine:

```powershell
wsl --shutdown
```

Then start the default distribution again:

```powershell
wsl
```

This restart is a useful first fix after changing WSL configuration or when a
long-running development environment has stopped responding.

## Step 4: Start One Distribution Directly

On a machine with more than one distribution, launch the affected distribution
by name:

```powershell
wsl --list --verbose
wsl --distribution Ubuntu
```

If one distribution fails while another starts normally, the WSL platform is
available and the problem is likely specific to that distribution. Back up
important files before unregistering, importing, or reinstalling a
distribution. Unregistering a distribution deletes its data.

## Step 5: Confirm the Required Windows Features

If WSL 2 will not install or start, check the required optional features from
an **Administrator** PowerShell window:

```powershell
Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```

Both features should report `Enabled`. If either feature is disabled, enable
it:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Restart Windows after enabling the features.

## Step 6: Check Virtualization for WSL 2

WSL 2 relies on virtualization. If the required Windows features are enabled
but a WSL 2 distribution still cannot start:

1. Open Task Manager.
2. Select **Performance** and then **CPU**.
3. Check that **Virtualization** reports **Enabled**.

If virtualization is disabled, enable the relevant Intel VT-x or AMD-V setting
in the computer's UEFI or BIOS configuration. The wording differs between
hardware vendors.

When Windows itself runs inside a virtual machine, WSL 2 also requires nested
virtualization support from the host platform.

## Step 7: Collect Details Before Making Larger Changes

If the problem remains, capture the current state:

```powershell
wsl --status
wsl --version
wsl --list --verbose
```

Record the full error message and note whether the failure happens during
installation, update, or distribution startup. This keeps the next
troubleshooting step focused and avoids deleting a working distribution.

## Quick Reference

| Symptom | First action |
| --- | --- |
| Store installation stalls | Retry with `wsl --install --web-download --distribution Ubuntu` |
| WSL worked previously but now hangs | Run `wsl --shutdown`, then start WSL again |
| No Linux distribution is listed | Run `wsl --list --online`, then install a distribution |
| WSL 2 distribution will not start | Check Windows optional features and virtualization |
| Only one installed distribution fails | Back up its files and investigate that distribution |

## Next Steps

Once WSL starts normally, continue with
[Windows Subsystem for Linux (WSL) setup](/posts/WSL-setup-for-python/) to add
Python and create a virtual environment.

## References

- [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Basic commands for WSL](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)
- [Troubleshooting Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting)
