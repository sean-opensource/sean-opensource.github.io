---
layout: post
title: "Core Neural Network Architectures: MLPs, CNNs, RNNs, and Residual Networks"
date: 2026-08-21 09:00 +1000
categories: [Deep Learning]
tags: [deep-learning, neural-networks, cnn, rnn, residual-networks, architectures]
description: A practical guide to core neural network architecture families and when to use them.
---

This article is part of the [Deep Learning](/deep-learning/) hub.

Neural network architectures encode assumptions about the data. Choosing an architecture is not just a matter of using the newest model. It is a design decision about structure, scale, training behaviour, and the type of pattern the model should learn.

## Multilayer perceptrons

A multilayer perceptron is a feedforward network made of stacked dense layers.

It is useful when data can be represented as fixed-size vectors.

Examples:

- Tabular features
- Embeddings
- Engineered numerical inputs
- Simple classification or regression tasks

Strengths:

- Conceptually simple
- Easy to implement
- Useful baseline

Limitations:

- Does not naturally encode spatial structure
- Can become parameter-heavy
- Often requires careful feature preparation

## Convolutional neural networks

Convolutional networks are designed for spatial data.

They use filters that slide across inputs, allowing the model to learn local patterns and reuse weights.

Common use cases:

- Image classification
- Object detection
- Segmentation
- Some audio and signal tasks

Key ideas:

- Local receptive fields
- Weight sharing
- Feature maps
- Pooling
- Hierarchical features

CNNs work well when nearby values have meaningful relationships.

## Recurrent neural networks

Recurrent networks process sequences by maintaining state across time steps.

They were historically important for:

- Text sequences
- Speech
- Time series
- Event streams

Common variants include:

- Vanilla RNNs
- Long short-term memory networks
- Gated recurrent units

The main challenge is learning long-range dependencies. Gradients can vanish or explode across long sequences.

## Residual networks

Residual networks introduced skip connections that allow layers to learn residual functions.

Instead of forcing every layer to learn a full transformation, the network can learn a correction added to an earlier representation.

Why this matters:

- Deeper networks become easier to optimise.
- Gradient flow improves.
- Very deep computer vision models become more practical.

Residual connections are now common across many model families, not just image models.

## Encoder-decoder models

Encoder-decoder models map an input sequence or structure to an output sequence or structure.

Examples:

- Translation
- Summarisation
- Captioning
- Sequence prediction

The encoder builds a representation of the input. The decoder generates the output.

Attention mechanisms improved these models by allowing the decoder to focus on relevant parts of the input representation.

## Choosing an architecture

Start with the data shape and task.

Ask:

- Is the input a fixed vector?
- Is there spatial structure?
- Is there sequence order?
- Are long-range dependencies important?
- Is interpretability required?
- What baseline should be beaten?
- What hardware constraints exist?

A simple baseline is often more valuable than an unnecessarily complex architecture.

## Practical comparison

```text
MLP: fixed-size vectors
CNN: spatial structure
RNN: sequence order
Residual network: deeper optimisation
Encoder-decoder: structured input to structured output
```

## Engineering takeaway

Architecture choice should follow the problem, not the hype cycle.

The best model is usually the simplest architecture that achieves the required performance with acceptable cost, reliability, and maintainability.

> Last reviewed: June 2026. Model families and best practices evolve quickly; validate current implementation choices against current framework documentation and research practice.
