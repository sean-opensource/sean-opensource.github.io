---
layout: post
title: "Core Neural Network Architectures: MLPs, CNNs, RNNs, and Residual Networks"
date: 2026-08-21 09:00 +1000
categories: [Deep Learning]
tags: [deep-learning, neural-networks, mlp, cnn, rnn, residual-networks, architecture]
description: A practical overview of core neural network architecture families and when engineers should use them.
---

This article is part of the [Deep Learning](/deep-learning/) content hub.

Deep learning architectures are not random collections of layers. Each architecture family makes assumptions about the structure of the data and the task.

A good engineer should be able to explain why a model family fits a problem before writing code.

## Architecture as inductive bias

An architecture gives the model a bias toward certain kinds of solutions.

That bias can help or hurt.

For example:

- A convolutional network is biased toward local spatial patterns.
- A recurrent network is biased toward ordered sequence processing.
- A feedforward network is a flexible general-purpose function approximator.
- A residual network is designed to make very deep networks easier to optimise.

The architecture is part of the hypothesis, not just an implementation detail.

## Multilayer perceptrons

A multilayer perceptron, or MLP, is a feedforward network made from layers of learned transformations and nonlinear activations.

MLPs are useful when:

- Inputs are fixed-size vectors.
- Tabular or engineered features are already available.
- The relationship between inputs and outputs is nonlinear.
- You need a simple baseline before using a specialised architecture.

MLPs are often underestimated. A clean MLP baseline can reveal whether a more complex architecture is actually needed.

## Convolutional networks

Convolutional networks are designed for data with spatial structure.

They are commonly used for:

- Images
- Video frames
- Spatial grids
- Some signal-processing tasks

The key ideas are:

- Local connectivity
- Parameter sharing
- Convolution filters
- Pooling or downsampling
- Hierarchical feature extraction

A convolutional model can learn low-level patterns in early layers and more abstract patterns in later layers.

Engineering checks for CNNs:

- Are input dimensions correct?
- Are channels ordered consistently?
- Is augmentation appropriate?
- Is the model too large for the dataset?
- Are validation examples visually inspected?

## Recurrent networks

Recurrent neural networks are designed for sequential data.

They process inputs across time or order and maintain state as they move through the sequence.

They are useful for:

- Time series
- Text sequences
- Speech signals
- Event streams
- Ordered sensor data

Core concepts include:

- Hidden state
- Sequence unfolding
- Bidirectional processing
- Encoder-decoder models
- Long-term dependencies
- Gated recurrent units
- LSTMs

The main engineering challenge is that long sequences are difficult to train. Gradients can become unstable and models may struggle to preserve information across many steps.

## Residual networks

Residual networks use shortcut connections so that layers learn changes relative to earlier representations.

The practical effect is that very deep networks become easier to optimise.

Residual thinking is useful beyond image models. It appears in many modern architectures because it helps information and gradients move through deep stacks of transformations.

Engineering checks for residual models:

- Do tensor shapes match across skip connections?
- Are projection layers needed when dimensions change?
- Is normalisation placed consistently?
- Is the model depth justified by the data and task?

## Choosing an architecture

Use the data structure as the first guide:

```text
Fixed-size vector data -> MLP baseline
Image or spatial data -> CNN or vision model
Ordered sequences -> RNN, attention, or transformer-style model
Very deep feature extraction -> residual patterns
Representation learning -> autoencoder or embedding model
```

Then ask:

- What is the simplest credible baseline?
- What structure exists in the input?
- What invariances should the model learn?
- How much data is available?
- What latency and memory limits exist?
- How will failure be inspected?

## Common mistakes

### Choosing architecture by trend

Popular models are not automatically appropriate for every dataset.

### Skipping simple baselines

A simple baseline is the reference point for every complex model.

### Ignoring input shape

Most architecture errors are shape errors, masking errors, or data ordering errors.

### Scaling before debugging

A larger model can hide data and training problems.

## Final recommendation

Choose architectures based on the structure of the data, the task, and the operational constraints.

Start with a baseline. Add architectural complexity only when it explains a real modelling need.

> Last reviewed: June 2026. This article is based on the architecture sequence in *Deep Learning* by Goodfellow, Bengio, and Courville, adapted into original engineering study notes.
