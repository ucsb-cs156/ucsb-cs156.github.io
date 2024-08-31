---
parent: Java
grand_parent: Topics
layout: default
title: "Java: Versions"
description:  "Long Term Support vs. Non Long-Term Support, and why Java 17"
indent: true
---

# As of now, CMPSC 156 uses Java 17.  Only Java 17.

We have to be very selective about which version of Java we use. Specifically, we need to stick to the subset of Java versions
that are designated as *Long Term Support (LTS)* versions.  

That's because we rely on a large number of Java frameworks, including but not limited to those in the list below:
* Spring, Hibernate, Jackson, Jakarta, Jacoco, Pitest

Finding a set of versions of these dependencies that all work together isn't easy, and these frameworks
tend to only work (without problems) on LTS versions that have been out for a while.

# What about Java 21?

Java 21 is an LTS version scheduled for General Availability release on September 19, 2023.  That's too late to expect that
we can have all of the course materials migrated for Fall 2023.  When we move from Java 17, it will be to Java 21, but
only once we are confident that all of the course materials work with Java 21, and we've had enough time to migrate them all.

# But, do I really need Java 17?  

You may be wondering whether it's ok if you have Java 15 or Java 18, or some other version of Java instead of Java 17.    

This short answer is: 
* The simpler the assignment, the less likely it is to make a difference
* By the time we get into full-stack web apps with testing, it is likely to make a big difference.

So, yes, definitely try to get Java 17 (and not a later or earlier version).

# Why?  LTS vs. Non-LTS

While Java 20 is the most current version of Java (as of the last update to this page), it's important to 
note that Oracle supports two different kinds of Java versions:
* Long Term Support (LTS) releases
* Non Long Term Support releases

The last few LTS releases were Java 8, Java 11 and Java 17.  Java 21 will be the next one.

When you are only working with your *own* code, the difference between a LTS and a non-LTS release isn't that big a deal. 
But when integrating with APIs, third-party packages, etc. it's much more important to stick to the LTS versions.   

The reason is that maintainers of third-party packages such as Spring, JUnit, Jacoco, Pitest, etc. will do their best to make sure that their code is
*always compatible with LTS versions*.  But they frequently skip over intermediate versions.

The same is true of professional "real-world" software teams.  LTS versions are the ones that get the most attention from Oracle and from the OpenJDK support team, in terms of
making sure that bugs get fixed quickly.   The intermediate versions are, in a way, a kind of "beta test" of new language features.  They represent what is sometimes called
the *bleeding edge* (a pun on *leading edge*) of Java technology.

