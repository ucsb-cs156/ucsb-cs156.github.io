---
parent: MacOS
grand_parent: Topics
layout: default
title: "MacOS: Common Errors" 
description:  "Things that frequently go wrong on MacOS and how to fix them"
---


# "Illegal Class Exception" or other errors have to do with version mismatch

On MacOS, if you are seeing errors having to do with "Illegal Class Exception" or other errors have to do with version mismatch, here is a strategy for
solving that.

First thing to check:

```
java --version
mvn --version
```

You want them both to be the same version of Java: Java {{site.java_version}}, the version used in this course.


What you do NOT want is for `java --version` to say Java {{site.java_version}}
but then `mvn --version` says a different version, (e.g. Java 23 from Homebrew)



If that is what you see, here's an approach to fixing it.

First, in the terminal window where you are working, select the course version of Java with SDKMAN, and check again:

```
sdk use java {{site.jdk_distribution}}
java --version
mvn --version
```

If both commands now report Java {{site.java_version}}, you are done.  Try a `mvn clean` before you do anything else though.

If `mvn --version` still reports a different Java, then most likely an old `JAVA_HOME` definition (or a Java installed by `brew`) is taking precedence.
To fix that, first make sure you know which version of MacOS you are on, and what it's default shell is.


For example
* Monterey uses zsh
* Catalina uses zsh
* Some others may still use bash

Whatever your default shell, you want to identify the startup file for that shell.
For example
* for `zsh` you'd edit `.zshrc`

Look for any line in that file that sets `JAVA_HOME` to something other than SDKMAN's Java (for example, one that uses `/usr/libexec/java_home -v 17`, or a path to a Homebrew `openjdk`), and remove it or comment it out.
Also make sure that the lines that SDKMAN added to load itself (`sdkman-init.sh`) are the *last* lines in the file.  SDKMAN sets `JAVA_HOME` for the version you select with `sdk use`.

Then open a brand new terminal, and check

```
sdk use java {{site.jdk_distribution}}
echo $JAVA_HOME
java --version
mvn --version
```


If you now see that `$JAVA_HOME` is defined as the directory where Java {{site.java_version}} lives (under `~/.sdkman/candidates/java/`),
and that both java and mvn are giving us Java {{site.java_version}}, try doing what was failing in a brand new terminal window.


Try a `mvn clean` before you do anything else though.
