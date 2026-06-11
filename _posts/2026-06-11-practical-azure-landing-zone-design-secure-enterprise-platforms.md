---
layout: post
title: Practical Azure Landing Zone Design for Secure Enterprise Platforms
date: 2026-06-11 21:00 +1000
categories: [Azure]
tags: [azure, landing-zone, cloud-governance, terraform, azure-devops, security, networking, finops]
description: A practical design guide for building secure, governed, repeatable Azure landing zones for enterprise platforms.
---

Azure landing zones are not just a subscription structure. They are the foundation for how an organisation deploys, governs, secures, monitors, and operates cloud workloads at scale.

A good landing zone gives teams enough freedom to deliver quickly while still applying the controls needed for identity, networking, security, logging, cost management, and operational consistency.

This guide outlines a practical Azure landing zone design for secure enterprise platforms.

## What a landing zone should achieve

A landing zone should provide a repeatable platform for workloads. It should reduce the amount of custom design required for every new system and make the default path the safe path.

The core goals are:

- Consistent subscription and management group structure
- Clear separation between platform and workload responsibilities
- Centralised identity and privileged access controls
- Network patterns that support inspection, segmentation, and private connectivity
- Policy-driven guardrails
- Standard logging and monitoring
- Repeatable deployment through infrastructure as code
- Cost visibility and accountability
- Operational ownership and support model

The landing zone should be treated as a product. It needs lifecycle management, versioning, support, release planning, and continuous improvement.

## Design principles

Use a small set of principles to guide decisions.

### Keep the platform opinionated

A landing zone should not be an empty subscription with a few policies attached. It should provide standard patterns for identity, networking, monitoring, security, and deployment.

Teams should not have to rediscover the same design choices for every workload.

### Separate platform from workloads

The platform layer should provide shared services and guardrails. Workload teams should own their applications, data, and service-specific configuration.

This separation makes responsibilities clearer and reduces the risk of workload changes breaking shared platform services.

### Automate the default path

Manual setup does not scale. Landing zone components should be deployed through infrastructure as code, preferably through a controlled pipeline.

Automation makes the platform more consistent and easier to review.

### Design for operations

A landing zone is not finished when the first deployment succeeds. It must be observable, supportable, recoverable, and maintainable.

Operational needs should influence the design from the start.

### Make cost visible

Cost management is part of platform design. Tags, budgets, reporting, ownership, and chargeback or showback models should be included early.

Cost visibility should not be added after the environment has already grown uncontrolled.

## Management group model

Management groups provide the hierarchy used for policy, access control, and subscription organisation.

A simple enterprise model may include:

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

The exact structure should match the organisation, but it should stay simple. Too many management groups make policy and access harder to understand.

### Platform management groups

Platform management groups are used for shared services such as:

- Hub networking
- DNS
- Firewall and traffic inspection
- Shared monitoring
- Security tooling
- Identity integration
- Automation services

These subscriptions should have tightly controlled access and clear operational ownership.

### Workload management groups

Workload management groups are used for application and service subscriptions.

Separate production and non-production environments where required. Apply stricter policies to production and allow more flexibility in non-production where appropriate.

### Sandbox management group

Sandbox environments are useful for experimentation, but they should not be unmanaged.

Apply guardrails such as:

- Spending limits
- Region restrictions
- Expiry dates
- Deny public exposure by default
- No production data
- Clear owner tagging

## Subscription strategy

Subscriptions are a security, billing, quota, and operational boundary.

Common subscription types include:

- Connectivity subscription
- Management subscription
- Identity or shared services subscription
- Workload production subscriptions
- Workload non-production subscriptions
- Sandbox subscriptions

Avoid placing too many unrelated workloads in one subscription. Also avoid creating subscriptions so granular that operations become fragmented.

A useful rule is to align subscriptions to ownership, environment, and risk.

## Identity and access design

Identity is one of the most important landing zone design areas.

### Use role-based access control

Access should be granted through groups, not directly to individual users.

Use separate groups for:

- Platform administrators
- Network operators
- Security operators
- Workload owners
- Workload contributors
- Readers and auditors

Keep roles specific. Avoid broad owner access unless it is genuinely required.

### Use privileged access workflows

Privileged roles should be eligible rather than permanently assigned where possible.

Use just-in-time elevation, approval workflows, and auditing for high-impact roles.

Sensitive roles include:

