---
title: Deep Learning
icon: fas fa-project-diagram
order: 6
---

# Deep Learning

This hub collects Chilepluto study notes on deep learning concepts, architectures, optimisation, regularisation, embeddings, sequence models, and foundational papers.

The goal is to create practical engineering notes that help readers understand the ideas behind deep learning and connect them to implementation decisions.

## Published notes

{% assign has_deep_learning_posts = false %}
{% for post in site.posts %}
  {% if post.categories contains 'Deep Learning' or post.tags contains 'deep-learning' %}
    {% assign has_deep_learning_posts = true %}
- [{{ post.title }}]({{ post.url | relative_url }}) — {{ post.date | date: "%d %b %Y" }}
  {% endif %}
{% endfor %}

{% unless has_deep_learning_posts %}
Deep learning notes are scheduled and will appear here as they publish.
{% endunless %}

## Planned reading path

The initial Deep Learning cluster is scheduled as:

1. Deep Learning Study Path for Engineers — 7 Aug 2026
2. Foundations of Deep Learning: Representations, Optimisation, and Generalisation — 14 Aug 2026
3. Core Neural Network Architectures: MLPs, CNNs, RNNs, and Residual Networks — 21 Aug 2026
4. Training Deep Networks: Optimisation, Regularisation, and Evaluation — 28 Aug 2026
5. Embeddings and Sequence Models in Deep Learning — 4 Sep 2026

## How to use this hub

Start with the study path article, then move through the concept notes as they publish.

The posts are written as engineering notes, not academic lecture notes. They focus on mental models, implementation consequences, practical checks, and how to connect theory to real projects.
