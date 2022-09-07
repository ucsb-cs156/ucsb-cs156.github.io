---
parent: Topics
layout: default
title: "Testing: Jacoco"
description:  "How to interpret the reports (red, yellow, green)"
indent: true
category_prefix: "Testing:"
---

# Jacoco: Java Code Coverage

Jacoco (*Ja*va *Co*de *Co*verage)  is a tool for measing code coverage in Java.

* Jacoco Home Page: <http://www.jacoco.org>
* The [documentation for Jacoco](http://www.jacoco.org/jacoco/trunk/doc/index.html) can be difficult to follow.

Here are some additional articles:

* <https://www.codeproject.com/Articles/832744/Getting-Started-with-Code-Coverage-by-Jacoco>
* <http://www.baeldung.com/jacoco>
* <https://github.com/powermock/powermock/wiki/Code-coverage-with-JaCoCo>


# How to read the test coverage reports

First, read about test coverage in general to understand line vs branch coverage: <https://ucsb-cs156.github.io/topics/testing_coverage/>

* If any line of code is red, that means it is not tested at all&mdash;it is being missed by *line coverage*
* If a line of code is yellow, it means there are multiple ways to execute the line.
   * it may have an if/else, or a boolean expression involving `&&` or `||`, and thus there are multiple paths through the code (multiple branches).  
   * Yellow means it is being missed by *branch coverage*; some branches are covered, and others are not.   
   * Think about the multiple paths through the code and be sure your tests are coverage all of them.


