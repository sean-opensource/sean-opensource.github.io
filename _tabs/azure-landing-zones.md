---
title: Azure Landing Zones
icon: fas fa-cloud
order: 5
---

# Azure Landing Zones

This page is the curated reading path for Chilepluto articles on Azure landing zones, cloud governance, platform engineering, automation, FinOps, and operating models.

Start with the foundation article, then follow the supporting articles as they publish.

## Published articles

{% assign has_azure_cluster_posts = false %}
{% for post in site.posts %}
  {% if post.tags contains 'landing-zone' or post.tags contains 'cloud-governance' or post.tags contains 'platform-engineering' or post.categories contains 'Azure' %}
    {% assign has_azure_cluster_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_azure_cluster_posts %}
No Azure landing zone articles are currently published.
{% endunless %}

## Scheduled reading path

The planned content cluster is:

1. Practical Azure Landing Zone Design for Secure Enterprise Platforms
2. Azure Management Group and Subscription Design for Secure Enterprise Platforms
3. Azure Policy Guardrails for Enterprise Landing Zones
4. Terraform and Azure DevOps Delivery Model for Landing Zones
5. Azure Hub-and-Spoke Networking for Enterprise Landing Zones
6. Azure Logging and Monitoring Baseline for Landing Zones
7. FinOps Tagging and Cost Accountability for Azure Platforms
8. Azure Identity and Privileged Access Design for Platform Engineering
9. Azure Policy as Code with Terraform
10. Enterprise Platform Operating Model for Cloud Governance Teams

## What the cluster covers

The articles are written as practical engineering notes for building and operating secure enterprise Azure platforms.

They cover:

- Landing zone architecture
- Management groups and subscriptions
- Policy and guardrails
- Terraform and Azure DevOps delivery
- Hub-and-spoke networking
- Logging, monitoring, and alerting
- FinOps and cost accountability
- Identity and privileged access
- Policy as code
- Platform operating models

## How to use this page

Use this page as a map. Each article is designed to stand alone, but the cluster works best when read as a sequence from architecture through operations.

For implementation work, start with the landing zone design article and then jump to the topic that matches the current design decision as each article becomes available.
