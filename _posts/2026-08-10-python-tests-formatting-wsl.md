---
layout: post
title: Run Python Tests and Formatting Inside WSL
date: 2026-08-10 09:00 +1000
categories: [Python, WSL]
tags: [python, wsl, pytest, ruff]
description: Add pytest and Ruff to a small Python project inside WSL with a reusable pyproject.toml configuration.
---

Once Python works inside WSL, add a basic test and formatting workflow. This
keeps feedback fast before a project grows.

## Create the Project

```bash
mkdir -p ~/projects/hello-python/tests
cd ~/projects/hello-python
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install pytest ruff
```

Create `calculator.py`:

```python
def add(left: int, right: int) -> int:
    return left + right
```

Create `tests/test_calculator.py`:

```python
from calculator import add


def test_add() -> None:
    assert add(2, 3) == 5
```

## Add Project Configuration

Create `pyproject.toml`:

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]

[tool.ruff]
line-length = 88

[tool.ruff.lint]
select = ["E", "F", "I"]
```

## Run the Checks

```bash
pytest
ruff check .
ruff format --check .
```

Apply formatting with `ruff format .`. Use `ruff check --fix .` only after
reviewing the lint findings because automatic fixes can change imports or code
structure.

## Add a Check Script

Create `check.sh`:

```bash
#!/usr/bin/env bash
set -eu

pytest
ruff check .
ruff format --check .
```

Run it with `bash check.sh`.

## Next Steps

For a repeatable container environment, continue with
[Set Up VS Code Dev Containers on WSL 2](/posts/vscode-dev-containers-wsl2/).

## References

- [pytest get started](https://docs.pytest.org/en/stable/getting-started.html)
- [Ruff documentation](https://docs.astral.sh/ruff/)
- [Ruff formatter](https://docs.astral.sh/ruff/formatter/)
