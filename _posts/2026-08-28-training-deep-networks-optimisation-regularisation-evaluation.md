---
layout: post
title: "Training Deep Networks: Optimisation, Regularisation, and Evaluation"
date: 2026-08-28 09:00 +1000
categories: [Deep Learning]
tags: [deep-learning, optimisation, regularisation, evaluation, overfitting, neural-networks]
description: A practical guide to training deep networks by managing optimisation, regularisation, validation, and model evaluation.
---

This article is part of the [Deep Learning](/deep-learning/) content hub.

Training a deep network is an engineering process. It is not only a modelling problem.

You need a dataset, a model, a loss function, an optimiser, a validation strategy, a regularisation plan, and a way to inspect failure.

## The training loop

A simplified training loop looks like this:

```text
load batch
run forward pass
compute loss
run backward pass
update parameters
record metrics
repeat
```

Every part of this loop can fail.

The data may be wrong. Labels may be noisy. Shapes may be inconsistent. The loss may not match the task. The optimiser may be unstable. Metrics may hide important failure modes.

## Optimisation checks

Before improving architecture, confirm that optimisation is working.

Useful checks:

- Can the model fit a tiny clean batch?
- Does training loss decrease?
- Are gradients finite?
- Are learning rates reasonable?
- Does changing the learning rate change behaviour?
- Are parameters updating?
- Is the loss scale sensible?

If a model cannot fit a small clean batch, scaling the model or dataset is unlikely to help.

## Learning rate

The learning rate is one of the most important training settings.

Too high and training may diverge. Too low and training may be painfully slow or appear stuck.

Practical symptoms:

```text
Learning rate too high:
- Loss jumps or becomes unstable
- Metrics oscillate heavily
- Gradients may become invalid

Learning rate too low:
- Loss decreases very slowly
- Model appears stuck
- Training takes too long
```

Use learning rate schedules or adaptive optimisers when appropriate, but still inspect the curves.

## Initialisation

Parameter initialisation affects early training behaviour.

Poor initialisation can cause activations or gradients to shrink or explode as signals move through the network.

Modern frameworks provide sensible defaults, but engineers should still understand why initialisation matters, especially when building custom layers.

## Regularisation

Regularisation helps reduce overfitting and improve generalisation.

Common techniques include:

- Weight decay
- Dropout
- Early stopping
- Data augmentation
- Noise injection
- Parameter sharing
- Model ensembling

Regularisation should be selected based on the failure mode.

If the model is underfitting, adding more regularisation may make things worse.

## Early stopping

Early stopping monitors validation performance and stops training when improvement stalls or reverses.

It is simple and powerful because it treats training duration as a regularisation decision.

Use it with care:

- Monitor a validation metric that matches the task.
- Keep patience high enough to avoid stopping on noise.
- Save the best checkpoint, not just the final checkpoint.
- Do not tune repeatedly against the test set.

## Data augmentation

Data augmentation creates modified versions of training examples.

It is especially useful when transformations preserve the target label.

Examples:

- Cropping or flipping images
- Adding small amounts of noise
- Time shifting signals
- Masking parts of inputs

Augmentation should match the real variability expected in deployment.

Bad augmentation can teach the model invariances that are not valid.

## Evaluation

Evaluation is not just calculating one number.

A useful evaluation process includes:

- Baseline comparison
- Validation metrics
- Test metrics
- Error analysis
- Slice analysis
- Confusion matrix where appropriate
- Review of representative failures
- Review of edge cases

A model can perform well overall and still fail badly for an important subset of cases.

## Experiment discipline

Track experiments consistently.

At minimum, record:

- Dataset version
- Train/validation/test split
- Model configuration
- Optimiser
- Learning rate
- Batch size
- Regularisation settings
- Random seed where practical
- Metrics
- Notes on failure cases

You cannot improve what you cannot compare.

## Troubleshooting patterns

### Training loss does not move

Check data loading, labels, loss function, learning rate, frozen parameters, and gradient flow.

### Training loss decreases but validation does not

Likely overfitting, data mismatch, leakage in assumptions, or validation split problems.

### Both training and validation are poor

Likely underfitting, poor features, weak architecture, insufficient training, or optimisation issues.

### Validation is unstable

Check validation set size, metric sensitivity, batch construction, and randomness.

## Final recommendation

Training deep networks is a controlled experiment.

Do not treat the model as a black box. Review the data, the curves, the gradients, the metrics, and the failures.

The best training process is one that tells you why the model behaved the way it did.

> Last reviewed: June 2026. This article is based on the optimisation, regularisation, and practical methodology structure in *Deep Learning* by Goodfellow, Bengio, and Courville, adapted into original engineering study notes.
