---
layout: post
title: Copy ADFS Claim Rules
date: 2024-06-26 00:00 +1000
categories: [PowerShell, ADFS]
tags: [powershell, adfs, windows-server]
description: Export ADFS issuance transform rules from one relying party trust and import them into another.
---

Configuring similar ADFS relying party trusts by hand is time-consuming and error-prone. These PowerShell examples export issuance transform rules from an existing trust and import them into a new trust.

Run these commands on an ADFS server with the AD FS PowerShell module and
permissions to read and update relying party trusts. Test changes in a
non-production environment first.

## Export ADFS Claim Rules

First, export the claim rules to a file from an existing ADFS Relying Party Trust. You only need the Issuance Transform Rules.

```powershell
# Define the name of the existing relying party trust
$existingRelyingPartyTrustName = "Source Application"

# Define the output file path
$outputFilePath = "C:\temp\Claim_Rules.txt"

# Check if the output file already exists and delete it if it does
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
}

# Export the claim rules to the file
try {
    Get-ADFSRelyingPartyTrust -Name $existingRelyingPartyTrustName -ErrorAction Stop |
        Select-Object -ExpandProperty IssuanceTransformRules |
        Out-File $outputFilePath -Force -ErrorAction Stop
} catch {
    throw "Failed to export claim rules: $($_.Exception.Message)"
}

# Confirm the file has been created
if (Test-Path $outputFilePath) {
    Write-Output "Claim rules successfully exported to $outputFilePath"
} else {
    Write-Output "Failed to export claim rules."
}
```

## Import ADFS Claim Rules

Once you have the rules stored in a text file, you can import them into your new relying party trust.

```powershell
# Define the name of the new relying party trust
$newRelyingPartyTrustName = "Target Application"

# Define the path to the file containing the claim rules
$importFilePath = "C:\temp\Claim_Rules.txt"

# Check if the file exists before attempting to import
if (Test-Path $importFilePath) {
    # Import the claim rules from the file
    Set-ADFSRelyingPartyTrust -TargetName $newRelyingPartyTrustName -IssuanceTransformRulesFile $importFilePath -ErrorAction Stop

    # Verify the rules were imported
    $importedRules = Get-ADFSRelyingPartyTrust -Name $newRelyingPartyTrustName | Select-Object -ExpandProperty IssuanceTransformRules

    $exportedRules = Get-Content $importFilePath -Raw

    if ($importedRules.Trim() -eq $exportedRules.Trim()) {
        Write-Output "Claim rules successfully imported to $newRelyingPartyTrustName"
    } else {
        throw "Imported claim rules do not match the exported rules."
    }
} else {
    Write-Output "Claim rules file not found at $importFilePath"
}
```

### Explanation and Error Handling

1. **Export ADFS Claim Rules**:
    - The script starts by defining the name of the existing relying party trust and the output file path.
    - It checks if the output file already exists and deletes it if it does to ensure a clean export.
    - The `Get-ADFSRelyingPartyTrust` cmdlet retrieves the claim rules, which are then saved to the specified file.
    - It verifies if the export was successful by checking if the file was created.

2. **Import ADFS Claim Rules**:
    - The script defines the name of the new relying party trust and the path to the import file.
    - It checks if the import file exists before attempting to import the claim rules.
    - The `Set-ADFSRelyingPartyTrust` cmdlet imports the rules from the file into the new relying party trust.
    - It verifies the import by retrieving the rules from the new relying party trust and checking if they are present.

This approach ensures robust error handling and provides feedback at each step, making it easier to identify and resolve issues.
