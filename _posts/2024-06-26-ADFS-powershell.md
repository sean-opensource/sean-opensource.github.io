---
layout: post
title: Copy ADFS Claim Rules
date: 2024-06-24 00:00 +1000
categories: [Powrshell, ADFS]
tags: [post]
---

+++
# Copy ADFS Claim Rules with PowerShell

In our infrastructure, we frequently configure ADFS relying party trusts for various environments, including Dev, QA, and Lab instances of Microsoft CRM. The manual entry of claim rules for each trust is both time-consuming and error-prone. To streamline this process, I developed a PowerShell script to automate the export and import of ADFS claim rules, significantly enhancing efficiency and consistency.

## Export ADFS Claim Rules

First, export the claim rules to a file from an existing ADFS Relying Party Trust. You only need the Issuance Transform Rules.

```powershell
# Define the name of the existing relying party trust
$existingRelyingPartyTrustName = "WOPR - External"

# Define the output file path
$outputFilePath = "C:\temp\Clain_Rules.txt"

# Check if the output file already exists and delete it if it does
if (Test-Path $outputFilePath) {
    Remove-Item $outputFilePath
}

# Export the claim rules to the file
Get-ADFSRelyingPartyTrust -Name $existingRelyingPartyTrustName |
    Select-Object -ExpandProperty IssuanceTransformRules |
    Out-File $outputFilePath -Force

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
$newRelyingPartyTrustName = "NORAD - External"

# Define the path to the file containing the claim rules
$importFilePath = "C:\temp\Claim_Rules.txt"

# Check if the file exists before attempting to import
if (Test-Path $importFilePath) {
    # Import the claim rules from the file
    Set-ADFSRelyingPartyTrust -TargetName $newRelyingPartyTrustName -IssuanceTransformRulesFile $importFilePath

    # Verify the rules were imported
    $importedRules = Get-ADFSRelyingPartyTrust -Name $newRelyingPartyTrustName | Select-Object -ExpandProperty IssuanceTransformRules

    if ($importedRules) {
        Write-Output "Claim rules successfully imported to $newRelyingPartyTrustName"
    } else {
        Write-Output "Failed to import claim rules."
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
+++