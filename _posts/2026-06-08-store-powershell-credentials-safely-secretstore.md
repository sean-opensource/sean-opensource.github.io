---
layout: post
title: Store PowerShell Credentials Safely with SecretStore
date: 2026-06-08 09:00 +1000
categories: [PowerShell]
tags: [powershell, windows, security, secretstore]
description: Store a PowerShell credential in a local SecretStore vault and retrieve it without hard-coding a password in your script.
---

Avoid putting usernames and passwords directly into PowerShell scripts.
PowerShell SecretManagement provides a common set of commands for working with
vaults, while SecretStore provides a local encrypted vault for the current
user.

This guide stores a `PSCredential` object and retrieves it when mapping a
network drive. The same pattern works for other interactive administration
scripts that need a credential.

## Before You Start

Use PowerShell 7. SecretStore stores secrets locally for the current logged-in
user and encrypts the vault contents with .NET cryptography APIs.

The default SecretStore configuration asks for a vault password. That makes it
a good fit for interactive scripts. Do not assume that the same setup is ready
for unattended jobs, scheduled tasks, or shared service accounts.

## Step 1: Install the Modules

Install SecretManagement and SecretStore from the PowerShell Gallery:

```powershell
Install-PSResource Microsoft.PowerShell.SecretManagement
Install-PSResource Microsoft.PowerShell.SecretStore
```

If your environment still uses PowerShellGet instead of PSResourceGet, run:

```powershell
Install-Module Microsoft.PowerShell.SecretManagement
Install-Module Microsoft.PowerShell.SecretStore
```

Load the modules:

```powershell
Import-Module Microsoft.PowerShell.SecretManagement
Import-Module Microsoft.PowerShell.SecretStore
```

## Step 2: Register a Local Vault

Register SecretStore as the default vault for your user account:

```powershell
Register-SecretVault `
    -Name SecretStore `
    -ModuleName Microsoft.PowerShell.SecretStore `
    -DefaultVault
```

Confirm that the vault is registered:

```powershell
Get-SecretVault
Test-SecretVault -Name SecretStore
```

The first vault operation prompts you to create a password for the local
SecretStore vault. Keep that vault password separate from the credential that
you plan to store.

## Step 3: Add a Credential

Collect the network-share credential interactively:

```powershell
$credential = Get-Credential
Set-Secret `
    -Name NetworkShareCredential `
    -Secret $credential `
    -Vault SecretStore
```

The secret name is an identifier for your script. It is not the username or
password.

List the stored secrets without displaying their values:

```powershell
Get-SecretInfo -Vault SecretStore
```

## Step 4: Retrieve the Credential in a Script

Retrieve the stored `PSCredential` and use it when mapping a drive:

```powershell
$credential = Get-Secret `
    -Name NetworkShareCredential `
    -Vault SecretStore

New-PSDrive `
    -Name V `
    -PSProvider FileSystem `
    -Root \\VM-server\Folder-01 `
    -Persist `
    -Credential $credential
```

The script now refers to the vault entry by name. It does not contain the
password.

## Step 5: Rotate or Remove the Credential

To replace the stored credential, collect a new one and run `Set-Secret` with
the same name:

```powershell
$credential = Get-Credential
Set-Secret `
    -Name NetworkShareCredential `
    -Secret $credential `
    -Vault SecretStore
```

SecretStore overwrites the existing value. Use `-NoClobber` when you want
`Set-Secret` to fail rather than replace an existing secret.

Remove the credential when it is no longer required:

```powershell
Remove-Secret `
    -Name NetworkShareCredential `
    -Vault SecretStore
```

## Interactive Scripts and Automation

SecretStore is registered for the current user and stores its data in that
user's local context. With the default configuration, the vault requires a
password and allows interactive prompting.

Before using secrets in an unattended job:

1. Identify the account that will run the job.
2. Decide whether an interactive local vault is suitable for that account.
3. Review the vault authentication and interaction settings.
4. Consider a managed remote vault when the script runs in production or on
   multiple machines.

SecretManagement lets scripts retrieve secrets through the same commands while
the vault backend changes. That keeps vault-specific details out of the script.

## Next Steps

For the original mapped-drive example, see
[Map a Network Drive with New-PSDrive](/posts/map-network-drive-new-psdrive/).

## References

- [Overview of SecretManagement and SecretStore](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/overview?view=ps-modules)
- [Get started with SecretStore](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules)
- [Managing a SecretStore vault](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/how-to/manage-secretstore?view=ps-modules)
- [SecretManagement security concepts](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/security-concepts?view=ps-modules)
