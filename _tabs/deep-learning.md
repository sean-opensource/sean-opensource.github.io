---
title: Deep Learning
icon: fas fa-project-diagram
order: 6
---

# Deep Learning

This hub collects Chilepluto study notes on deep learning concepts, architectures, optimisation, regularisation, embeddings, sequence models, and practical model engineering.

The first cluster is based on the structure of *Deep Learning* by Ian Goodfellow, Yoshua Bengio, and Aaron Courville, adapted into original engineering notes. The goal is to help readers understand the concepts behind deep learning and connect them to implementation decisions.

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

## Scheduled reading path

The initial Deep Learning cluster is scheduled as:

1. Deep Learning Study Path for Engineers — 7 Aug 2026
2. Foundations of Deep Learning: Representations, Optimisation, and Generalisation — 14 Aug 2026
3. Core Neural Network Architectures: MLPs, CNNs, RNNs, and Residual Networks — 21 Aug 2026
4. Training Deep Networks: Optimisation, Regularisation, and Evaluation — 28 Aug 2026
5. Embeddings and Sequence Models in Deep Learning — 4 Sep 2026

## Expansion strategy

The next wave should extend the hub into focused articles:

- Linear algebra for neural networks
- Probability and information theory for machine learning
- Backpropagation from first principles
- Regularisation techniques in practice
- Convolutional networks for image workflows
- Recurrent networks and long-term dependencies
- Autoencoders and representation learning
- Practical model debugging
- Hyperparameter tuning and experiment tracking
- Generative models and modern local AI connections

## How to use this hub

Start with the study path article, then move through the concept notes as they publish.

The posts are written as engineering notes, not academic lecture notes. They focus on mental models, implementation consequences, practical checks, and how to connect theory to real projects.
