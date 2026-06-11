---
layout: post
title: Azure Identity and Privileged Access Design for Platform Engineering
date: 2026-07-17 09:00 +1000
categories: [Azure]
tags: [azure, identity, rbac, privileged-access, pim, landing-zone, platform-engineering]
description: A practical design guide for Azure identity, RBAC, privileged access, break-glass access, and role governance in platform engineering.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the identity and privileged access layer.

Identity is the control plane for the cloud platform. If identity is weak, every other control becomes easier to bypass.

A landing zone needs more than a list of admin groups. It needs a clear access model, role boundaries, privileged elevation, break-glass process, monitoring, and review cadence.

## Current Microsoft guidance to anchor the design

Microsoft's Azure RBAC best practices recommend least privilege, assigning roles to groups rather than individual users, limiting subscription owners, using narrow scopes, avoiding wildcard permissions, and using Microsoft Entra Privileged Identity Management for time-bound access where available.

Useful references:

- Azure RBAC best practices: <https://learn.microsoft.com/en-us/azure/role-based-access-control/best-practices>
- Azure built-in roles: <https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles>
- Microsoft Entra Privileged Identity Management: <https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure>
- Emergency access accounts guidance: <https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access>

## Design objectives

The identity model should provide:

- Least privilege
- Group-based access
- Clear role boundaries
- Time-bound privileged access
- Controlled emergency access
- Separation of duties
- Auditable role assignments
- Regular access reviews
- Strong authentication requirements
- Consistent onboarding and offboarding

The goal is to give teams the access they need without leaving broad permanent access scattered across the platform.

## Access model layers

Think about access in layers.

```text
Tenant roles
Management group roles
Subscription roles
Resource group roles
Resource roles
Application roles
```

The higher the scope, the more dangerous the assignment.

A Contributor role at a resource group is very different from Contributor at a platform management group.

## Use groups, not direct users

Assign Azure roles to groups wherever possible.

Benefits:

- Easier access reviews
- Cleaner onboarding
- Cleaner offboarding
- Better separation of duties
- Less direct permission sprawl

Direct user assignments should be rare and justified.

## Scope roles narrowly

Use the narrowest scope that supports the work.

Preferred order:

1. Resource scope where practical
2. Resource group scope
3. Subscription scope
4. Management group scope only when necessary

Management group assignments should be carefully controlled because permissions inherit to child subscriptions.

## Limit Owner access

Owner is a powerful role because it can manage resources and delegate access.

Reduce Owner assignments by using more specific roles such as:

- Contributor
- Reader
- Network Contributor
- Monitoring Contributor
- Security Reader
- Cost Management Reader
- Key Vault specific roles

Owner access should be eligible, time-bound, monitored, and reviewed.

## Separate platform roles

A platform should define a small set of standard role groups.

Examples:

```text
Platform-Owners
Platform-Contributors
Platform-Network-Operators
Platform-Security-Operators
Platform-Monitoring-Operators
Workload-Owners
Workload-Contributors
Workload-Readers
Cost-Readers
Audit-Readers
```

Names should describe function and scope.

## Privileged access elevation

Privileged access should be time-bound where possible.

Use elevation for roles such as:

- Owner
- User Access Administrator
- Contributor at broad scopes
- Security Administrator
- Key Vault Administrator
- Network Contributor on shared networking

Elevation should include:

- Justification
- Duration
- Approval for high-impact roles
- Notification
- Audit log capture

## Role assignment governance

Role assignments should be treated as configuration, not casual administration.

Track:

- Who has access
- Why they have access
- Scope
- Role
- Assignment type
- Expiry where applicable
- Last review date

Broad role assignments should be reviewed more often than narrow assignments.

## Custom roles

Custom roles are useful when built-in roles are too broad.

Use custom roles carefully.

Good candidates:

- Platform deployment operator
- Firewall rule reviewer
- Monitoring dashboard maintainer
- Cost report reader
- Private endpoint approver

Avoid creating too many custom roles. They increase review and maintenance effort.

## Deployment identities

Pipeline identities are privileged identities.

They should have:

- Dedicated service connection or federated identity
- Minimal required permissions
- Separate identities per environment or domain
- No interactive sign-in
- Clear ownership
- Review cadence
- Audit monitoring

Do not use a single high-privilege deployment identity across every environment.

## Break-glass access

Emergency access exists for rare situations where normal access paths are unavailable.

Emergency accounts should be:

- Clearly documented
- Protected with strong credentials
- Excluded from controls only where necessary
- Monitored heavily
- Tested periodically
- Limited in number
- Stored and used through a controlled process

Break-glass accounts should not be used for routine administration.

## Access reviews

Access reviews help detect stale access.

Review frequency should depend on risk.

Suggested cadence:

```text
High-impact privileged roles: monthly or quarterly
Platform contributor roles: quarterly
Workload contributor roles: quarterly or six-monthly
Reader roles: six-monthly or annually
Emergency access: after each test and at least quarterly
```

The right cadence depends on risk and operational maturity.

## Monitoring privileged activity

Monitor events such as:

- Owner role assignment
- User Access Administrator assignment
- Role assignment deletion
- New service principal credentials
- Conditional access changes
- Emergency account sign-in
- Key Vault access changes
- Management group permission changes

Alerts should go to an owned operational queue.

## Separation of duties

Avoid one person or group controlling every part of the platform without review.

Examples:

- Network rule changes require review.
- Policy deny changes require review.
- Role assignments require review.
- Production apply requires approval.
- Emergency access use requires reconciliation.

Separation of duties should reduce risk without making routine work impossible.

## Common mistakes

### Assigning Owner everywhere

Owner should be rare and time-bound.

### Direct user assignments

Direct assignments are harder to govern than group-based access.

### No review of service principals

Automation identities can become forgotten high-privilege accounts.

### Emergency accounts used casually

Emergency access should be exceptional.

### No monitoring of role changes

Role changes are platform-impacting events.

## Readiness checklist

Before scaling the platform, confirm:

- Role model is documented
- Groups are used for access assignments
- Owner assignments are limited
- Privileged roles are time-bound where possible
- Deployment identities are scoped narrowly
- Emergency access process exists
- Access reviews are scheduled
- Role assignment changes are monitored
- Custom roles are documented
- Offboarding process removes access reliably

## Final recommendation

Design identity as a platform capability, not an afterthought.

Use least privilege, narrow scopes, group-based access, privileged elevation, and regular reviews. The result is a platform that can move quickly without leaving permanent high-risk access everywhere.
