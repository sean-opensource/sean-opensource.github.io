---
layout: post
title: Set Up VS Code Dev Containers on WSL 2
date: 2026-07-06 09:00 +1000
categories: [Python, WSL]
tags: [windows, wsl, vscode, docker, dev-containers]
description: Use Docker Desktop, WSL 2, and VS Code Dev Containers with project files stored in the Linux filesystem.
---

A VS Code Dev Container gives a project a repeatable development environment.
On Windows, use WSL 2 and keep the repository in the Linux filesystem for
better Docker performance.

## Prerequisites

Install WSL 2, Docker Desktop with its WSL 2 backend enabled, Visual Studio
Code, and the VS Code **Dev Containers** extension.

In Docker Desktop, check **Settings > Resources > WSL integration** and enable
integration for the distribution that holds your project.

## Store the Repository Inside WSL

```bash
mkdir -p ~/projects
cd ~/projects
git clone https://github.com/your-org/your-repo.git
cd your-repo
code .
```

Prefer `/home/yourname/projects/` over a path under `C:\Users`. Docker accesses
files in the WSL filesystem through native Linux I/O, which is especially
important for builds and file watchers.

## Add a Python Dev Container

Create `.devcontainer/devcontainer.json`:

```json
{
  "name": "Python",
  "image": "mcr.microsoft.com/devcontainers/python:1-3.12-bookworm",
  "postCreateCommand": "python -m pip install --upgrade pip",
  "customizations": {
    "vscode": {
      "extensions": ["ms-python.python"]
    }
  }
}
```

In VS Code, press `F1` and run **Dev Containers: Reopen in Container**. Inside
the container terminal, run `python --version` and `pwd`.

## Troubleshooting

- If Docker Desktop does not expose your distribution, enable WSL integration.
- If file watching is slow, move the repository from `C:\` into WSL.
- If VS Code cannot connect, confirm Docker Desktop is running.

## References

- [Set up Dev Containers on Windows](https://learn.microsoft.com/en-us/windows/dev-environment/docker/dev-containers)
- [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Dev Container specification](https://containers.dev/implementors/json_reference/)
