---
parent: Topics
layout: default
title: "JUnit: Hamcrest Matcher style"
description:  "A different style of writing assertions for Unit testing"
indent: true
---

Hamcrest Matchers are an alternative to the ordinary style of writing asserts for JUnit testing.

# Using Hamcrest with Maven

```xml
<project>
  <dependencies>
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest-library</artifactId>
      <version>1.3</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
```

# Using Hamcrest with Gradle

```groovy
dependencies {
    // Unit testing dependencies
    testImplementation 'junit:junit:4.12'
    // Set this dependency if you want to use Hamcrest matching
    testImplementation 'org.hamcrest:hamcrest-library:1.3'
}
```

# Additional Resources

* Tutorial on using Hamcrest with JUnit <http://www.vogella.com/tutorials/Hamcrest/article.html>
