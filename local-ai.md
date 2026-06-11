---
layout: page
title: Local AI
permalink: /local-ai/
---

# Local AI

Local AI articles on Chilepluto focus on running, testing, and selecting models on personal hardware, with practical notes for Python workflows and Apple Silicon.

## Published Local AI articles

{% assign has_ai_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'AI' or post.tags contains 'local-ai' or post.tags contains 'llm' %}
    {% assign has_ai_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_ai_posts %}
Local AI articles are scheduled and will appear here as they publish.
{% endunless %}

## Upcoming focus areas

- Apple Silicon local inference
- Model selection by hardware
- Quantisation
- Python local AI workflows

## Related topics

- [Python](/python/)
- [WSL](/wsl/)
