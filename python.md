---
layout: page
title: Python
permalink: /python/
---

# Python

Python articles on Chilepluto focus on practical examples for automation, data, machine learning, testing, and repeatable developer workflows.

## Published Python articles

{% assign has_python_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'Python' or post.tags contains 'python' %}
    {% assign has_python_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_python_posts %}
Python articles are scheduled and will appear here as they publish.
{% endunless %}

## Upcoming focus areas

- Python development in WSL
- Testing and formatting
- Machine learning model evaluation
- Reusable scikit-learn pipelines
- Local AI workflows

## Related topics

- [WSL](/wsl/)
- [Local AI](/local-ai/)
- [PowerShell](/powershell/)