- Owner
- User Access Administrator
- Contributor on platform subscriptions
- Security Administrator
- Network Contributor on shared networking
- Key Vault Administrator

### Protect break-glass access

Break-glass accounts should exist, but they should be tightly controlled.

They should be:

- Cloud-only where appropriate
- Excluded from conditional access only where necessary
- Protected with strong credentials
- Monitored heavily
- Tested periodically
- Documented with clear usage procedures

Break-glass access is for emergencies, not convenience.

## Network architecture

The network model should support secure connectivity, traffic inspection, segmentation, and predictable routing.

A common pattern is hub and spoke.

```text
On-premises / External Networks
          |
      Connectivity
          |
      Hub Network
      /    |    \
 Spoke  Spoke  Spoke
```

### Hub network

The hub network usually contains shared network services such as:

- Firewall
- VPN or private connectivity gateways
- DNS forwarding
- Bastion or secure access patterns
- Network monitoring
- Shared ingress or egress controls

The hub should be managed by the platform team.

### Spoke networks

Spokes host workload resources. Each spoke should have clear ownership and purpose.

Use separate spokes for major applications, environments, or business-aligned platforms where needed.

### Egress control

Uncontrolled internet egress creates risk and cost uncertainty.

Recommended controls include:

- Central egress through firewall or secure gateway
- Deny direct public outbound where possible
- Explicit allow rules for required destinations
- Logging of outbound flows
- Regular review of egress rules

### Ingress control

Public ingress should be intentional and reviewed.

Use managed ingress patterns such as:

- Web application firewall
- Reverse proxy or front door service
- Private endpoints where possible
- TLS enforcement
- Certificate lifecycle management

Avoid direct exposure of administrative interfaces.

### Private endpoints

Private endpoints help keep traffic to platform services on private IP paths.

Use them for services such as:

- Storage accounts
- Key Vault
- SQL services
- Container registries
- Platform APIs where supported

Private endpoints require careful DNS planning. Do not treat them as a simple checkbox.

## Policy and guardrails

Azure Policy is central to landing zone governance.

Policies should help teams deploy safely without blocking legitimate work unnecessarily.

Useful policy categories include:

- Allowed regions
- Required tags
- Deny public IP creation except by exception
- Enforce secure transfer
- Require diagnostic settings
- Restrict high-risk resource types
- Enforce private endpoint usage for selected services
- Require managed identities where suitable
- Audit insecure configurations

Start with audit where impact is uncertain. Move to deny or deploy-if-not-exists once the policy behaviour is understood.

## Logging and monitoring

Logging should be designed before workloads arrive.

At minimum, collect:

- Activity logs
- Resource diagnostic logs
- Security alerts
- Firewall logs
- Network flow logs where required
- Identity and sign-in logs where available
- Platform pipeline logs

Centralise logs into a managed monitoring and security workspace pattern.

### Diagnostic settings

Use policy to deploy or audit diagnostic settings for key resources.

Important resources include:

- Key Vault
- Storage accounts
- Firewalls
- Application gateways
- Public IPs
- Network security groups
- SQL services
- Kubernetes clusters
- Container registries

### Alerts

Create alerts for platform events such as:

- Policy assignment changes
- Role assignment changes
- New public IP creation
- Firewall rule changes
- Key Vault access policy changes
- Diagnostic setting removal
- Budget threshold breaches
- Security alert escalation

Alerts should go to an owned queue or operational process. Alerts without ownership become noise.

## Security baseline

A practical security baseline should cover identity, network, data, platform services, and operations.

Baseline controls may include:

- Multi-factor authentication
- Conditional access
- Just-in-time privileged access
- Role-based access control
- Central logging
- Defender plans where appropriate
- Key management standards
- Private connectivity patterns
- Secure configuration policies
- Vulnerability and posture management
- Incident response procedures

Security controls should be documented as deployable patterns, not just policy statements.

## Terraform deployment approach

Terraform is well suited to landing zone deployment when it is structured carefully.

A practical structure might look like:

```text
infra/
├── modules/
│   ├── management-groups/
│   ├── policy/
│   ├── networking-hub/
│   ├── networking-spoke/
│   ├── diagnostics/
│   └── role-assignments/
├── environments/
│   ├── platform/
│   ├── production/
│   └── non-production/
└── pipelines/
```

### Module design

Modules should be reusable but not overly abstract.

Good modules have:

- Clear inputs
- Clear outputs
- Strong defaults
- Minimal hidden behaviour
- Versioned releases
- Examples
- Tests or validation where practical

