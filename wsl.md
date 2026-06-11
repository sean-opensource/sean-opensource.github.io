---
layout: page
title: WSL
permalink: /wsl/
---

# WSL

WSL articles on Chilepluto focus on practical Windows/Linux developer workflows, Python setup, troubleshooting, containers, and repeatable local environments.

## Published WSL articles

{% assign has_wsl_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'WSL' or post.tags contains 'wsl' %}
    {% assign has_wsl_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_wsl_posts %}
WSL articles are scheduled and will appear here as they publish.
{% endunless %}

## Upcoming focus areas

- Python setup in WSL
- WSL troubleshooting
- VS Code Dev Containers
- Testing and formatting inside WSL

## Related topics

- [Python](/python/)
- [PowerShell](/powershell/)
- [Local AI](/local-ai/)
