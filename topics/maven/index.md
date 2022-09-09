---
parent: Topics
layout: default
title: Maven
description:  A build tool for Java plus a package manager
category_prefix: "Maven: "
has_children: true
---

The short version:

* Just as `make` and `CMake` are build tools for C/C++, there are a variety of build tools for Java.
* The main build tools used with Java as of 2020 are ant, Maven and Gradle.
  * Ant is the oldest of these, and is beginning to fall out of favor, through you will still see some older tutorials using it.
  * Maven tends to be used more by those building full-stack web apps
  * Gradle tends to be used more when building Android applications
  
In this course, we'll concentrate on Maven.

# Similarity with `npm`, `pip`, `gem`

We can compare Maven to Makefiles in C++, but there is another comparison if you've worked with package managers in languages such as:
* JavaScript (node/yarn), 
* Python (pip)
* Ruby (gem/bundler):

Maven is not just a build manager, but also a package manager

By package management, I mean that instead of you having to manage the process of obtaining all the .jar files for third party library that
your project may depend on (and the .jars that *those* files depend on, and so on...), maven manages that for you.

You add *dependencies* to the file `pom.xml`

# How Maven works, in a nutshell

* You create a file called `pom.xml` in the top level of your project
* You arrange your source code (and other files, such as configuration files) strictly according to a particular directory structure required by Maven
* You use commands such as `mvn compile`, `mvn test` and `mvn package` to compile, test, and package your code.
  - *Package* in this case, means to produce a `.jar` file for the project containing your compiled code.
  - We typically execute from the `.jar` file
* You run by running the `.jar` file produced inside the `target` directory




# References:

* [Apache Maven home page](https://maven.apache.org/)
* [Apache Maven FAQ](https://maven.apache.org/general.html)
* [Apache Maven in 5 minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)    
 


