# Chilepluto Content Roadmap

## Site Review

Chilepluto now has a clear technical-notes identity: practical PowerShell,
Windows, Python, and local AI guides. The five published articles render
cleanly, use descriptive summaries, and cover a useful beginner baseline.

The next gap is progression. New posts should turn the existing articles into
small series: setup, common task, troubleshooting, and operational follow-up.
This gives readers a natural next page and creates useful internal links.

## Publishing Status

All twelve roadmap articles have now been drafted locally. GitHub Pages is
scheduled to rebuild weekly so each future-dated post becomes visible in turn.

## Release Calendar

| Date | Post |
| --- | --- |
| June 1, 2026 | Troubleshoot WSL Installation and Startup Problems |
| June 8, 2026 | Store PowerShell Credentials Safely with SecretStore |
| June 15, 2026 | Run a Local Text-Generation Pipeline on Apple Silicon |
| June 22, 2026 | Diagnose Linear Regression with Cross-Validation and Residuals |
| June 29, 2026 | Use PowerShell Remoting Safely with WinRM |
| July 6, 2026 | Set Up VS Code Dev Containers on WSL 2 |
| July 13, 2026 | Quantize a Local Model on Apple Silicon with Transformers Metal |
| July 20, 2026 | Manage Persistent Network Drives with PowerShell |
| July 27, 2026 | Back Up and Validate ADFS Claim Rules Before a Change |
| August 3, 2026 | Choose a Local Language Model for Your Hardware |
| August 10, 2026 | Run Python Tests and Formatting Inside WSL |
| August 17, 2026 | Build a Reusable scikit-learn Pipeline |

## Priority Queue

### 1. Troubleshoot WSL Installation and Startup Problems

**Why next:** This is the strongest follow-up to the existing WSL setup guide.

**Cover:**

- Check `wsl --status`, `wsl --version`, and `wsl -l -v`.
- Update with `wsl --update`.
- Use `wsl --install --web-download -d Ubuntu` when Store installation stalls.
- Restart the WSL VM with `wsl --shutdown`.
- Explain when to check Windows optional features and virtualization.

**Link from:** `Windows Subsystem for Linux (WSL) setup`.

**Sources:**

- [Basic commands for WSL](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)
- [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

### 2. Run a Local Text-Generation Pipeline on Apple Silicon

**Why next:** The GPT-2 article is a CPU-friendly introduction. This is the
practical Mac follow-up.

**Cover:**

- Detect `torch.backends.mps.is_available()`.
- Use `pipeline("text-generation", device="mps")`.
- Explain unified memory and model-size limits.
- Mention CPU fallback for unsupported MPS operations.
- Compare a small demonstration model with a larger instruction model.

**Link from:** `Running Open-Source Large Language Models Locally with Python`.

**Sources:**

- [Transformers pipelines](https://huggingface.co/docs/transformers/main/en/pipeline_tutorial)
- [Transformers on Apple Silicon](https://huggingface.co/docs/transformers/perf_train_special)

### 3. Store PowerShell Credentials Safely with SecretStore

**Why next:** The mapped-drive guide introduces interactive credentials. This
article should explain how to remove secrets from scripts.

**Cover:**

- Install `Microsoft.PowerShell.SecretManagement` and
  `Microsoft.PowerShell.SecretStore`.
- Register a local vault.
- Add, retrieve, and rotate a secret.
- Explain user-context storage and interactive versus non-interactive use.
- Show how scripts depend on a vault name rather than a hard-coded password.

**Link from:** `Map a Network Drive with New-PSDrive`.

**Sources:**

- [SecretManagement overview](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/overview?view=ps-modules)
- [Using SecretStore](https://learn.microsoft.com/en-us/powershell/utility-modules/secretmanagement/get-started/using-secretstore?view=ps-modules)

### 4. Diagnose Linear Regression with Cross-Validation and Residuals

**Why next:** The current regression article intentionally stops at a small
example. This turns it into a useful machine-learning series.

**Cover:**

- Compare training and test error.
- Add cross-validation with `cross_validate`.
- Plot actual versus predicted values.
- Explain residual inspection.
- Explain why correlated features make coefficients unstable.

**Link from:** `Linear Regression with Multiple Variables in Python`.

**Sources:**

- [Cross-validation](https://scikit-learn.org/stable/modules/cross_validation.html)
- [Interpreting linear-model coefficients](https://scikit-learn.org/stable/auto_examples/inspection/plot_linear_model_coefficient_interpretation.html)

### 5. Use PowerShell Remoting Safely with WinRM

**Why next:** This broadens the PowerShell section from single-machine tasks to
server administration.

**Cover:**

- Explain `Enable-PSRemoting`, `Enter-PSSession`, and `Invoke-Command`.
- Show one-to-many service checks.
- Describe WinRM ports and firewall considerations.
- Warn against casually widening `TrustedHosts`.
- Include a short troubleshooting checklist.

**Link from:** `Copy ADFS Claim Rules`.

**Sources:**

- [PowerShell remoting](https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/08-powershell-remoting?view=powershell-7.6)
- [WinRM security considerations](https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/winrm-security?view=powershell-7.5)
- [Remote troubleshooting](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting?view=powershell-7.5)

## Secondary Queue

### 6. Set Up VS Code Dev Containers on WSL 2

Build on the WSL guide with Docker Desktop, the WSL 2 backend, Dev Containers,
and the performance reason for storing repositories inside the Linux
filesystem.

Source: [Dev Containers on Windows](https://learn.microsoft.com/en-us/windows/dev-environment/docker/dev-containers)

### 7. Quantize a Local Model on Apple Silicon with Transformers Metal

Show a four-bit `MetalConfig`, unified-memory tradeoffs, supported bit widths,
and when a smaller model is still the better choice.

Source: [Transformers Metal quantization](https://huggingface.co/docs/transformers/main/quantization/metal)

### 8. Manage Persistent Network Drives with PowerShell

Extend the mapped-drive article with `Get-PSDrive`, `Remove-PSDrive`, remapping,
dot-sourcing scripts when persistence matters, and common credential errors.

Source: [New-PSDrive](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive?view=powershell-7.6)

### 9. Back Up and Validate ADFS Claim Rules Before a Change

Create a reusable PowerShell function that exports rules, timestamps backups,
imports only after validation, and compares normalized rule text.

Link from: `Copy ADFS Claim Rules`.

### 10. Choose a Local Language Model for Your Hardware

Explain model size, precision, context length, CPU versus GPU versus Apple
Silicon, and why a small model is often the right first local test.

Link from: `Running Open-Source Large Language Models Locally with Python`.

### 11. Run Python Tests and Formatting Inside WSL

Add a practical Python project layout with `.venv`, `pytest`, `ruff`, and a
small `pyproject.toml`.

Link from: `Windows Subsystem for Linux (WSL) setup`.

### 12. Build a Reusable scikit-learn Pipeline

Show preprocessing, train/test separation, cross-validation, and a pipeline
that can be saved and reused without leaking information from the test set.

Link from: `Linear Regression with Multiple Variables in Python`.

## Publishing Order

Publish the first five in this order:

1. Troubleshoot WSL Installation and Startup Problems
2. Store PowerShell Credentials Safely with SecretStore
3. Run a Local Text-Generation Pipeline on Apple Silicon
4. Diagnose Linear Regression with Cross-Validation and Residuals
5. Use PowerShell Remoting Safely with WinRM

This alternates the site topics while creating an internal-link path from every
existing article.
