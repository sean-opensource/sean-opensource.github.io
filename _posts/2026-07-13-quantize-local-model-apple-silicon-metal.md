---
layout: post
title: Quantize a Local Model on Apple Silicon with Transformers Metal
date: 2026-07-13 09:00 +1000
categories: [Python, AI]
tags: [python, local-ai, hugging-face, apple-silicon, quantization]
description: Reduce local model memory use on Apple Silicon with Transformers MetalConfig and four-bit weight quantization.
---

Quantization stores model weights at a lower precision to reduce memory use.
Transformers supports Metal quantization for Apple Silicon Macs through
`MetalConfig`.

This is an advanced follow-up to running a small
[text-generation pipeline](/posts/local-text-generation-apple-silicon/).

## Install the Required Packages

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install transformers torch kernels
```

## Quantize During Model Loading

```python
from transformers import AutoModelForCausalLM, AutoTokenizer, MetalConfig

model_id = "meta-llama/Llama-3.2-1B"
quantization_config = MetalConfig(bits=4, group_size=64)

model = AutoModelForCausalLM.from_pretrained(
    model_id,
    device_map="mps",
    quantization_config=quantization_config,
)

tokenizer = AutoTokenizer.from_pretrained(model_id)
inputs = tokenizer("Apple Silicon is useful for", return_tensors="pt").to("mps")
output = model.generate(**inputs, max_new_tokens=50)

print(tokenizer.decode(output[0], skip_special_tokens=True))
```

Some model repositories require you to accept a license or authenticate before
downloading weights. Choose a model that you are permitted to use.

## Understand the Settings

| Setting | Purpose |
| --- | --- |
| `bits=4` | Stores eligible weights at four-bit precision |
| `group_size=64` | Sets the number of elements in each quantization group |
| `device_map="mps"` | Runs the model on the Apple Silicon GPU |

Transformers currently documents Metal support for `2`, `4`, and `8` bit
weights. Start with four-bit quantization and compare output quality against a
non-quantized baseline.

## Exclude a Layer When Needed

```python
quantization_config = MetalConfig(
    bits=4,
    group_size=64,
    modules_to_not_convert=["lm_head"],
)
```

Only add exclusions when a model requires them.

## References

- [Transformers Metal quantization](https://huggingface.co/docs/transformers/quantization/metal)
- [MetalConfig API](https://huggingface.co/docs/transformers/en/main_classes/quantization)
- [Quantization overview](https://huggingface.co/docs/transformers/main/quantization)
