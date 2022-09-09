---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Testing"
description:  "Doing JUnit testing and other testing using mvn test, mvn verify, etc."
indent: true
---


To run JUnit tests with Maven, we typically type:

```
mvn test
```

To run integration tests for Spring Boot applications, instead, we use:

```
mvn verify
```

To run tests for a single test class `TestCircle`, we can use the syntax explained in [this article](https://maven.apache.org/plugins-archives/maven-surefire-plugin-2.12.4/examples/single-test.html), and summarized below:

```
mvn -Dtest=TestCircle test
```

To run just one test method, we can use this syntax:

```
mvn -Dtest=TestCircle#mytest test
```

There are more details at:
* <https://maven.apache.org/plugins-archives/maven-surefire-plugin-2.12.4/examples/single-test.html>
