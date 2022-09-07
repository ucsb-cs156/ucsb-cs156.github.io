---
parent: Topics
layout: default
title: "Maven: Installing"
description:  "on Windows, Mac, Linux"
indent: true
---

# CSIL

On CSIL, Maven should be installed already.  The command is `mvn`.

# Windows

Try these links for advice:

* <https://www.mkyong.com/maven/how-to-install-maven-in-windows/>
* <https://maven.apache.org/guides/getting-started/windows-prerequisites.html>
* <https://maven.apache.org/install.html>
* <https://www.baeldung.com/install-maven-on-windows-linux-mac>

# Mac

The easiest way is probably to first install Homebrew, then use:

```
brew install maven
```

# Linux

Your mileage may vary, but on Ubuntu, this seems to work (this is what we do for the Gradescope backend, which is Ubuntu based):

```
apt-get -y install maven
```
