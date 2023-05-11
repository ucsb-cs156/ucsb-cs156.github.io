---
parent: Node
grand_parent: Topics
layout: default
title: "Node: nvm"
description:  "Node Version Manager"
indent: true
category_prefix: "Node: "
---

The software package `nvm` is the Node Version Manager.  It is helpful when you may be working on various code bases, each of which may require
a different version of node to work properly.

It allows you to have various versions of node loaded on your system, and switch among them seamlessly.

# Documentation

* The [README](https://github.com/nvm-sh/nvm/blob/master/README.md) for the [GitHub repo for nvm](https://github.com/nvm-sh/nvm) is a good place to start

# Installing

* For MacOS, you can use `brew install nvm`, or refer to the nvm website where you will find [installation instructions] (https://github.com/nvm-sh/nvm#install--update-script) and a section on [troubleshooting for MacOS](https://github.com/nvm-sh/nvm#troubleshooting-on-macos)
* For Linux, refer to the nvm website where you will find [installation instructions] (https://github.com/nvm-sh/nvm#install--update-script) and a section on [troubleshooting for Linux]([https://github.com/nvm-sh/nvm#troubleshooting-on-macos](https://github.com/nvm-sh/nvm#troubleshooting-on-macos)
* Since there is no section on troubleshooting for Windows, we suggest using Windows Subsystem for Linux (WSL) and then
  follow the instructions for Linux above.
* For folks working in Github Codespaces, you do not need `nvm` since you can specify a specific version of node
  in the `Dockerfile` that you use to set up the codespace.
