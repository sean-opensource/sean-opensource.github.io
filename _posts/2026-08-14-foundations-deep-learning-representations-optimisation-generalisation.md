---
layout: post
title: "Foundations of Deep Learning: Representations, Optimisation, and Generalisation"
date: 2026-08-14 09:00 +1000
categories: [Deep Learning]
tags: [deep-learning, representation-learning, optimisation, generalisation, machine-learning, neural-networks]
description: A practical foundation article explaining representation learning, optimisation, capacity, overfitting, and generalisation in deep learning.
---

This article is part of the [Deep Learning](/deep-learning/) content hub.

Deep learning is often introduced through architectures: multilayer perceptrons, convolutional networks, recurrent networks, transformers, and generative models. Those architectures matter, but they sit on top of a smaller set of core ideas.

The foundations are:

- Representation
- Optimisation
- Generalisation
- Capacity
- Data distribution
- Evaluation

If these ideas are weak, the model may still run, but the results will be hard to trust.

## Deep learning as representation learning

A useful way to think about deep learning is that the model learns representations of data.

Traditional machine learning often depends heavily on hand-designed features. The engineer decides which measurements to extract, then a learning algorithm maps those features to predictions.

Deep learning changes that pattern. Instead of relying only on manually defined features, the model learns intermediate representations from data.

A deep model does not simply map input to output in one step. It composes many transformations. Each layer converts one representation into another.

For an image model, early layers may respond to simple local patterns. Later layers may represent more complex structures. For a text model, early representations may encode tokens and local relationships, while deeper representations capture richer semantic or contextual information.

The engineering consequence is important: debugging a deep model is partly about debugging what it has learned to represent.

## Optimisation: learning as search

Training a neural network is an optimisation process.

The model has parameters. The loss function measures how badly the model is performing. The optimiser updates the parameters to reduce the loss.

The simple loop is:

```text
predict -> measure loss -> compute gradients -> update parameters -> repeat
```

This loop is easy to describe, but difficult to make reliable at scale.

Deep learning optimisation can be hard because:

- The parameter space is large.
- The loss surface can be poorly conditioned.
- Gradients can vanish or explode.
- Learning rates can be too high or too low.
- Initialisation can make training unstable.
- Batch size can affect the optimisation path.
- The model can optimise the training set without generalising.

Training a model is not just pressing run. It is managing a controlled optimisation experiment.

## Generalisation: the real goal

A model that performs well on training data is not necessarily useful.

The goal is generalisation: performance on data not used to fit the model.

This requires careful separation between training data, validation data, and test data.

Training data is used to update parameters. Validation data is used for model selection and tuning. Test data should be used sparingly to estimate final performance.

## Capacity, overfitting, and underfitting

Capacity describes how flexible a model is.

A low-capacity model may be too simple to represent the target pattern. This causes underfitting.

A high-capacity model may fit training details that do not generalise. This causes overfitting.

The practical signs are:

```text
Underfitting:
- Training error is high
- Validation error is high
- Model is too simple or poorly optimised

Overfitting:
- Training error is low
- Validation error is high
- Model is too flexible, data is insufficient, or regularisation is weak
```

The correction depends on the pattern.

For underfitting, consider model capacity, optimisation, features, training duration, and architecture.

For overfitting, consider more data, data augmentation, regularisation, early stopping, smaller models, and better validation design.

## Practical workflow

Use this workflow for early experiments:

1. Start with a simple baseline.
2. Train a small model.
3. Fit a tiny clean batch deliberately.
4. Confirm the training loop works.
5. Add validation.
6. Increase capacity gradually.
7. Add regularisation when needed.
8. Track experiments.
9. Inspect errors.
10. Only then scale the model or data.

## Minimum foundation checklist

Before treating a deep learning result as credible, confirm:

- The data split is correct.
- The baseline model is known.
- The metric matches the task.
- The training curve is reviewed.
- The validation curve is reviewed.
- The loss is appropriate.
- The model is compared against a simpler alternative.
- Failure cases are inspected.
- Overfitting or underfitting is understood.
- The experiment is reproducible enough to trust.

## Final recommendation

Deep learning foundations are not optional theory. They are the tools engineers use to debug models.

If a model fails, the cause usually sits somewhere in representation, optimisation, generalisation, data, or evaluation. Understanding those foundations makes the difference between running experiments and learning from them.

> Last reviewed: June 2026. This article is based on the foundational structure of *Deep Learning* by Goodfellow, Bengio, and Courville, adapted into original engineering study notes.
