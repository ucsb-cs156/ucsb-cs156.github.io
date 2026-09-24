---
parent: Topics
layout: default
title: Windows
description:  "Setting up an environment to do course work on your own Windows machine (not ssh'ing into CSIL)"
has_children: true
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

# Install the JDK for Java {{site.java_version}}

The projects in this class use Java {{site.java_version}} (a "long-term support" version of Java), and we strongly encourage you not to install a later or earlier version.

For native Windows, the recommended distribution is Eclipse Temurin ({{site.jdk_distribution}}), which you can download from <https://adoptium.net/temurin/releases/?version=25&os=windows>.

(On Windows, we recommend using [WSL](/topics/windows/windows_wsl.html) instead, where you can install Java with SDKMAN using `sdk install java {{site.jdk_distribution}}`.)

# Install Apache Maven

The projects in this class need Maven 3.9.14 or newer.

1. Download from here: <https://maven.apache.org/download.cgi>
2. Follow installation instructions here: <https://maven.apache.org/install.html>

To test whether it worked, open a command line and type:

```
mvn --version
```

Check that the Maven version is 3.9.14 or newer, and that the `Java version:` line reports Java {{site.java_version}}.

# Install Heroku CLI

See instructions here: <https://devcenter.heroku.com/articles/heroku-cli>

# Install Node/npm

[Visit this page](/topics/node_windows/) for instructions on how to install Node and npm on Windows and/or WSL.

See the "Software" link for your version of the class for advice on versions of Node, e.g.
* W22: <https://ucsb-cs156.github.io/w22/info/software/>
