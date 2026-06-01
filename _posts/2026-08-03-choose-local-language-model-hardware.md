---
layout: post
title: Choose a Local Language Model for Your Hardware
date: 2026-08-03 09:00 +1000
categories: [Python, AI]
tags: [local-ai, llm, hardware, quantization]
description: Choose a practical first local language model by checking memory, precision, context length, and runtime support.
---

The best first local language model is not the largest model that might load.
It is a model that fits comfortably, responds reliably, and matches the
runtime you plan to use.

## Start with the Task

Decide what you need:

- A tiny model to verify a Python workflow
- An instruction model for chat-style prompts
- A code model for programming experiments
- A summarization or classification model for a narrow task

A small demonstration model such as GPT-2 is useful for validating the
pipeline. It is not a modern assistant.

## Check Memory Before Downloading

Model weights, context length, runtime overhead, and generated-token caches all
consume memory. Lower-precision weights reduce the model footprint:

| Precision | Relative weight size |
| --- | --- |
| `fp32` | Largest baseline |
| `fp16` or `bf16` | Roughly half of `fp32` |
| `int8` | Smaller again |
| `int4` | Often a practical local inference option |

These are planning estimates, not guarantees. Runtime overhead and model
architecture still matter.

## Match the Runtime to the Hardware

| Hardware | Practical starting point |
| --- | --- |
| CPU-only machine | Small model and short context |
| NVIDIA GPU | CUDA-supported runtime and a model sized for GPU memory |
| Apple Silicon Mac | MPS-supported runtime and a model sized for unified memory |

On Apple Silicon, leave headroom for macOS and other applications.

## Increase Size Gradually

1. Run a small known model.
2. Record memory use and response time.
3. Try the next size only when the baseline is stable.
4. Compare a quantized variant when memory pressure becomes the limit.
5. Recheck quality with prompts that represent your actual use case.

Long prompts also increase memory use and latency. Begin with short prompts
while validating a new model.

## Next Steps

- [Run a Local Text-Generation Pipeline on Apple Silicon](/posts/local-text-generation-apple-silicon/)
- [Quantize a Local Model on Apple Silicon with Transformers Metal](/posts/quantize-local-model-apple-silicon-metal/)

## References

- [Transformers pipelines](https://huggingface.co/docs/transformers/main/en/pipeline_tutorial)
- [Transformers on Apple Silicon](https://huggingface.co/docs/transformers/perf_train_special)
- [Quantization overview](https://huggingface.co/docs/transformers/main/quantization)
