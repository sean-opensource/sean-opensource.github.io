---
layout: post
title: Azure Hub-and-Spoke Networking for Enterprise Landing Zones
date: 2026-06-26 09:00 +1000
categories: [Azure]
tags: [azure, landing-zone, networking, hub-spoke, firewall, private-endpoints, dns, platform-engineering]
description: A detailed guide to designing Azure hub-and-spoke networking for secure enterprise landing zones.
---

This article supports [Practical Azure Landing Zone Design for Secure Enterprise Platforms](/posts/practical-azure-landing-zone-design-secure-enterprise-platforms/) by expanding the networking layer.

Networking is one of the hardest parts of an Azure landing zone to fix later. Management groups and policies can be refactored with care, but network routing, DNS, private endpoints, firewalls, and ingress patterns become deeply embedded in workload design.

A good network design gives workload teams safe, repeatable connectivity patterns. A poor design creates exceptions, direct internet exposure, DNS problems, routing surprises, and operational blind spots.

## Current Microsoft guidance to anchor the design

Microsoft's Azure landing zone design areas identify network topology and connectivity as a core design area. Microsoft guidance commonly uses hub-and-spoke or Virtual WAN based topologies for enterprise-scale connectivity, depending on scale, routing, and operational requirements.

Useful references:

- Azure landing zone network topology and connectivity: <https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity>
- Azure hub-spoke network topology: <https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/hub-spoke>
- Azure Private Endpoint DNS configuration: <https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns>
- Azure Firewall documentation: <https://learn.microsoft.com/en-us/azure/firewall/overview>

## Design objectives

The network design should provide:

- Controlled ingress
- Controlled egress
- Predictable routing
- Shared inspection points
- Workload segmentation
- Private connectivity to platform services
- Scalable DNS resolution
- Clear ownership between platform and workloads
- Observable network flows
- A path for future growth

The goal is not to create the most complex network possible. The goal is to create a network that is secure, understandable, and operable.

## Hub-and-spoke overview

A hub-and-spoke model separates shared network services from workload networks.

```text
External / On-premises / Partner Networks
                 |
              Hub VNet
      ┌──────────┼──────────┐
      |          |          |
   Spoke A    Spoke B    Spoke C
```

The hub contains shared services. Spokes contain workloads.

This pattern is useful because it centralises control while allowing workload networks to remain separated.

## Hub network responsibilities

The hub network usually contains:

- Firewall or secure egress service
- VPN or private connectivity gateways
- ExpressRoute gateway where used
- DNS forwarding
- Private DNS zones or links
- Bastion or secure administration pattern
- Shared ingress services where appropriate
- Network monitoring and flow logging

The hub should be owned by the platform or network team.

Workload teams should not have broad permissions to change the hub.

## Spoke network responsibilities

Spoke networks host workload resources.

A spoke might contain:

- Application subnets
- Private endpoints
- Internal load balancers
- Application gateways
- Kubernetes nodes
- Virtual machines
- Data services with private access

Spokes should be aligned to workload ownership and environment. Production and non-production should normally be separated.

## Routing model

Routing needs to be explicit.

Common routing decisions include:

- Should internet egress route through the hub firewall?
- Should spoke-to-spoke traffic be allowed?
- Should traffic to external networks route through the hub?
- Should platform services use private endpoints?
- Which subnets need route tables?

Do not rely on accidental default routes.

A common pattern is to associate route tables with workload subnets so that default outbound traffic goes through the hub firewall.

## Egress design

Egress is the path from workloads to the internet or external services.

Uncontrolled egress creates risk because workloads can reach destinations without inspection or clear logging.

A controlled egress design may include:

- Default route to firewall
- Application rules for approved destinations
- Network rules for required protocols
- FQDN tags or service tags where appropriate
- Logging of allowed and denied flows
- Review process for new outbound rules

Avoid allowing every spoke to create direct public egress without review.

## Ingress design

Ingress is the path into workloads.

Public ingress should be deliberate. It should use managed entry points and inspection where appropriate.

Possible ingress services include:

- Azure Front Door
- Application Gateway with Web Application Firewall
- Azure Firewall DNAT where suitable
- Internal load balancers for private-only services
- Private Link for service provider patterns

Avoid exposing administrative interfaces directly to the internet.

## Spoke-to-spoke traffic

Spoke-to-spoke traffic should not be automatically assumed.

Options include:

