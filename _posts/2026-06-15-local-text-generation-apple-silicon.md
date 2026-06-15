---
layout: post
title: Run a Local Text-Generation Pipeline on Apple Silicon
date: 2026-06-15 09:00 +1000
categories: [Python, AI]
tags: [python, local-ai, hugging-face, apple-silicon, mps]
description: Run a small Hugging Face text-generation pipeline on an Apple Silicon Mac with MPS acceleration and CPU fallback.
---

Apple Silicon Macs can run Hugging Face text-generation pipelines through
PyTorch's Metal Performance Shaders (MPS) backend. Start with a small model so
you can verify the workflow before downloading larger weights.

## Create an Environment

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install torch transformers
```

## Check MPS Support

```python
import torch

print("MPS built:", torch.backends.mps.is_built())
print("MPS available:", torch.backends.mps.is_available())
```

If `is_available()` is `False`, continue with the CPU. You still have a useful
local test environment.

## Run Text Generation

Create `generate.py`:

```python
import torch
from transformers import pipeline

device = "mps" if torch.backends.mps.is_available() else "cpu"

generator = pipeline(
    task="text-generation",
    model="openai-community/gpt2",
    device=device,
)

result = generator(
    "A useful local AI workflow starts with",
    max_new_tokens=60,
    do_sample=True,
    temperature=0.8,
)

print("Device:", device)
print(result[0]["generated_text"])
```

Run it with `python generate.py`.

GPT-2 is a small demonstration model, not a modern assistant model. Its role is
to prove that Python, Transformers, the model download, and MPS selection work.

## Use CPU Fallback

MPS does not support every PyTorch operation. If a model fails on an
unsupported operation, retry with CPU fallback enabled:

```bash
PYTORCH_ENABLE_MPS_FALLBACK=1 python generate.py
```

Apple Silicon uses unified memory. Increase model size gradually and leave
memory available for macOS and the Python process.

## Next Steps

Continue with the upcoming hardware guide before downloading a larger model.

## References

- [Transformers pipelines](https://huggingface.co/docs/transformers/main/en/pipeline_tutorial)
- [Transformers on Apple Silicon](https://huggingface.co/docs/transformers/perf_train_special)
- [Pipeline API](https://huggingface.co/docs/transformers/en/main_classes/pipelines)
