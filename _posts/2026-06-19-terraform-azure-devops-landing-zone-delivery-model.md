---
layout: post
title: Terraform and Azure DevOps Delivery Model for Landing Zones
date: 2026-06-19 09:00 +1000
categories: [Azure]
tags: [azure, terraform, azure-devops, landing-zone, infrastructure-as-code, pipelines, platform-engineering]
description: A deep dive into structuring Terraform and Azure DevOps pipelines for repeatable, reviewable landing zone delivery.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the infrastructure-as-code and delivery model.

A landing zone should not depend on manual portal configuration. If the platform is important, the platform should be deployed through code, reviewed through pull requests, and promoted through controlled pipelines.

Terraform and Azure DevOps can provide this delivery model when the repository structure, state strategy, permissions, and pipeline stages are designed intentionally.

## Current guidance to anchor the design

Microsoft's Azure landing zone guidance recommends automation, repeatable deployments, and clear platform operating models. Microsoft also maintains Azure Verified Modules to provide reusable, tested infrastructure-as-code building blocks for Azure resources and patterns.

HashiCorp's Terraform guidance continues to emphasise remote state, reviewable plans, provider version constraints, and modular design for maintainable infrastructure delivery.

Useful references:

- Azure landing zone design principles: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles>
- Azure Verified Modules: <https://azure.github.io/Azure-Verified-Modules/>
- Terraform language documentation: <https://developer.hashicorp.com/terraform/language>
- Azure DevOps YAML schema: <https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/>

## Delivery objectives

A good landing zone delivery model should provide:

- Repeatable deployments
- Pull request review
- Clear separation between plan and apply
- Environment promotion
- Controlled credentials
- Protected state
- Traceable changes
- Automated validation
- Approval gates for high-impact changes
- Consistent module versioning

The pipeline should make the safe deployment path easier than manual change.

## Repository structure

A practical structure separates modules, environments, and pipeline definitions.

```text
infra/
├── modules/
│   ├── management-groups/
│   ├── policy-definitions/
│   ├── policy-assignments/
│   ├── hub-network/
│   ├── spoke-network/
│   ├── diagnostics/
│   ├── role-assignments/
│   └── budget/
├── environments/
│   ├── platform/
│   │   ├── management-groups/
│   │   ├── policy/
│   │   ├── connectivity/
│   │   └── management/
│   ├── production/
│   └── non-production/
├── pipelines/
└── docs/
```

This structure keeps reusable components separate from environment-specific configuration.

## Module strategy

Modules should hide repetition, not intent.

A good module:

- Has a clear purpose
- Has predictable inputs
- Exposes useful outputs
- Uses sensible defaults
- Does not contain hidden cross-environment assumptions
- Has examples
- Is versioned
- Is tested where practical

A bad module tries to support every possible scenario and becomes harder to understand than the resources it creates.

## Azure Verified Modules

Azure Verified Modules are worth reviewing before creating custom modules. They provide Microsoft-aligned reusable modules for Azure resources and patterns.

A practical strategy is:

- Use Azure Verified Modules where they fit.
- Wrap them only when you need organisational defaults.
- Avoid copying module code unless necessary.
- Track module versions explicitly.
- Test upgrades in non-production first.

Do not adopt a module only because it exists. The module must match your operating model.

## State strategy

Terraform state is sensitive and must be protected.

Recommended practices:

- Use remote state.
- Store state in a dedicated storage account.
- Enable versioning and soft delete.
- Restrict state access to pipeline identities and limited platform operators.
- Use separate state files for major platform domains.
- Avoid storing secrets in state.
- Lock state during operations.

A useful state separation model:

```text
platform-management-groups.tfstate
platform-policy.tfstate
platform-connectivity.tfstate
platform-management.tfstate
prod-workload-a.tfstate
nonprod-workload-a.tfstate
```

Do not put the entire platform into one huge state file. It increases blast radius and slows operations.

## Provider and version pinning

Pin provider versions deliberately.

Example:

```hcl
terraform {
  required_version = ">= 1.8.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
```

Version pinning reduces surprise changes. Schedule regular upgrades rather than allowing uncontrolled drift.

## Identity for pipelines

Pipeline identities should use least privilege.

Avoid using personal credentials or broad permanent owner access.

Recommended model:

- Dedicated service connection per environment or platform domain
- Federated credentials where supported
- Minimal required role assignments
- Privileged access workflow for high-impact scopes
- Clear ownership of deployment identities
- Regular review of permissions

