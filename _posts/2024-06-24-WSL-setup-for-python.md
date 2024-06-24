---
layout: post
title: Windows Subsystem for Linux (WSL) setup
date: 2024-06-24 00:00 +1000
categories: [Python, AI ]
tags: [post]
---

# Using Python in Windows WSL: A Detailed Guide

With Windows Subsystem for Linux (WSL), you can run a Linux distribution alongside your Windows installation, allowing you to enjoy the best of both worlds. This guide will walk you through the process of setting up WSL, installing Python, and running Python scripts in a WSL environment.

## Prerequisites

Before starting, ensure you have:

- A Windows 10 (version 2004 and higher) or Windows 11 system.
- Basic knowledge of command-line interfaces.

## Step 1: Installing WSL

First, you need to install WSL on your Windows machine. Follow these steps:

1. **Open PowerShell as Administrator:**

    Press `Win + X` and select `Windows PowerShell (Admin)`.

2. **Enable WSL:**

    ```bash
    wsl --install
    ```

    This command will enable the necessary features and install a default Linux distribution (usually Ubuntu). Restart your computer if prompted.

3. **Verify Installation:**

    After restarting, open a new PowerShell window and check the WSL version:

    ```bash
    wsl -l -v
    ```

    You should see your installed Linux distribution listed.

## Step 2: Setting Up a Linux Distribution

If you installed the default Ubuntu distribution, you can proceed with setting it up. If you want to install a different distribution, follow these steps:

1. **List Available Distributions:**

    ```bash
    wsl --list --online
    ```

2. **Install a Distribution:**

    ```bash
    wsl --install -d <DistributionName>
    ```

    Replace `<DistributionName>` with the name of the distribution you want to install.

3. **Launch and Set Up the Distribution:**

    Open your installed distribution from the Start menu or by typing `wsl` in PowerShell. Follow the on-screen instructions to set up your username and password.

## Step 3: Installing Python

Now that you have your Linux distribution set up, you can install Python.

1. **Update Package List:**

    Open your WSL terminal and run:

    ```bash
    sudo apt update
    ```

2. **Install Python:**

    ```bash
    sudo apt install python3 python3-pip
    ```

3. **Verify Installation:**

    Check the installed Python version:

    ```bash
    python3 --version
    ```

## Step 4: Running a Python Script

Let's create and run a simple Python script to ensure everything is working correctly.

1. **Create a Python Script:**

    In your WSL terminal, create a new file:

    ```bash
    nano hello.py
    ```

    Add the following content:

    ```python
    print("Hello, WSL!")
    ```

    Save and exit the editor (`Ctrl + X`, then `Y`, then `Enter`).

2. **Run the Script:**

    Execute the script using Python:

    ```bash
    python3 hello.py
    ```

    You should see the output `Hello, WSL!`.

## Conclusion

By following this guide, you've set up WSL on your Windows machine, installed a Linux distribution, and successfully installed and run Python. This setup allows you to leverage the power of Linux development tools while working within your Windows environment. Explore further by installing additional Python packages, setting up virtual environments, and developing your projects in this flexible setup.
