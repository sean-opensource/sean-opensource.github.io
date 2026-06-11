---
layout: post
title: Enterprise Platform Operating Model for Cloud Governance Teams
date: 2026-07-31 09:00 +1000
categories: [Azure]
tags: [azure, cloud-governance, operating-model, platform-engineering, landing-zone, finops, devops]
description: A detailed operating model for cloud governance teams running secure, repeatable enterprise Azure platforms.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the operating model needed to run the platform after deployment.

A landing zone is not finished when the Terraform apply succeeds. The platform needs people, process, service ownership, change control, exception handling, release management, support paths, financial accountability, and continuous improvement.

Without an operating model, the landing zone becomes a set of technical components rather than a reliable platform product.

## Current guidance to anchor the design

Microsoft's Cloud Adoption Framework describes cloud operating models as a way to organise people, processes, and technology to support cloud adoption and operations. Azure landing zone guidance also treats operations, management, governance, security, and platform automation as ongoing disciplines rather than one-time setup tasks.

Useful references:

- Cloud operating model overview: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/operating-model/>
- Azure landing zone design areas: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas>
- Azure Well-Architected Framework: <https://learn.microsoft.com/en-us/azure/well-architected/>

## Operating model objectives

A platform operating model should define:

- What the platform team owns
- What workload teams own
- How changes are requested and approved
- How exceptions are handled
- How incidents are managed
- How cost accountability works
- How security findings are triaged
- How platform releases are planned
- How documentation is maintained
- How the platform improves over time

The goal is to make the platform dependable and consumable.

## Treat the platform as a product

The platform should have a product mindset.

That means it has:

- Users
- Services
- Roadmap
- Backlog
- Release cadence
- Documentation
- Support model
- Service catalogue
- Feedback loop
- Operational metrics

Workload teams are internal customers. They need clear patterns, good documentation, and predictable support.

## Core platform services

Define platform services explicitly.

Examples:

- Subscription vending
- Management group placement
- Policy baseline
- Hub networking
- Spoke onboarding
- DNS services
- Firewall rule management
- Monitoring baseline
- Logging workspace pattern
- Identity and RBAC model
- Privileged access process
- Terraform modules
- Pipeline templates
- Cost reporting
- Exception management

If a service is not defined, teams will invent their own path.

## Responsibility model

A simple responsibility model reduces confusion.

Example:

```text
Platform team owns:
- Landing zone architecture
- Shared networking
- Policy framework
- Platform automation
- Monitoring baseline
- Subscription vending
- Platform documentation

Workload teams own:
- Application design
- Application data
- Workload configuration
- Application monitoring
- Resource sizing
- Workload cost optimisation
- Workload support

Shared ownership:
- Firewall rules
- Private endpoint onboarding
- Production release readiness
- Incident response
- Cost review
```

Shared ownership should have clear workflows.

## Team capabilities

A cloud governance and platform team usually needs capabilities across:

- Architecture
- Networking
- Identity
- Security
- Automation
- Monitoring
- FinOps
- Developer enablement
- Documentation
- Service management

Not every capability needs a separate person, but every capability needs an owner.

## Service catalogue

A service catalogue helps teams consume the platform.

Useful catalogue entries include:

- Request a subscription
- Request a spoke network
- Request firewall rule
- Request private endpoint support
- Request policy exemption
- Request monitoring onboarding
- Request cost report
- Request privileged access
- Request platform design review

Each catalogue item should explain:

- Purpose
- Required inputs
- Approval path
- Expected outcome
- Target response time
- Owner
- Related documentation

## Subscription vending process

Subscription vending should be controlled and repeatable.

The request should capture:

- Workload name
- Environment
- Owner
- Cost centre
- Required connectivity
- Data sensitivity in generic business terms
- Expected regions
- Support group
- Budget owner
- Required launch date

The vending workflow should create:

- Subscription placement
- Baseline tags
- RBAC groups
- Budget alerts
- Policy assignments
- Diagnostic settings
- Network association where needed
- Documentation record

This prevents empty unmanaged subscriptions.

## Change management

Platform changes should be risk-based.

