---
layout: post
title: Azure Policy as Code with Terraform
date: 2026-07-24 09:00 +1000
categories: [Azure]
tags: [azure, azure-policy, terraform, policy-as-code, landing-zone, governance, platform-engineering]
description: A practical design guide for managing Azure Policy definitions, initiatives, assignments, exemptions, and remediation workflows as code with Terraform.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the policy-as-code delivery model.

Azure Policy is powerful, but manual policy management does not scale. If policy definitions, initiatives, assignments, exemptions, and remediation tasks are changed manually, the landing zone becomes difficult to review and difficult to trust.

Policy as code treats policy assets like platform source code. Changes are reviewed, tested, versioned, deployed, monitored, and improved through a controlled delivery process.

## Current guidance to anchor the design

Microsoft's Azure Policy as Code guidance recommends keeping policy definitions in source control, testing and validating policy changes, and integrating policy validation into CI/CD workflows before deployment reaches production-like environments. The guidance describes policy as code as the combination of infrastructure as code and DevOps practices.

Microsoft also recommends centralised deployment mechanisms such as GitHub workflows or Azure Pipelines so that only reviewed policy resources are deployed, and so that write permissions can be restricted to the deployment identity.

Useful references:

- Azure Policy as Code workflow: <https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-as-code>
- Azure Policy overview: <https://learn.microsoft.com/en-us/azure/governance/policy/overview>
- Azure landing zone design principles: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles>
- Terraform AzureRM provider: <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs>

## Design objectives

A policy-as-code model should provide:

- Source-controlled policy assets
- Reviewable pull requests
- Environment-specific parameters
- Repeatable assignments
- Testing before enforcement
- Clear exemption records
- Safe remediation workflows
- Compliance reporting
- Rollback options
- Separation between policy authors and policy deployment identities

The goal is to make policy change safer, not slower.

## What should be managed as code

At minimum, manage these assets through code:

- Policy definitions
- Initiative definitions
- Policy assignments
- Policy parameters
- Assignment identities
- Role assignments for remediation
- Exemptions
- Remediation tasks where appropriate
- Documentation for intent and ownership

Manual policy changes should be exceptional and reconciled back into code.

## Repository structure

A practical Terraform repository structure might look like this:

```text
policy/
├── modules/
│   ├── policy-definition/
│   ├── policy-initiative/
│   ├── policy-assignment/
│   ├── policy-exemption/
│   └── remediation-role-assignment/
├── definitions/
│   ├── deny-public-network-access/
│   ├── require-diagnostics/
│   └── require-tags/
├── initiatives/
│   ├── baseline-security/
│   ├── monitoring-baseline/
│   └── tagging-baseline/
├── assignments/
│   ├── platform/
│   ├── production/
│   ├── non-production/
│   └── sandbox/
├── exemptions/
├── environments/
│   ├── dev/
│   ├── test/
│   └── prod/
└── docs/
```

The exact layout can vary, but the key is separation of intent:

- Definitions describe what a policy is.
- Initiatives group related policies.
- Assignments describe where and how policies apply.
- Exemptions describe approved deviations.
- Environments describe deployment targets and parameters.

## Definitions versus assignments

A policy definition is reusable. A policy assignment is contextual.

For example, a definition might describe a rule to require diagnostic settings. The assignment determines:

- Scope
- Effect
- Parameters
- Managed identity
- Exclusions
- Enforcement mode
- Non-compliance message

Keep these concerns separate so the same definition can be used differently across environments.

## Initiative design

Use initiatives to group policies into meaningful baselines.

Examples:

```text
baseline-network-exposure
baseline-diagnostics
baseline-tagging
baseline-identity-controls
baseline-production-controls
baseline-sandbox-controls
```

Avoid one giant initiative that contains every policy. Large initiatives make exceptions and troubleshooting harder.

Good initiatives are:

- Purpose-specific
- Parameterised
- Documented
- Versioned
- Assigned at clear scopes

## Terraform module design

Terraform modules should standardise repeatable patterns without hiding policy intent.

A policy assignment module might accept:

```hcl
variable "assignment_name" {
  type = string
}

variable "scope" {
  type = string
}

variable "policy_definition_id" {
  type = string
}

variable "parameters" {
  type    = map(any)
  default = {}
}

variable "enforcement_mode" {
  type    = string
  default = "DoNotEnforce"
}
```

Defaulting to non-enforcement for early-stage testing can be useful, but production assignment behaviour should be explicit.

## Parameter strategy

Parameters make policy assets reusable.

Common parameters include:

- Allowed locations
- Required tag names
- Log destination resource IDs
- Allowed SKUs
- Public network access settings
- Diagnostic categories
- Effect values

Use parameter files or environment variables to keep environment differences clear.

## Assignment scope strategy

Assign policies at the right scope.

