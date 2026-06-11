---
layout: post
title: Azure Policy Guardrails for Enterprise Landing Zones
date: 2026-06-15 09:00 +1000
categories: [Azure]
tags: [azure, azure-policy, landing-zone, governance, security, compliance, guardrails]
description: A detailed guide to designing Azure Policy guardrails that improve security and governance without slowing delivery.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the policy and governance layer.

Azure Policy is one of the most important tools in a landing zone. It turns governance from a document into a repeatable control plane. When used well, it helps teams deploy safely. When used badly, it blocks delivery, creates exceptions, and makes engineers work around the platform.

The goal is not to deny everything. The goal is to make the safe path the default path.

## Current Microsoft guidance to anchor the design

Microsoft's Azure landing zone design principles identify policy-driven governance as a core landing zone principle. Azure Policy is recommended as the mechanism for guardrails, auditing, enforcement, and control across Azure control plane and data plane configurations.

Microsoft's Azure landing zone design areas also treat governance as a dedicated design area and emphasise automated auditing and enforcement of governance policies.

Key references:

- Azure landing zone design principles: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles>
- Azure landing zone design areas: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas>
- Azure Policy overview: <https://learn.microsoft.com/en-us/azure/governance/policy/overview>

## What policy guardrails should do

Policy guardrails should help the platform answer these questions:

- Are resources deployed in approved locations?
- Are required tags present?
- Are risky public exposure patterns blocked or audited?
- Are diagnostic logs enabled?
- Are secure configuration settings enforced?
- Are workload teams using approved resource types?
- Are platform standards applied consistently?
- Are exceptions visible and time-bound?

A policy guardrail should be understandable. If engineers cannot understand why a deployment was denied, the guardrail will slow delivery and increase support load.

## Policy modes and effects

Azure Policy supports different effects. The choice of effect matters.

Common effects include:

- `Audit`
- `Deny`
- `Append`
- `Modify`
- `DeployIfNotExists`
- `AuditIfNotExists`
- `Disabled`

Each effect has a different operational impact.

## Audit first where impact is uncertain

Use `Audit` when introducing a new policy into an existing environment or when you are not sure how many workloads will be affected.

Audit-first policies help you answer:

- How many resources are non-compliant?
- Which teams are affected?
- Is the policy definition correct?
- Are there legitimate exceptions?
- Will deny mode break deployments?

After the impact is understood, move selected controls to `Deny`, `Modify`, or `DeployIfNotExists`.

## Deny only where the standard is mature

`Deny` is useful for controls where the organisation has a clear standard and a supported alternative.

Good candidates for deny policies:

- Disallow unapproved regions
- Block public IP creation except by exception
- Prevent insecure storage configuration
- Block resource types that are not supported
- Restrict specific high-risk SKUs

Poor candidates for early deny policies:

- New tagging standards that are not yet adopted
- Diagnostic settings that have not been tested for every resource type
- Controls with many valid exceptions
- Settings where deployment tooling is inconsistent

If a deny policy causes teams to bypass the platform, the control has failed operationally even if it is technically correct.

## DeployIfNotExists for platform hygiene

`DeployIfNotExists` can automatically deploy related configuration when a resource is created.

Good use cases include:

- Diagnostic settings
- Security configuration extensions
- Monitoring agents where appropriate
- Default configuration resources

Be careful with permissions. A policy assignment with remediation requires a managed identity with enough access to deploy the missing configuration.

Also test the resource provider behaviour. Some resources have diagnostic categories or configuration patterns that differ across services.

## Modify and Append

`Modify` and `Append` can help standardise configuration. They are useful but should be tested carefully.

Examples:

- Add required tags from parent scope
- Enforce TLS settings
- Adjust allowed configuration values
- Add missing metadata

Do not use modify effects to hide poor deployment practices. Teams should still understand the required configuration.

## Policy assignment strategy

Policy should be assigned at the right scope.

A practical assignment model:

```text
Tenant Root Group
└── Broad baseline audit controls

Platform Management Group
└── Platform-specific controls

Landing Zones Management Group
└── Common workload controls

Production Management Group
└── Stricter production controls

Non-Production Management Group
└── Flexible audit and hygiene controls

Sandbox Management Group
└── Cost, expiry, and public exposure controls
```

This model keeps policy intent close to the environment it governs.

## Baseline policy categories

A strong starting baseline includes these categories.

### Location controls

