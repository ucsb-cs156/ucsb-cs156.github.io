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

You want them both to be the same version of Java (e.g. Java 17)


What you do NOT want is for `java --version` to say one version of Java (e.g. Java 17)
but then `mvn --version` says a different version, (e.g. Java 19)



If that is what you see, here's an approach to fixing it. 


First, make sure you know which version of MacOS you are on, and what it's default shell is.


For example
* Monterey uses zsh
* Catalina uses zsh
* Some others may still use bash

Whatever your default shell, you want to identify the startup file for that shell.
For example
* for `zsh` you'd edit `.zshrc`


And what you want to put in there is a good definition for `JAVA_HOME`.  Substitute in for `17` the correct LTS version of Java for the course:


```
export JAVA_HOME="${JAVA_HOME:-$(/usr/libexec/java_home -v 17)}"
```

If you load this in your startup file, then you need to open a brand new terminal, and check

```
echo $JAVA_HOME
java --version
mvn --version
```


If you now see that `$JAVA_HOME` is defined as the directory where Java 17 lives, 
and that both java and mvn are giving us Java 17, try doing what was failing in a brand new terminal window.


Try a `mvn clean` before you do anything else though.
