---
parent: Topics
layout: default
title: "Testing: Coverage"
description:  "Line vs. Branch coverage, what does it mean?"
category_prefix: "Testing: "
indent: true
---

# Test Coverage (aka Code Coverage)

It's helpful to be able to measure how much of our code is covered by tests.  This metric is known as "test coverage" or "code coverage".

# Line Versus Branch Coverage

Two common metrics are

* line coverage (how many lines of our code are covered by tests)
* branch coverage (how many branches, i.e. directions we can go, are covered by tests.)

It might be immediately obvious why those are not the same.

The answer is that not every if statement has an else.

```
  color="blue";
  if (x<10) {
      color="red";
  }
  foo(color);
```

Suppose we have a test that covers the case where `x<10` evaluates to true.   Then for those code, we have 100% line coverage, but we 
do not necessarily have 100% branch coverage unless we ALSO have a test that covers the case when `x<10` evaluates to false.   That means
that there is a branch into calling `foo(color)` when `color` still has the value "blue", and that branch is untested.

# Tools for measuring test coverage

One such tool is `Jacoco` (http://www.jacoco.org/jacoco/index.html)

The [documentation for Jacoco](http://www.jacoco.org/jacoco/trunk/doc/index.html) can be difficult to follow.

Here is some help:

* <https://www.codeproject.com/Articles/832744/Getting-Started-with-Code-Coverage-by-Jacoco>
* <http://www.baeldung.com/jacoco>
* <https://github.com/powermock/powermock/wiki/Code-coverage-with-JaCoCo>

