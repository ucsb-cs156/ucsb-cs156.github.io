---
title: "Student: ex07"
parent: Student
grand_parent: Tutorials
description: "Introducing packages"
indent: true
code_repo: https://github.com/ucsb-cs156/student-tutorial
code_branch: ex07
---

# {{page.title}} 
## {{page.description}}

{% include student_tutorial_header.html %}

# Overview

We move our code into a package in this example.


# Introducing Packages

Real world Java code typically involves code from many authors, including
third-party Java code; code written by others that you use in your project.

In order to keep all of the names of classes from colliding with one another,
Java has the concept of *packages*.  At the top of any class, you can put a line such
as:

```java
package edu.ucsb.cs156.student_tutorial;
```

This indicates that the code inside the `.java` file is part of the package `edu.ucsb.cs156.student`.

This needs to be the first line of code in the file, before any import statements,
and typically before any comments as well.

The naming convention is often "reverse domain name", i.e. if you are part of `ucsb.edu`, you flip this so that the names go from most general, to most specific, hence: `edu.ucsb.cs156.student`.

Along with the package, there is a requirement to put the code (both `.java` files and the produced `.class` files) into a directory hierarchy that mirrors the package names.

So to put our code into the package `edu.ucsb.cs156.student`, we need to create
directories:

```
mkdir -p src/main/java/edu/ucsb/cs156/student
mv src/main/java/*.java src/main/java/edu/ucsb/cs156/student
mkdir -p src/test/java/edu/ucsb/cs156/student
mv src/test/java/*.java src/test/java/edu/ucsb/cs156/student
```

We then add the line `package edu.ucsb.cs156.student_tutorial;` to the top of each 
of our source files.  The line doesn't change depending on whether it's part of the `src/main/java` or the `src/test/java` directory.


