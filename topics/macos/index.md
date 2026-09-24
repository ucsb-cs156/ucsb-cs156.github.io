---
parent: Topics
layout: default
title: "MacOS"
description:  "Setting up an environment to do CS156 work on your own Mac (not ssh'ing into CSIL)"
category_prefix: "MacOS: "
has_children: true
---

This page is our best effort at explaining how to set up an environment for CMPSC 156 for MacOS.

For information on:
* Windows, see:  <https://ucsb-cs156.github.io/topics/windows/> 
* Windows Subsystem for Linux, please see: <https://ucsb-cs156.github.io/topics/windows_wsl/> 

Note that the reference platform for the course remains "CSIL"; we cannot commit to being "tech support" for every conceivable platform.  On your own machine, you *are* your own tech support.  But we'll help as best we can, given the time constraints we are under.
    
# Preliminaries

Installing [MacOS: Homebrew](/topics/macos_homebrew/) is your first step.  `brew` is a package manager for MacOS, and it is needed for the steps that follow.

# Install the JDK

The projects in this class use **Java {{site.java_version}}**, and the recommended distribution is `{{site.jdk_distribution}}` (Eclipse Temurin), installed with SDKMAN.
Use exactly this version of Java; do not use a later or earlier version, even another LTS version.

There are three Slack channels that can help:
* Use the `#help-macos` channel to ask questions if you run into problems.
* Use the `#articles-macos` channel to offer tips, tricks, or links to resources that may help other students.
* Use the `#typos` channel if there are things in these instructions that are incorrect and should be updated.

First, install SDKMAN, a tool for installing Java and switching between Java versions (see <https://sdkman.io/>):

```
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

Then install Java {{site.java_version}} and select it for the current terminal:

```
sdk install java {{site.jdk_distribution}}
sdk use java {{site.jdk_distribution}}
```

Type the `sdk use java {{site.jdk_distribution}}` command in each new terminal window where you work, or make it the default when `sdk install` offers to do so.

To check which version of Java you now have, do:

```
java --version
```

The first line of the output should say `openjdk {{site.java_version}}` followed by a date, and the runtime should be Temurin, e.g.:

```
openjdk {{site.java_version}} 2026-??
OpenJDK Runtime Environment Temurin-{{site.java_version}}+...
OpenJDK 64-Bit Server VM Temurin-{{site.java_version}}+...
```

# Install Maven

The projects in this class need Maven 3.9.14 or newer; Java {{site.java_version}} requires it.  Install Maven with `brew`:

```
brew install maven
```

Or if you already have Maven installed, upgrade it:

```
brew upgrade maven
```

And then do:

```
mvn --version
```

Check that the Maven version is 3.9.14 or newer, and that the `Java version:` line reports Java {{site.java_version}}
(the one you selected with `sdk use java {{site.jdk_distribution}}`), not some other version of Java.

# What if Maven reports it is using the wrong version of Java?

Sometimes, when installing a newer version of Maven with brew, it may bring along
a later version of Java as a dependency, and `mvn --version` may report that other Java instead of the one you selected with SDKMAN.

If that happens, see [MacOS: Common Errors](/topics/macos/macos_common_errors.html).

# Install Heroku CLI

Follow instructions here: <https://devcenter.heroku.com/articles/heroku-cli>


# Install Node/npm

To install node and npm on Mac, use:

```
brew install node
```

