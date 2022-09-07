---
parent: Topics
layout: default
title: "Testing: Jacoco via Maven"
description:  "Setting up Jacoco test coverage, using Maven"
indent: true
category_prefix: "Testing:"
---

First: read about using Maven at these pages:

* Maven intro: <https://ucsb-cs56-pconrad.github.io/topics/maven/>
* Apache 5 minute guide to Maven: <https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html>
* Converting an Ant Project to Maven: <https://ucsb-cs56-pconrad.github.io/topics/maven_convert_ant_to_maven/>

Then, here's what you need to do to get Jacoco Test Coverage working for your project.

# You need to have your Maven Project set up for JUnit

As a reminder, in a Maven project:

* Regular application code goes under `/src/main/java`
* JUnit test code goes under `/src/test/java`

To use JUnit in a Maven project, you need the JUnit dependency in your `pom.xml` file:

```
<project>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
</project>
```

# Next, add in a plug-in for Jacoco:

There are many examples online of various ways to get Jacoco support in your pom.xml.  

Here are a few:

* <https://www.petrikainulainen.net/programming/maven/creating-code-coverage-reports-for-unit-and-integration-tests-with-the-jacoco-maven-plugin/>

* <https://www.javaworld.com/article/2074515/core-java/unit-test-code-coverage-with-maven-and-jacoco.html>

# Troubleshooting Jacoco

1.  Make sure you have the latest version of the jacoco
2.  Make sure you do `mvn test` then `mvn jacoco:report` then `mvn site:deploy`
3.  Make sure that you `git add docs`, commit and push so that the latest version is online.
4.  If you reset `<argLine>`, make sure that you add `${argLine}` inside your new setting.
   * WRONG: `<argLine>-Xmx1024M </argLine>`  (If it were Java, this would be: `argLine="-Xmx1024M"` )
   * CORRECT: `<argLine>-Xmx1024M ${argLine}</argLine>` (In Java, this would be: `argLine = "-Xmx1024M " + argLine`)
