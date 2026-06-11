---
layout: page
title: PowerShell
permalink: /powershell/
---

# PowerShell

PowerShell articles on Chilepluto focus on practical administration, safe automation, Windows operations, and repeatable troubleshooting.

## Published PowerShell articles

{% assign has_powershell_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'PowerShell' or post.tags contains 'powershell' %}
    {% assign has_powershell_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_powershell_posts %}
PowerShell articles are scheduled and will appear here as they publish.
{% endunless %}

## Upcoming focus areas

- Safe credential storage
- Remoting and WinRM
- Network drive management
- ADFS administration
- Windows automation patterns

## Related topics

- [Azure](/azure/)
- [WSL](/wsl/)
- [Python](/python/)
