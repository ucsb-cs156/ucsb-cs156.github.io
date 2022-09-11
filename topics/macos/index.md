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

To see whether you already have the JDK installed, do this in a terminal window:

```
169-231-88-206:~ pconrad$ javac -version
javac 1.8.0_31
169-231-88-206:~ pconrad$ 
```


If you see some version of Java 17.something... then you are good to go.

If not, download and install Java 17 using either the
* Official Oracle distribution (see below)
* The OpenJDK 11 distribution (see below)

There are three Slack channels that can help:
* Use the `#help-macos` channel to ask questions if you run into problems.
* Use the `#articles-macos` channel to offer tips, tricks, or links to resources that may help other students.
* Use the `#typos` channel if there are things in these instructions that are incorrect and should be updated.

# Installing Java 17 from Oracle on Mac

Oracle has a link for installing Java JDK 11 on Mac on this page: <https://www.oracle.com/java/technologies/javase-jdk11-downloads.html>

# Installing OpenJDK 17 on Mac

This worked for me.  Note that it requires [brew](https://ucsb-cs56.github.io/topics/macos_homewbrew/), a package manager for MacOS.
* <https://installvirtual.com/install-openjdk-11-mac-using-brew/>

To install Java with homebrew, use:
   
   ```
   brew update
   brew install openjdk@17
   ```
   
   Then you must do this step, which is documneted in the output that shows up when you run the `brew install openjdk@17` command:
   
   ```
   sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
   ```

   To check if you now have Java 17, open a new Terminal window and do:

   ```
   java -version
   ```

   If it worked, you should see something like this:

   ```
   # java -version
   openjdk 17.0.1 2021-10-19
   OpenJDK Runtime Environment Homebrew (build 17.0.1+1)
   OpenJDK 64-Bit Server VM Homebrew (build 17.0.1+1, mixed mode, sharing)
   ```


# Install Maven

After installing Java 11, do this to install maven:

```
brew install maven
```

Or if you already have Maven installed:

```
brew upgrade maven
```

And then do:

```
mvn --version
```

To make sure that Maven is using Java 17 and not still using Java 8 or earlier.

# What if Maven reports it is using the wrong version of Java?

Sometimes, when installing a newer version of Maven with brew, it may bring along
a later version of Java as a dependency.

However, my hope is that if we configure our `pom.xml` files to use Java 17, perhaps this won't be an issue.


# Install Heroku CLI

Follow instructions here: <https://devcenter.heroku.com/articles/heroku-cli>


# Install Node/npm

To install node and npm on Mac, use:

```
brew install node
```