Low-risk changes may follow a lightweight pull request process. High-risk changes require deeper review.

High-risk examples:

- Management group restructure
- Policy deny changes
- Shared firewall changes
- Hub network routing changes
- Identity role model changes
- Terraform state moves
- Production pipeline changes
- Log retention changes

The goal is not bureaucracy. The goal is safe change.

## Release management

The platform should have a release cadence.

Release notes can include:

- New platform services
- Changed policies
- Deprecated patterns
- New modules
- Security baseline changes
- Known issues
- Required workload team actions

A predictable release cadence helps workload teams plan.

## Exception management

Exceptions are part of real platform operations.

A strong exception process includes:

- Requestor
- Owner
- Scope
- Reason
- Risk statement
- Compensating controls
- Expiry date
- Review date
- Approval record

Exceptions should be visible. Hidden exceptions become technical debt.

## Incident and problem management

Define how platform incidents are handled.

Questions to answer:

- Who triages platform alerts?
- Who owns shared network incidents?
- Who coordinates with workload teams?
- How are incident timelines recorded?
- How are post-incident actions tracked?
- How are recurring issues treated as problems?

Platform incidents often cross team boundaries, so coordination matters.

## Security operations integration

Security findings need an intake and triage path.

Define:

- Which team receives findings
- How severity is assigned
- How workload owners are notified
- How exceptions are approved
- How remediation is tracked
- How recurring findings influence platform patterns

Security operations should feed platform improvement, not just tickets.

## FinOps operating cadence

Cost accountability needs a rhythm.

Suggested cadence:

- Weekly anomaly review
- Fortnightly optimisation triage
- Monthly workload cost review
- Monthly platform cost report
- Quarterly reservation or savings review
- Quarterly tagging review

Cost review should result in engineering actions.

## Documentation model

Documentation should be treated as part of the platform.

Core documents:

- Landing zone overview
- Management group model
- Subscription vending guide
- Network onboarding guide
- DNS guide
- Policy catalogue
- RBAC model
- Monitoring baseline
- Cost model
- Exception process
- Operational runbooks
- Release notes

Documentation should live close to the code where possible.

## Metrics and reporting

Measure whether the platform is working.

Useful metrics:

- Subscription onboarding time
- Policy compliance trend
- Open exceptions
- Expired exceptions
- Budget alert count
- Cost optimisation backlog
- Platform incident count
- Mean time to restore platform incidents
- Deployment failure rate
- Drift findings
- Documentation freshness

Metrics should inform decisions, not exist for reporting alone.

## Platform backlog

The platform backlog should include:

- New capabilities
- Technical debt
- Security improvements
- Automation improvements
- Documentation updates
- FinOps actions
- Incident follow-up actions
- Workload team feedback

Prioritise work based on risk, value, and repeatability.

## Governance forums

A lightweight governance cadence can include:

- Weekly platform operations review
- Fortnightly engineering backlog review
- Monthly cost and governance review
- Monthly security and risk review
- Quarterly platform roadmap review

Keep forums focused. Avoid meetings that do not produce decisions or actions.

## Common mistakes

### Building technology without ownership

Every platform service needs an owner.

### No service catalogue

Teams will create their own paths when the platform path is unclear.

### Exceptions without expiry

Permanent exceptions are often undocumented platform design decisions.

### No release communication

Platform changes surprise teams when there is no release process.

### Dashboards without action

Metrics should drive decisions and backlog items.

## Readiness checklist

Before declaring the landing zone operational, confirm:

- Platform services are documented
- Responsibility model is clear
- Subscription vending process exists
- Change process is risk-based
- Exception process includes expiry
- Incident process is documented
- FinOps cadence exists
- Security findings have an intake path
- Platform backlog exists
- Release notes are published
- Documentation ownership is assigned
- Metrics are reviewed regularly

## Final recommendation

A landing zone succeeds when the operating model is as strong as the architecture.

The platform should be clear to consume, safe to change, easy to support, and continuously improved through evidence and feedback.

Treat the platform as a product, not a project. That mindset is what turns a cloud foundation into a dependable enterprise platform.
