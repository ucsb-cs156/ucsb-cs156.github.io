---
parent: Topics
layout: default
title: "CSIL: Java 11"
description:  "How to configure your CSIL account for Java 11"
indent: true
---


To configure your CSIl account for Java 11, 

1. Using any text editor (e.g. `vim`, `emacs`) add these lines to your `~/.bashrc` file:

   For example, use one of these commands to edit the file:
   * `vim ~/.bashrc` 
   * `emacs ~/.bashrc`
   
   Here are the lines to add

   ```
   export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
   export PATH=$JAVA_HOME/bin:$PATH
   ```

2. Either log out and back in again, or just type this:

   ```
   source ~/.bashrc
   ```
   
3. Now, if you type `java --version` you should see that you are working with Java 11

   ```
   [pconrad@csilvm-01 ~]$ java --version
   openjdk 11.0.8 2020-07-14
   OpenJDK Runtime Environment 18.9 (build 11.0.8+10)
   OpenJDK 64-Bit Server VM 18.9 (build 11.0.8+10, mixed mode, sharing)
   [pconrad@csilvm-01 ~]$ 
   ```
   
   
