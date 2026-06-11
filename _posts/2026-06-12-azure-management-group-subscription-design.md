---
layout: post
title: Azure Management Group and Subscription Design for Secure Enterprise Platforms
date: 2026-06-12 09:00 +1000
categories: [Azure]
tags: [azure, landing-zone, management-groups, subscriptions, cloud-governance, rbac, policy]
description: A practical deep dive into management group and subscription design for secure, governed Azure platforms.
---

This article is part of the Azure landing zone content cluster. Start with [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) for the wider architecture context.

Management groups and subscriptions form the control structure for an Azure platform. They influence policy inheritance, access boundaries, operational ownership, billing views, and the way teams onboard workloads.

Poor structure creates long-term friction. A structure that is too flat becomes hard to govern. A structure that is too deep becomes hard to explain, operate, and troubleshoot.

The goal is not to model every team, application, or internal reporting line. The goal is to create a stable platform hierarchy that supports governance and delivery without becoming a maze.

## Current Microsoft guidance to anchor the design

Microsoft's Azure landing zone guidance treats resource organisation as one of the core design areas. It highlights that subscription design and management group hierarchy affect governance, operations management, and adoption patterns.

Microsoft's management group guidance also recommends keeping the hierarchy reasonably flat, ideally no more than three to four levels. It warns against duplicating the full organisational structure into a deeply nested hierarchy and recommends using management groups mainly for policy assignment and platform governance rather than as a mirror of business reporting lines.

Key references:

- Azure landing zone design areas: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas>
- Azure landing zone design principles: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-principles>
- Management group guidance: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/resource-org-management-groups>

## Design objectives

A useful management group and subscription model should support:

- Central policy assignment
- Clear subscription placement
- Separate platform and workload responsibility
- Controlled privileged access
- Consistent environment separation
- Simple cost visibility
- Repeatable subscription onboarding
- Reduced policy exceptions
- Predictable operations

The structure should be boring. Boring is good when the structure is used every day by platform teams, security teams, workload teams, finance teams, and support teams.

## Recommended hierarchy

A practical enterprise hierarchy can start with this pattern:

```text
Tenant Root Group
├── Platform
│   ├── Connectivity
│   ├── Identity
│   └── Management
├── Landing Zones
│   ├── Production
│   └── Non-Production
├── Sandbox
└── Decommissioned
```

This model separates platform subscriptions from workload subscriptions and gives you clean places to apply different policy sets.

## Tenant root group

The tenant root group should have very limited direct assignment.

Use it for only the policies and controls that must apply everywhere. Examples might include baseline audit policies, mandatory security expectations, or broad deny assignments that should cover the whole tenant.

Avoid assigning too many policies at the root. Root-level mistakes affect everything.

### Root group controls

Recommended root controls:

- Require approved regions or audit unapproved regions
- Audit missing diagnostic settings
- Audit missing required tags
- Restrict high-risk resource providers where appropriate
- Apply baseline security posture assessment
- Limit who can create new management groups

Root controls should be reviewed carefully because inheritance can produce unexpected impact.

## Platform management group

The platform management group contains subscriptions used by central platform capabilities.

Common platform subscriptions include:

- Connectivity
- Management
- Identity or shared services
- Automation
- Security tooling

These subscriptions typically have fewer owners and stronger access controls than workload subscriptions.

## Connectivity subscription

The connectivity subscription contains shared network services such as:

- Hub virtual network
- Firewall
- Gateway services
- DNS forwarding
- Private DNS zones
- Network monitoring
- Shared ingress or egress services

This subscription should be controlled by the platform or network team. Workload teams should not be able to make unreviewed changes to central routing, firewall, or DNS.

## Management subscription

The management subscription contains central operational services such as:

- Monitoring workspaces
- Automation accounts
- Update or inventory services
- Alert processing
- Dashboards
- Shared operational storage

Do not mix business workloads into the management subscription. Keep it reserved for platform operations.

## Identity subscription

Some environments use a dedicated identity or shared services subscription. This can contain services that support authentication, directory integration, secure administration, or platform identity workflows.

Whether this is separate depends on scale and operating model. If the identity footprint is small, it may be part of a management subscription. If the platform is large or complex, separation can help.

## Landing Zones management group

The landing zones management group is the parent for workload subscriptions.

It should contain the common policies that apply to workload environments, such as:

- Required tags
- Diagnostic setting requirements
- Public exposure controls
- Region restrictions
- Secure configuration audits
- Resource type restrictions

The key is to keep policies aligned to workload needs, not platform service needs.

## Production management group

Production workloads should have stricter controls.

Recommended production controls:

- Stronger change control
- Required diagnostic settings
- Mandatory budget and owner tags
- Public IP restrictions
- Private endpoint preference for selected services
- Controlled role assignment
- Higher alerting expectations
- Stronger backup and recovery requirements

Production policy should prevent unsafe defaults but still allow approved deployment patterns.

## Non-production management group

Non-production should be governed but allow more flexibility.

Recommended non-production controls:

- Required ownership tags
- Budget alerts
- Region controls
- Audit-first policies for some services
- Lower-cost SKUs where practical
- Expiry tags for temporary resources
- Relaxed controls for approved development patterns

Non-production is where teams learn. It should not become an unmanaged shadow estate.

## Sandbox management group

Sandbox subscriptions are useful, but they need boundaries.

Recommended sandbox guardrails:

- Budget cap
- Expiry date
- No production data
- No persistent public exposure by default
- Limited role assignment
- Automatic cleanup process
- Clear owner tag

A sandbox should be easy to create and easy to delete.

## Decommissioned management group

A decommissioned management group is useful for subscriptions being retired.

Controls can include:

- Deny new resource creation
- Preserve logging
- Retain access for cleanup teams
- Track decommissioning status
- Prevent accidental reuse

This provides a safe holding pattern while final cleanup occurs.

## Subscription design rules

Subscriptions should normally align to:

- Environment
- Ownership
- Risk
- Network boundary
- Cost accountability
- Operational support model

Avoid placing unrelated production systems into the same subscription just because they were created at the same time.

Also avoid one subscription per tiny component if it makes operations harder. The subscription boundary should serve a purpose.

## Subscription vending

A mature platform should offer a controlled subscription vending process.

The request should capture:

- Workload name
- Environment
- Owner
- Cost centre
- Required connectivity pattern
- Data sensitivity level in generic business terms
- Expected regions
- Required policies
- Support group
- Expiry date for temporary subscriptions

The vending process should create or configure:

- Subscription placement
- Baseline tags
- RBAC groups
- Policy assignments
- Budget alerts
- Diagnostic settings
- Network association
- Initial resource groups

The result is a ready-to-use subscription with guardrails already in place.

## RBAC placement

Do not casually assign workload teams permissions at management group scope.

Management group RBAC inheritance is powerful. It can easily grant more access than intended.

Preferred approach:

- Platform teams may have controlled privileged access at platform scopes.
- Workload teams receive access at subscription or resource group scope.
- Break-glass and high-impact roles are monitored.
- Role assignments are reviewed periodically.

Use privileged elevation for roles that have broad impact.

## Policy placement

Use management groups for policy assignment because policies are meant to inherit across subscriptions.

A useful pattern is:

```text
Root: broad baseline controls
Platform: platform-specific controls
Landing Zones: common workload controls
Production: strict workload controls
Non-Production: flexible workload controls
Sandbox: cost and exposure controls
```

Policy placement should be documented. If a team cannot explain where a policy is assigned, troubleshooting becomes slow.

## Tagging strategy

Tags should support operations and cost reporting. They should not become a dumping ground for every possible metadata field.

Start with a small mandatory set:

```text
Application
Environment
Owner
CostCentre
ManagedBy
Criticality
ExpiryDate
```

Use policy to audit or append tags where appropriate. Be careful with strict deny policies for tags early in the platform lifecycle because they can block deployments and create frustration.

## Common anti-patterns

### Copying the organisation chart

Organisation charts change. Platform hierarchy should be more stable.

Use tags, cost management, and reporting to slice by team or business function instead of creating deep management group nesting.

### Too many top-level exceptions

Every exception at a high scope becomes a platform behaviour. Keep exceptions close to the workload that needs them.

### Unmanaged subscription creation

If new subscriptions appear outside the hierarchy, policy and logging coverage can be inconsistent.

Control subscription creation and placement.

### Mixing platform and workload ownership

Workload teams should not manage central firewall, DNS, or platform logging services.

Keep shared platform services in platform subscriptions.

## Readiness checklist

Before you consider the hierarchy ready, confirm:

- Management group hierarchy is documented
- Subscription placement rules are clear
- Platform subscriptions are separate from workloads
- Production and non-production controls differ intentionally
- Sandbox controls exist
- RBAC scope rules are documented
- Subscription vending process exists or is planned
- Tags support cost and ownership reporting
- Policy assignment locations are documented
- Decommissioning path exists

## Final recommendation

Start with a simple hierarchy and mature it through controlled change.

The best management group structure is the one that platform teams can operate, workload teams can understand, and security and finance teams can use for consistent control and reporting.

Do not design for theoretical elegance. Design for repeatable operations.