A practical pattern:

```text
Root management group
└── Broad baseline audit controls

Platform management group
└── Platform-specific controls

Landing zone management group
└── Common workload controls

Production management group
└── Stronger production controls

Non-production management group
└── Flexible validation controls

Sandbox management group
└── Cost, expiry, and exposure controls
```

The assignment scope should match the control intent.

## Enforcement rollout

Do not move directly from idea to deny.

A safer sequence:

1. Author the policy.
2. Unit-test the rule logic where possible.
3. Deploy the definition.
4. Assign in a low-risk scope with enforcement disabled.
5. Validate compliance results.
6. Test compliant and non-compliant deployments.
7. Review false positives and false negatives.
8. Add remediation where appropriate.
9. Move to audit in broader scopes.
10. Move to deny only after impact is understood.

This avoids breaking legitimate deployments because of untested assumptions.

## Pull request workflow

A pull request should show:

- Policy intent
- Definition changes
- Initiative changes
- Assignment changes
- Parameter changes
- Expected impact
- Test evidence
- Rollback approach

Reviewers should pay special attention to:

- Effects changing from audit to deny
- Assignments at broad scopes
- Exemptions without expiry
- Remediation role assignments
- Policies that affect common resource types

## CI validation

The pipeline should validate policy code before merge.

Useful checks:

- Terraform format check
- Terraform validation
- Static analysis
- JSON validation for embedded policy rules
- Naming convention checks
- Required metadata checks
- Documentation checks
- Plan output review

Policy code should not be merged if it cannot be planned cleanly.

## Deployment pipeline

A policy deployment pipeline can use stages such as:

```text
validate
plan-dev
deploy-dev
evaluate-dev
plan-test
deploy-test
evaluate-test
approval
plan-prod
deploy-prod
evaluate-prod
```

The evaluation stages are important. The platform should confirm that policy results match expectations after deployment.

## Exemptions as code

Policy exemptions should be tracked in code wherever practical.

A good exemption record includes:

- Scope
- Policy or initiative reference
- Owner
- Reason
- Expiry date
- Review date
- Compensating controls
- Approval reference

Exemptions without expiry should be rare.

## Remediation design

Policies using `DeployIfNotExists` or `Modify` may require managed identities and role assignments to remediate non-compliant resources.

Design considerations:

- Which identity performs remediation?
- Which roles are required?
- At what scope are those roles assigned?
- How are remediation tasks triggered?
- How are remediation failures reviewed?
- How is remediation tested?

Remediation is powerful. It should be reviewed like any other automated change mechanism.

## Handling drift

Policy drift can happen when changes are made manually.

Detect drift by:

- Running scheduled Terraform plans
- Comparing assigned policies to repository state
- Auditing portal changes
- Reviewing role assignments used for manual policy changes

If manual emergency changes occur, reconcile them back to code or revert them.

## Versioning policy assets

Version policies when behaviour changes.

Examples of version-worthy changes:

- Effect changes
- Rule logic changes
- Parameter schema changes
- Initiative membership changes
- Assignment scope changes

Versioning helps teams understand when a policy behaviour changed and supports safer rollback.

## Rollback planning

Every high-impact policy change should have a rollback path.

Rollback options include:

- Disable assignment
- Set enforcement mode to disabled
- Revert to previous definition version
- Remove policy from initiative
- Add time-bound exemption
- Revert Terraform commit

Do not rely on improvising rollback during an incident.

## Reporting and ownership

Policy reporting should answer:

- Which resources are non-compliant?
- Which teams own them?
- Which exemptions expire soon?
- Which deny policies are blocking deployments?
- Which remediation tasks failed?
- Which policy changes happened recently?

Compliance views should lead to action, not just dashboard review.

## Common mistakes

### Using deny too early

Deny is valuable when mature. Used too early, it creates delivery friction and exceptions.

### No test scope

Policies need realistic validation before broad assignment.

### Manual exemptions

Manual exemptions become invisible technical debt.

### Broad remediation permissions

Remediation identities should have only the access they need.

### No rollback plan

Policy changes can affect many teams. Rollback must be planned.

## Readiness checklist

Before using policy as code for production controls, confirm:

- Policy repository structure is documented
- Definitions and assignments are separated
- Initiatives are purpose-specific
- Terraform state is protected
- Pull request validation exists
- Policy tests are defined
- Enforcement rollout stages exist
- Exemptions include ownership and expiry
- Remediation identity permissions are reviewed
- Scheduled drift detection exists
- Reporting ownership is clear

## Final recommendation

Policy as code turns governance into an engineering workflow.

The strongest model combines careful authoring, controlled deployment, staged enforcement, visible exemptions, and ongoing compliance reporting.

A landing zone becomes more trustworthy when policy changes are as reviewable and repeatable as the infrastructure they govern.
