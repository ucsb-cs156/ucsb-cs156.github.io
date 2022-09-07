---
parent: Topics
layout: default
title: "Maven: Plugins"
description:  "Plugins extend Maven functionality"
indent: true
category_prefix: "Maven: "
---

In a Maven `pom.xml` file, there is a `<dependencies>` section, which, unsurprisingly, contains one or more `<dependency>` elements:

```
<dependencies>
  <dependency>
  ...
  </dependency>
  
  
  <dependency>
  ...
  </dependency>

</dependencies>
```

Dependencies are so called "third-party Java libraries" (i.e. code written by someone other than us) that we can pull into our code and make use of.

There are thousands of these.   You can look them up at <https://search.maven.org/>.

Obviously, we'll only cover a small handful in this article; the ones most often used in CS156.


# JUnit 5

JUnit 5 is a testing framework for testing our Java code.   While previous versions (notably JUnit 4) were pulled in with a single dependency, JUnit 5 had grown so large that
it is broken up into multiple dependencies.  

The most common simple testing cases can be done with these two dependencies:

```
 <dependencies>
        <!-- https://mvnrepository.com/artifact/org.junit.jupiter/junit-jupiter-api -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.8.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>5.8.2</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
```

More complex cases, such as way we use JUnit 5 with Gradescope autograders, may require a more complete set of JUnit dependencies such as the one shown here.  Note that in this case,
the version numbers have been factored out into the `<properties>` section:

```
 <properties>
    <java.version>17</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <junit.jupiter.version>5.8.2</junit.jupiter.version>
    <junit.platform.version>1.8.2</junit.platform.version>
  </properties>

  <dependencies>

    <!-- JUnit unit testing (https://junit.org/) -->

    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-engine</artifactId>
      <version>${junit.jupiter.version}</version>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-api</artifactId>
      <version>${junit.jupiter.version}</version>
    </dependency>
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter-params</artifactId>
      <version>${junit.jupiter.version}</version>
    </dependency>
    <dependency>
      <groupId>org.junit.platform</groupId>
      <artifactId>junit-platform-suite</artifactId>
      <version>${junit.platform.version}</version>
    </dependency>
    <dependency>
      <groupId>org.junit.platform</groupId>
      <artifactId>junit-platform-launcher</artifactId>
      <version>${junit.platform.version}</version>
    </dependency>
    <dependency>
      <groupId>org.junit.platform</groupId>
      <artifactId>junit-platform-reporting</artifactId>
      <version>${junit.platform.version}</version>
    </dependency>
```

