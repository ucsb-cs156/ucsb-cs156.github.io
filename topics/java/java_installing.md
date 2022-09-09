---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Installing"
description:  "Installing Java 11"
indent: true
---

# Java 11 on Ubuntu

(Also: Ubuntu Linux Shell on  Chromebooks)

From: <https://www.linuxbabe.com/ubuntu/install-oracle-java-8-openjdk-11-ubuntu-18-04-18-10>

Manually download OpenJDK 11 from <http://jdk.java.net/11/>, or if you prefer to do this at the command line, use 
this:

```
wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz
```

Then extract the tarball into the directory `/usr/lib/jvm`:

```
sudo tar xvf openjdk-11.0.1_linux-x64_bin.tar.gz --directory /usr/lib/jvm/
```

Finally put this in your `.profile` to adjust your path so that the Java 11 binaries come before others:

```
JAVA11="/usr/lib/jvm/jdk-11.0.1/bin"
if [ -d "$JAVA11" ] ; then
    PATH="$JAVA11:$PATH"
fi
```

To reexecute your `.profile`, use:

```
source .profile
```

To check that you now have Java 11 as the default version, do this:

```
java -version
```

You should see something like this.   The "11" that follows openjdk version is the important part.

```
pconradcis@penguin:~$ java -version
openjdk version "11.0.1" 2018-10-16
OpenJDK Runtime Environment 18.9 (build 11.0.1+13)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.1+13, mixed mode)
pconradcis@penguin:~$ 
```
