---
parent: Topics
layout: default
title: "Docker"
description:  "Virtualization/Container platform"
category_prefix: "Docker: "
---

# {{page.title}}

# What is Docker?

Docker is a tool for creating/running containers, which are essentially lightweight virtual machines. The main benefit of Docker is that it makes applications much more portable—instead of having to make sure the target machine has exactly the correct dependencies for deployment/local development, you can trust that any machine with Docker installed will be able to run your app.

# Installation

Docker can be installed using [Docker Desktop](https://www.docker.com/products/docker-desktop) on Windows, macOS, and Linux systems. 

# Project Structure

The files required to setup Docker (as implemented in this class), are as follows:
- `Dockerfile` - This is a standard file required by Docker. This file describes how to take a fresh Linux installation and install all of the dependencies required to run your app.
- `dev_environment` - This is a helper script written/maintained by CS156 staff that abstracts away the Docker setup commands from the user. This script builds a "container", or virtualized Linux environment, from the `Dockerfile` and runs a bash shell inside of it.
- `.devcontainer.json` - This is an alternative to the `dev_environment` script for VSCode users. This allows VSCode users to use Docker through the [Remote Development extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).

# Starting the Container 
In order to start the docker container and enter the virtualized linux environment, simply execute the `dev_environment` script by running `./dev_environment`

# Known Issues

## I opened up `./dev_environment` in multiple windows and both windows are showing the same output
Sometimes, when you `./dev_environment` multiple times quickly, there is a race condition which causes the command to open up the same bash instance. To avoid this, make sure the first `./dev_environment` has loaded before running `./dev_environment` a second time.

# Instructions for WSL

To use the docker support in our projects on the Windows Subsystem for Linux environment (instead of native powershell/cmd/etc) you need to do the following:

* Make sure you have WSL2- this is a separate environment from regular WSL.
  - If you already have regular WSL, you can have separate Linux distributions with different WSL versions.
  - WSL2 setup is here: <https://docs.microsoft.com/en-us/windows/wsl/install-win10>
* Follow the instructions here for WSL2 Docker setup: <https://docs.docker.com/docker-for-windows/wsl/>
* Make sure you have `/mnt/c/"Program Files"/Docker/Docker/resources/bin` in your `PATH` variable in their WSL2 `.bashrc`
