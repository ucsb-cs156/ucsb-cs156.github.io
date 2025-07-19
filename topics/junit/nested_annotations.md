---
parent: JUnit
grand_parent: Topics
layout: default
title: "JUnit: Nested Annotations"
description:  "The purpose of and use of Nested Annotations"
indent: true
---

# {{page.title}}

# Basics
The basics of the `@Nested` annotation are well-covered by Baeldung here: https://www.baeldung.com/junit-5-nested-test-classes

# Spring and CS156-specific Notes
For our purposes, nested annotations are useful when attempting to test a class that requires multiple different configuration annotations to test fully.

For example, if I had a class that had a different `Bean` for two separate profiles, I could test it in one file like so:

```java
public class EnclosingClass{
  @ActiveProfiles("development")
  @Nested
  class SubclassOne{
    test_in_development()
  }

  @ActiveProfiles("production")
  @Nested
  class SubClassTwo{
    test_in_production()
  }

}
```

This allows us to keep the number of files down, while still fully testing classes.

Another time it may be important to use `@Nested` is when attempting to test custom Spring Security annotations. Spring Security is loaded prior to the test, so if you need to insert a `MockitoBean` into it, you must do so in an `@Before`. Without Nested annotations, you'd need a number of classes to test this.

With `@Nested`, you can set up subclasses, each with their on `@Before`.

If testing Spring Security, the annotations `@NestedTestConfiguration(NestedTestConfiguration.EnclosingConfiguration.INHERIT)` (inherit the parent class's annotations) and `setupBefore = TestExecutionEvent.TEST_EXECUTION` as a property of MockUser (load Spring Security after the `@Before` runs so the MockitoBeans stick) may make testing easier.
