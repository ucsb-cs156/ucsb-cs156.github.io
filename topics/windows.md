---
parent: Topics
layout: default
title: Windows
description:  "Setting up an environment to do course work on your own Windows machine (not ssh'ing into CSIL)"
---

If you want to work on your own machine (instead of using you machine to ssh into CSIL), there are two options:

* "Native Windows" - directly in the Windows OS and filesystem 
* On the Windows Subsystem for Linux (WSL) - a tool that basically creates a separate Linux environment alongside your Windows environment. 
  It's kind of like a more lightweight VM, with access to local storage.
  
This page is our best effort at explaining how to set up an environment for CMPSC 156 for *native windows.*

For information on WSL, please see the [Windows: WSL page](/topics/windows_wsl/). 

Note that the reference platform for the course remains "CSIL"; we cannot commit to being "tech support" for every conceivable platform.  On your own machine, you *are* your own tech support.  But we'll help as best we can, given the time constraints we are under.
    
# Install git for Windows

* Download link: <https://git-scm.com/download/win>

(Note: I recommend git for windows, not "github for windows".  "git for windows" provides the "Git Bash Shell" as well as the command line git tools that we use in CMPSC 156.)

# Install the JDK for Java 17

We strongly encourage you not to install a later version than Java 17.  Java 17 is a "long-term support" version of Java, while versions such as 18, 19, etc. are considered more experimental.

There are two options for Java 11 for Windows:
* The Open Source Version from <http://jdk.java.net/17/>
* The official Oracle version from <https://www.oracle.com/java/technologies/downloads/#jdk17-windows>

# Install Apache Maven

1. Download from here: <https://maven.apache.org/download.cgi>
2. Follow installation instructions here: <https://maven.apache.org/install.html>

To test whether it worked, open a command line and type:

```
mvn --version
```

# Install Heroku CLI

See instructions here: <https://devcenter.heroku.com/articles/heroku-cli>

# Install Node/npm

[Visit this page](/topics/node_windows/) for instructions on how to install Node and npm on Windows and/or WSL.

See the "Software" link for your version of the class for advice on versions of Node, e.g.
* W22: <https://ucsb-cs156.github.io/w22/info/software/>
