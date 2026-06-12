---
layout: post
title: Foundations of Deep Learning: Representations, Optimisation, and Generalisation
date: 2026-08-14 09:00 +1000
categories: [Deep Learning]
tags: [deep-learning, machine-learning, representations, optimisation, generalisation]
description: A practical explanation of the core foundations behind deep learning systems.
---

This article is part of the [Deep Learning](/deep-learning/) hub.

The foundations of deep learning are not only about neural network layers. They are about how data, representations, optimisation, and evaluation interact.

A useful mental model is:

```text
Data -> Representation -> Model -> Loss -> Optimisation -> Evaluation
```

If any part of that chain is weak, the model can fail even if the architecture is modern.

## Data comes first

Deep learning models learn from examples. The quality, coverage, and structure of the data matter more than the complexity of the model.

Common data problems include:

- Missing or inconsistent labels
- Class imbalance
- Duplicate records
- Data leakage
- Distribution shift
- Incorrect preprocessing
- Train and test mismatch

A larger model will not reliably fix poor data. It may simply memorise the problems more effectively.

## Representations

A representation is the form in which information is made available to the model.

Traditional machine learning often depends on manual feature engineering. Deep learning shifts more of that feature learning into the model itself.

In deep networks, early layers often learn simple patterns while later layers combine them into more abstract features.

Examples:

- Pixels become edges, textures, parts, and objects.
- Characters or tokens become word and sentence representations.
- Audio samples become spectral and temporal patterns.

The value of a deep model is often its ability to learn useful intermediate representations.

## Loss functions

A loss function defines what the model is trying to minimise.

Examples:

- Mean squared error for some regression tasks
- Cross-entropy for classification
- Contrastive loss for representation learning
- Sequence loss for language or translation tasks

The loss function should match the task. If the loss does not reflect the desired behaviour, optimisation will push the model in the wrong direction.

## Optimisation

Optimisation is the process of adjusting model parameters to reduce loss.

Important concepts:

- Gradients
- Learning rate
- Mini-batch training
- Momentum
- Adaptive learning rates
- Training stability

The optimiser does not understand the business goal. It only follows the signal provided by the loss function and the data.

## Generalisation

Generalisation is the ability to perform well on examples not seen during training.

A model can fail to generalise because:

- It memorised the training data.
- The training data did not represent real conditions.
- The validation split was contaminated.
- The model is too complex for the dataset.
- The evaluation metric is poorly chosen.

Generalisation should be measured, not assumed.

## Bias and variance

Bias and variance are useful diagnostic concepts.

High bias means the model is too simple or poorly specified. It underfits.

High variance means the model is too sensitive to the training data. It overfits.

Deep learning workflows often manage this trade-off through architecture choice, data volume, regularisation, and evaluation discipline.

## Practical checks

When reviewing a deep learning experiment, ask:

- Is the dataset representative?
- Are preprocessing steps identical between training and evaluation?
- Is the loss function aligned with the task?
- Is the model overfitting?
- Is the baseline strong enough?
- Are failure cases inspected manually?
- Can another person reproduce the result?

## Engineering takeaway

Deep learning is not magic. It is a system of numerical optimisation over learned representations.

The most reliable projects treat data, loss design, model architecture, validation, and reproducibility as one engineering system.

> Last reviewed: June 2026. Validate framework behaviour, library versions, and evaluation methods against current documentation before production use.