- No direct spoke-to-spoke traffic
- Spoke-to-spoke through firewall
- Direct peering for approved low-risk paths
- Shared service spokes for common dependencies

Routing all spoke-to-spoke traffic through a firewall improves visibility but may add cost and complexity. Direct peering is simpler but reduces inspection.

Choose intentionally.

## DNS architecture

DNS is a critical design area. Many network problems are DNS problems in disguise.

DNS design must support:

- Azure private endpoints
- Hybrid name resolution
- Internal application names
- Forwarding to external or internal resolvers
- Private DNS zone links
- Conditional forwarding
- Operational troubleshooting

Private endpoint DNS must be planned before workloads begin using private endpoints at scale.

## Private endpoints

Private endpoints bring supported Azure services into a virtual network through private IP addresses.

They are useful for reducing public exposure, but they introduce DNS and lifecycle complexity.

Design considerations:

- Which services require private endpoints?
- Where are private DNS zones hosted?
- Who owns private DNS zone links?
- How are private endpoints approved?
- Are network policies required on subnets?
- How are private endpoint IPs tracked?

Do not allow every workload team to create uncoordinated private DNS zones for the same service. This causes split-brain resolution and hard-to-diagnose outages.

## Network security groups

Network security groups remain useful for subnet and network-interface filtering.

Use them for local segmentation, but do not treat them as the only control.

Recommended practices:

- Use application security groups where helpful.
- Avoid broad `Any Any` rules.
- Use descriptive rule names.
- Keep priority ranges consistent.
- Document ownership.
- Review stale rules.

## Firewall design

Azure Firewall or another approved inspection service can provide central control for ingress, egress, and east-west traffic.

Design areas:

- Firewall policy hierarchy
- Rule collection groups
- Application rules
- Network rules
- DNAT rules
- Threat intelligence mode
- Logging destinations
- Change workflow
- Rule expiry and review

Firewall rules should have owners. A rule without an owner becomes technical debt.

## Subnet design

Subnet design should balance isolation and simplicity.

Common subnets:

- Application subnet
- Data subnet
- Private endpoint subnet
- Integration subnet
- Management subnet
- Gateway subnet where required
- Bastion subnet where used

Avoid creating a separate subnet for every tiny component unless there is a clear security or routing reason.

## IP address management

IP addressing needs central coordination.

Track:

- VNet address ranges
- Subnet ranges
- Reserved ranges
- Peering relationships
- Private endpoint ranges
- Hybrid route advertisements
- Overlap risks

Address space overlap is one of the most painful issues to fix after deployment.

## Network observability

Network operations need visibility.

Collect logs from:

- Firewall
- Application Gateway
- Network security groups where flow logs are used
- Public IPs
- Load balancers
- DNS services where available
- Private endpoint approval workflow

Alerts should cover:

- Firewall rule changes
- Route table changes
- Network security group changes
- Public IP creation
- Failed DNS resolution patterns where detectable
- Gateway health
- Unexpected traffic denies

## Platform versus workload ownership

Define ownership clearly.

Platform team owns:

- Hub network
- Firewall policy framework
- DNS platform
- Shared routing
- Connectivity gateways
- Network policy standards

Workload teams own:

- Spoke workload design
- Application-specific rules
- Private endpoints for their services
- Application ingress requirements
- Workload subnet use

Shared ownership areas need a request and approval process.

## Common mistakes

### Treating DNS as an afterthought

Private endpoints and hybrid connectivity depend on DNS. Design it early.

### Allowing uncontrolled public IPs

Public IP creation should be restricted or reviewed.

### Too much direct peering

Direct peering between many spokes becomes hard to reason about.

### No rule ownership

Firewall and NSG rules need owners and review dates.

### Ignoring cost

Firewall, logging, NAT, and data processing costs can become material. Include them in the design.

## Readiness checklist

Before onboarding production workloads, confirm:

- Hub network ownership is defined
- Spoke onboarding pattern exists
- IP addressing is centrally tracked
- DNS architecture is documented
- Private endpoint DNS is tested
- Egress path is controlled
- Ingress pattern is approved
- Firewall rule process exists
- Route table standards exist
- Public IP policy exists
- Network logs are collected
- Cost impact is understood

## Final recommendation

Keep the network design clear and intentional.

A landing zone network does not need to be clever. It needs to be predictable, secure, observable, and supportable.

The best network pattern is the one that platform teams can operate confidently and workload teams can consume without inventing their own exceptions.
