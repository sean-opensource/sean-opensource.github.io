---
layout: page
title: Azure
permalink: /azure/
---

# Azure

Azure articles on Chilepluto focus on platform engineering, landing zones, cloud governance, automation, identity, networking, monitoring, and FinOps.

## Start here

- [Azure Landing Zones](/azure-landing-zones/)

## Published Azure articles

{% assign has_azure_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'Azure' %}
    {% assign has_azure_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_azure_posts %}
No Azure articles are currently published.
{% endunless %}

## Upcoming focus areas

The Azure content cluster is planned to cover:

- Landing zone design
- Management groups and subscriptions
- Policy guardrails
- Terraform and Azure DevOps delivery
- Hub-and-spoke networking
- Logging and monitoring
- FinOps cost accountability
- Identity and privileged access
- Policy as code
- Platform operating models

## Related topics

- [PowerShell](/powershell/)
- [Python](/python/)
- [WSL](/wsl/)
- [Local AI](/local-ai/)