Avoid modules that try to support every possible scenario through dozens of optional parameters.

### State management

Terraform state must be protected.

Recommended practices:

- Store state in a dedicated storage account
- Enable soft delete and versioning
- Restrict access to state
- Separate state by environment or platform domain
- Avoid storing secrets in state where possible
- Use pipeline identities rather than personal credentials

### Pipeline flow

A simple pipeline flow should include:

1. Format check
2. Validation
3. Static analysis
4. Plan
5. Review
6. Apply
7. Post-deployment checks

Production applies should require approval.

## Azure DevOps delivery model

A landing zone pipeline should make infrastructure changes reviewable and repeatable.

Recommended pipeline features:

- Pull request validation
- Terraform plan published as an artifact
- Manual approval before production apply
- Separate service connections per environment
- Limited permissions for deployment identities
- Branch protection
- CODEOWNERS review
- Change history linked to work items where useful

The pipeline should not depend on a single engineer's local workstation.

## FinOps design

FinOps should be built into the landing zone from the beginning.

Important capabilities include:

- Mandatory owner and cost centre tags
- Budgets per subscription or workload
- Alerts for forecast and actual spend
- Regular cost review cadence
- Rightsizing recommendations
- Idle resource reporting
- Shared cost allocation model
- Reporting by service, owner, and environment

### Suggested baseline tags

Use a small number of required tags:

```text
Application
Environment
Owner
CostCentre
Criticality
DataClassification
ManagedBy
ExpiryDate
```

Not every tag needs to be perfect on day one, but ownership and environment tags should be reliable early.

## Operational model

A landing zone needs an operating model.

Define who owns:

- Management groups
- Policy assignments
- Platform subscriptions
- Shared networking
- Firewall rules
- DNS
- Monitoring
- Security alerts
- Terraform modules
- Pipelines
- Documentation
- Exceptions
- Cost reporting

Also define how changes are requested, reviewed, approved, deployed, and rolled back.

## Exception handling

Exceptions are normal. Unmanaged exceptions are the problem.

A good exception process includes:

- Business or technical justification
- Owner
- Expiry date
- Risk acceptance
- Compensating controls
- Review cadence
- Evidence of approval

Examples include temporary public IP access, non-standard regions, or diagnostic logging exemptions.

## Landing zone readiness checklist

Use this checklist before onboarding production workloads.

### Governance

- Management group hierarchy exists
- Subscription placement is documented
- Required policies are assigned
- Exceptions process exists
- Ownership model is clear

### Identity

- Admin roles are group-based
- Privileged access is controlled
- Break-glass process is documented
- Role assignments are reviewed

### Network

- Hub and spoke model is implemented
- DNS design is documented
- Egress path is controlled
- Ingress pattern is defined
- Private endpoint DNS is tested

### Security

- Security baseline is documented
- Defender or equivalent posture management is configured where required
- Key management pattern is defined
- Public exposure is controlled

### Monitoring

- Activity logs are collected
- Diagnostic settings are deployed or audited
- Alert ownership is defined
- Firewall and network logs are retained

### Automation

- Terraform state is protected
- Pipelines validate plans
- Production changes require approval
- Modules are versioned

### FinOps

- Tags are enforced or audited
- Budgets are configured
- Cost reporting exists
- Owners receive cost visibility

## Common mistakes

### Starting with subscriptions instead of operating model

A subscription hierarchy is not enough. Decide how the platform will be operated and governed.

### Making policies too strict too early

Overly strict deny policies can block delivery and encourage workarounds. Start with audit where needed and mature controls over time.

### Ignoring DNS

Private endpoints, hybrid connectivity, and platform services depend on DNS. Poor DNS design causes difficult troubleshooting later.

### Giving too many teams owner access

Owner access should be rare. Most teams need contributor access scoped to their workload, not full control of the subscription.

### Treating FinOps as reporting only

Reports are useful, but FinOps also requires ownership, tagging, budgets, review cadence, and engineering action.

## Final thoughts

A secure enterprise landing zone is a combination of architecture, automation, governance, and operations.

The goal is not to create a perfect platform on day one. The goal is to create a reliable foundation that can be improved safely over time.

Start with clear structure, controlled access, good networking, central logging, practical policy, and repeatable deployment. Then mature the platform through feedback, operational reviews, and measured improvements.

A landing zone is successful when workload teams can move faster because the platform has already solved the common problems for them.