The identity used to deploy management groups and policy may need broader access than the identity used for a workload spoke.

## Pipeline stages

A mature pipeline separates validation, planning, approval, and apply.

```text
Pull Request
├── fmt
├── validate
├── static analysis
└── plan

Main Branch
├── plan
├── publish plan artifact
├── approval
├── apply
└── post-deployment checks
```

The plan should be visible to reviewers. Reviewers should understand what will change before approval.

## Pull request validation

Pull request validation should include:

- `terraform fmt -check`
- `terraform init -backend=false` where suitable
- `terraform validate`
- Static analysis
- Policy checks where available
- Documentation generation checks if used

For some modules, you can also run example plans against a test subscription.

## Static analysis

Static analysis can catch common problems before deployment.

Useful checks include:

- Public network exposure
- Missing encryption settings
- Missing diagnostic settings
- Overly broad role assignments
- Insecure storage defaults
- Missing tags
- Hard-coded secrets

Tools may include Checkov, tfsec, Terrascan, or equivalent scanning in the pipeline.

## Plan review

A Terraform plan should be treated as a change record.

Publish the plan output as an artifact or comment it on the pull request if the output is safe to share.

Review for:

- Resource creation
- Resource destruction
- Role assignment changes
- Policy assignment changes
- Network route changes
- Firewall changes
- Diagnostic setting changes
- State moves or imports

High-impact changes should require explicit review.

## Apply controls

Production apply should require approval.

Approvals should be based on risk, not ceremony.

High-risk changes include:

- Management group changes
- Policy deny changes
- Role assignment changes
- Hub network route changes
- Firewall rule changes
- DNS changes
- Key Vault access changes
- Deleting shared resources

The approval process should be documented and auditable.

## Environment promotion

Avoid manually recreating configuration between environments.

Promote through versioned modules and environment variables.

Example:

```text
module version 1.4.0 -> non-production
validate behaviour
module version 1.4.0 -> production
```

Environment differences should be explicit and documented.

## Secrets management

Do not put secrets in Terraform variables, state, or pipeline logs.

Use secure secret stores and managed identity patterns where possible.

Check for:

- Secrets in `.tfvars`
- Secrets in pipeline variables
- Secrets in plan output
- Secrets in state
- Secrets in module examples

If a value is sensitive, mark it sensitive and consider whether Terraform should manage it at all.

## Drift detection

Manual changes create drift.

Drift detection can be run on a schedule to compare expected state with actual resources.

A practical drift workflow:

1. Run scheduled plan.
2. Publish drift result.
3. Notify platform owners.
4. Decide whether to import, revert, or accept.
5. Track recurring drift causes.

Do not automatically apply drift corrections without understanding the cause.

## Break-glass changes

Emergency manual changes may happen. The operating model should define what happens next.

After a break-glass change:

- Record the reason.
- Capture the change.
- Update Terraform if the change is permanent.
- Revert if temporary.
- Review why the normal pipeline was not used.

Break-glass should not become a parallel change process.

## Documentation as part of delivery

Each module or platform domain should document:

- Purpose
- Inputs
- Outputs
- Examples
- Required permissions
- State backend
- Operational notes
- Rollback notes
- Known limitations

Documentation should live with the code.

## Branch protection

Use branch protection on `main`.

Recommended controls:

- Require pull request before merge
- Require successful checks
- Require CODEOWNERS review
- Prevent force pushes
- Limit who can bypass rules
- Require signed commits if appropriate

The main branch should represent deployable platform state.

## Common mistakes

### One giant state file

This increases blast radius and makes plans hard to review.

### Over-abstracted modules

Too much abstraction hides what is being deployed.

### Manual portal changes

Manual changes create drift and reduce trust in automation.

### Broad deployment identity

A single owner-level identity used everywhere is easy but risky.

### No plan review

Applying without reviewing the plan removes one of Terraform's biggest controls.

## Readiness checklist

Before using the delivery model for production platform changes, confirm:

- Repository structure is clear
- Terraform state is remote and protected
- Provider versions are pinned
- Pipeline identities use least privilege
- Pull request validation exists
- Plans are published for review
- Production applies require approval
- Drift detection exists or is planned
- Module versioning is defined
- Documentation is stored with code
- Break-glass reconciliation is documented

## Final recommendation

Treat landing zone code as platform product code.

It should be reviewed, tested, versioned, released, and operated. Terraform gives you a way to describe the platform, but the delivery model determines whether that description becomes reliable in practice.
