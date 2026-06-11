---
title: Start Here
icon: fas fa-compass
order: 0
---

# Start here

Chilepluto is a practical technical-notes site covering Azure platform engineering, automation, infrastructure operations, PowerShell, Python, WSL, and local AI workflows.

Use this page to find the best starting point.

## Azure and platform engineering

Start with:

- [Azure Landing Zones](/azure-landing-zones/)

The Azure cluster will expand as scheduled articles publish across landing zone design, Terraform delivery, networking, monitoring, FinOps, identity, policy as code, and platform operating models.

## PowerShell and Windows

Good starting points:

{% assign has_powershell_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'PowerShell' or post.tags contains 'powershell' %}
    {% assign has_powershell_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }})
  {% endif %}
{% endfor %}

{% unless has_powershell_posts %}
PowerShell articles are scheduled and will appear here as they publish.
{% endunless %}

## Python, WSL, and developer workflow

Good starting points:

{% assign has_python_wsl_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'Python' or post.categories contains 'WSL' or post.tags contains 'python' or post.tags contains 'wsl' %}
    {% assign has_python_wsl_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }})
  {% endif %}
{% endfor %}

{% unless has_python_wsl_posts %}
Python and WSL articles are scheduled and will appear here as they publish.
{% endunless %}

## Local AI and machine learning

Good starting points:

{% assign has_ai_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'AI' or post.tags contains 'local-ai' or post.tags contains 'llm' %}
    {% assign has_ai_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }})
  {% endif %}
{% endfor %}

{% unless has_ai_posts %}
Local AI articles are scheduled and will appear here as they publish.
{% endunless %}

## How the site is written

Articles favour:

- Repeatable implementation patterns
- Operational checklists
- Clear trade-offs
- Safe defaults
- Public-safe technical language
- Links between related topics

The goal is to make technical decisions easier to repeat, explain, and operate.
