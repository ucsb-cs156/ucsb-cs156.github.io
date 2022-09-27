---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Versions"
description:  "Long Term Support vs. Non Long-Term Support, and why Java 17"
indent: true
---

# Do I really need Java 17?  

You may be wondering whether it's ok if you have Java 15 or Java 8, or some other version of Java instead of Java 17.    

This short answer is: 
* The simpler the assignment, the less likely it is to make a difference
* By the time we get into full-stack web apps with testing, it is likely to make a big difference.

So, yes, definitely try to get Java 17 (and not a later or earlier version).

# Why?  LTS vs. Non-LTS

While Java 18 is the most current version of Java (as of the last update to this page), it's important to 
note that Oracle supports two different kinds of Java versions:
* Long Term Support (LTS) releases
* Non Long Term Support releases

The last two LTS releases were Java 8, Java 11 and Java 17.

When you are only working with your *own* code, the difference between a LTS and a non-LTS release isn't that big a deal. 
But when integrating with APIs, third-party packages, etc. it's much more important to stick to the LTS versions.   

The reason is that maintainers of third-party packages such as Spring, JUnit, Jacoco, Pitest, etc. will do their best to make sure that their code is
*always compatible with LTS versions*.  But they frequently skip over intermediate versions.

The same is true of professional "real-world" software teams.  LTS versions are the ones that get the most attention from Oracle and from the OpenJDK support team, in terms of
making sure that bugs get fixed quickly.   The intermediate versions are, in a way, a kind of "beta test" of new language features.  They represent what is sometimes called
the *bleeding edge* (a pun on *leading edge*) of Java technology.

According to Oracle, the next planned LTS release is Java 21 in September 2023.
