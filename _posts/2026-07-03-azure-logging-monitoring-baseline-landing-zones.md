---
layout: post
title: Azure Logging and Monitoring Baseline for Landing Zones
date: 2026-07-03 09:00 +1000
categories: [Azure]
tags: [azure, monitoring, logging, observability, landing-zone, azure-monitor, platform-engineering]
description: A practical baseline for Azure logging, monitoring, alerting, and operational observability in landing zones.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the observability and operations layer.

Many platform teams spend months designing identity, networking, and policy controls while observability receives little attention. The result is a platform that looks compliant but is difficult to operate.

A landing zone should make operational visibility a built-in capability, not an optional workload decision.

## Current Microsoft guidance to anchor the design

Microsoft's Azure landing zone design areas identify management, monitoring, and governance as foundational platform capabilities. Azure Monitor remains the central monitoring platform for metrics, logs, alerts, visualisation, and operational insight.

Useful references:

- Azure Monitor overview: https://learn.microsoft.com/en-us/azure/azure-monitor/overview
- Azure landing zone design areas: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-areas
- Diagnostic settings documentation: https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/diagnostic-settings

## Observability objectives

The baseline should provide:

- Platform visibility
- Resource visibility
- Alerting
- Capacity awareness
- Configuration change visibility
- Cost awareness
- Operational ownership
- Troubleshooting support
- Historical investigation capability
- Consistent onboarding patterns

Monitoring should help answer what happened, when it happened, who changed it, and what should happen next.

## Logging layers

A landing zone should collect information from multiple layers.

### Control plane

Control plane events describe management activity.

Examples:

- Resource creation
- Resource deletion
- Policy assignment changes
- Role assignment changes
- Subscription changes
- Network changes

These events help explain configuration drift and operational incidents.

### Resource logs

Resource logs provide service-specific information.

Examples:

- Key Vault operations
- Firewall activity
- Storage access events
- Application Gateway logs
- Kubernetes diagnostics
- Database diagnostics

Resource logs often become the primary source for troubleshooting.

### Metrics

Metrics provide performance and health information.

Examples:

- CPU
- Memory
- Requests
- Latency
- Throughput
- Error counts

Metrics are useful for alerting and trend analysis.

### Platform pipeline logs

Infrastructure delivery platforms should also be observable.

Track:

- Deployment success
- Deployment failure
- Terraform plan changes
- Pipeline execution history
- Approval activity

Platform changes are part of the operational story.

## Diagnostic settings strategy

Diagnostic settings are one of the most important baseline controls.

A platform should define:

- Which services require diagnostics
- Log destinations
- Retention expectations
- Ownership model
- Policy enforcement approach

Use policy to audit or deploy diagnostic settings for critical services.

## Priority resources

At minimum review diagnostics for:

- Key Vault
- Storage accounts
- Azure Firewall
- Application Gateway
- Public IPs
- Network security groups
- SQL services
- Kubernetes clusters
- Container registries
- Load balancers

Do not assume every service has identical diagnostic categories.

## Central log architecture

A central log destination simplifies operations.

Benefits include:

- Consistent querying
- Central alerting
- Shared dashboards
- Operational reporting
- Reduced configuration drift

Avoid creating many isolated monitoring silos unless there is a clear reason.

## Alert design

Alerts should drive action.

Good alerts:

- Have an owner
- Have a documented response
- Are actionable
- Avoid duplication
- Are reviewed regularly

Bad alerts generate noise and eventually become ignored.

## Recommended platform alerts

Examples include:

- Role assignment changes
- Policy assignment changes
- Firewall rule changes
- Public IP creation
- Budget threshold breaches
- Diagnostic setting removal
- Resource deletion events
- Subscription creation events

These alerts help identify platform-impacting changes.

## Dashboard strategy

Dashboards should support operations.

Useful dashboard areas:

- Platform health
- Networking
- Identity activity
- Deployment activity
- Cost visibility
- Security posture trends
- Alert status

Keep dashboards focused. A dashboard with hundreds of tiles is difficult to use during an incident.

## Retention planning

Retention has operational and cost implications.

Questions to answer:

- How long is operational troubleshooting data required?
- How long are change records useful?
- Which logs are high volume?
- Which logs support investigations?
- Which logs need archival patterns?

Retention should be intentional rather than left at defaults.

## Ownership model

Monitoring without ownership creates blind spots.

Define owners for:

- Alert rules
- Dashboards
- Diagnostic settings
- Log destinations
- Cost monitoring
- Reporting cadence

Every monitoring capability should have an accountable owner.

## Common mistakes

### Collecting everything

Not every log source provides value. Balance visibility with cost.

### No alert review process

Alert quality degrades over time.

### Monitoring only workloads

Platform services also require visibility.

### No onboarding standard

New workloads should inherit monitoring expectations automatically.

### Ignoring costs

Logging and retention can become expensive when growth is unmanaged.

## Readiness checklist

Before onboarding workloads, confirm:

- Monitoring architecture exists
- Diagnostic standards are documented
- Critical resources have diagnostics enabled
- Alert ownership is defined
- Dashboard standards exist
- Log retention is documented
- Platform deployment logs are retained
- Cost monitoring exists
- Monitoring onboarding is automated where possible

## Final recommendation

Observability should be treated as a platform capability.

A landing zone is easier to secure, govern, and operate when logging, monitoring, and alerting are built into the foundation rather than added later.