Location controls restrict or audit where resources can be deployed.

Use these when region placement matters for latency, support, cost, or organisational requirements.

Design notes:

- Start with approved regions.
- Consider global services separately.
- Document why a region is approved or blocked.
- Avoid hard-coding assumptions without review.

### Tagging controls

Tags support ownership, cost reporting, lifecycle, and operations.

Recommended baseline tags:

```text
Application
Environment
Owner
CostCentre
ManagedBy
Criticality
ExpiryDate
```

Use audit or append first. Move to deny only when deployment tooling reliably applies tags.

### Public exposure controls

Public exposure should be intentional.

Policy can audit or deny:

- Public IP creation
- Public network access on selected PaaS services
- Storage account public access
- Key Vault public network access
- Container registry public access
- Database services exposed publicly

Do not block all public exposure blindly. Some workloads genuinely require internet-facing endpoints. The platform should provide approved ingress patterns.

### Diagnostic logging controls

Diagnostic settings are essential for operations and investigation.

Policy can deploy or audit diagnostic settings for:

- Key Vault
- Storage accounts
- Firewalls
- Network security groups
- Public IPs
- Application gateways
- SQL services
- Kubernetes clusters
- Container registries

Use central log destinations where appropriate.

### Resource type controls

Restrict resource types that the platform does not support.

This reduces risk and operational sprawl.

Examples:

- Preview services not approved for use
- Services without monitoring support
- Services that create unmanageable cost risk
- Services not supported by the operations team

Resource type restrictions should be reviewed periodically. Azure changes quickly.

## Initiative design

Group related policies into initiatives.

Examples:

- Baseline security initiative
- Logging and monitoring initiative
- Tagging initiative
- Network exposure initiative
- Production workload initiative
- Sandbox control initiative

Initiatives make assignment easier and help reporting.

Avoid giant initiatives that mix unrelated controls. If an initiative is too broad, exceptions become messy.

## Parameterisation

Use parameters for values that change between environments.

Examples:

- Allowed locations
- Required tags
- Log Analytics workspace resource ID
- Approved private DNS zones
- Allowed SKUs
- Effect mode: audit or deny

Parameterisation allows the same policy definition to work across scopes without copying definitions.

## Exemptions and exceptions

Exceptions must be governed.

A good exemption record includes:

- Policy or initiative name
- Resource or scope
- Owner
- Reason
- Risk acceptance
- Expiry date
- Compensating controls
- Approval reference

Never create permanent exceptions without periodic review.

## Policy as code

Policy should be managed as code.

The policy repository should include:

```text
policy/
├── definitions/
├── initiatives/
├── assignments/
├── exemptions/
├── parameters/
└── tests/
```

Use pull requests for policy changes. This makes changes reviewable and auditable.

## Testing policy changes

Policy changes should be tested before production assignment.

Recommended process:

1. Validate JSON or Bicep/Terraform syntax.
2. Assign in a test scope.
3. Run sample deployments.
4. Review compliance results.
5. Confirm remediation behaviour.
6. Move to audit in non-production.
7. Move to production after review.
8. Move to deny only after impact is understood.

## Operational reporting

Policy compliance should be reviewed regularly.

Useful views:

- Compliance by management group
- Compliance by subscription
- Compliance by policy initiative
- Non-compliant resources by owner
- Exemptions expiring soon
- Deny events by team
- Remediation task status

Policy reporting should be linked to action. A dashboard with no owner does not improve governance.

## Common mistakes

### Too many deny policies too early

This creates friction and leads to workarounds.

### No exception process

Without a process, exceptions become hidden platform behaviour.

### Duplicated policy assignments

Duplicate assignments create confusing compliance results.

### Poorly named policies

Names should describe intent, not just technical implementation.

### No remediation ownership

If a policy reports non-compliance, someone must own fixing it.

## Recommended implementation plan

Start with this sequence:

1. Inventory current policies.
2. Define baseline categories.
3. Create initiatives.
4. Assign in audit mode.
5. Review compliance results.
6. Fix deployment templates.
7. Add remediation where safe.
8. Move selected controls to deny.
9. Establish exception review.
10. Report compliance monthly.

## Final recommendation

Azure Policy should make governance repeatable, visible, and fair.

The best policy model is one that platform teams can maintain, workload teams can understand, and operations teams can act on.

Policy is not just enforcement. It is one of the main ways the landing zone communicates what good looks like.
