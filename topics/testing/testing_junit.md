---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: JUnit"
description:  "JUnit tests for various purposes, Junit 4 vs. Junit 5"
category_prefix: "Testing: "
indent: true
---

The main framework for testing Java code is JUnit.

Junit has gone through several versions. 
* As of W21, programming assignments for `MenuItem` and `Menu` were based on JUnit 4.
* However, Spring Boot legacy code projects are using JUnit 5.

Eventually, the programming assignments for `MenuItem` and `Menu` will be updated to use JUnit 5 syntax, but for now, it's helpful to be aware of the differences.

# `import` statements for JUnit in JUnit4 vs. JUnit 5

The import statements for JUnit 4 look like these (taken from the `MenuItem` and `Menu` assignments):

```java
import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.assertEquals;
```

The import statements for JUnit 5 in a Spring Boot projects look like these:


```java
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import org.junit.jupiter.api.Test;
```

# Testing for Exceptions

This article explains the difference: <https://www.baeldung.com/junit-assert-exception>
