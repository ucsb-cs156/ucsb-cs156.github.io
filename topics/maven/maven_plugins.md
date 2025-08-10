---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Plugins"
description:  "Plugins extend Maven functionality"
---

# {{page.title}} - {{page.description}}


In a Maven `pom.xml` file, there is a `<plugins>` section, which, unsurprisingly, contains one or more `<plugin>` elements:

```
<plugins>
  <plugin>
  ...
  </plugin>
  
  
  <plugin>
  ...
  </plugin>

</plugins>
```

Plugins extend the functionality of Maven.  Here are a few common ones that you may see in CS156, and what each of them does.

## maven-compiler-plugin/

The main purpose of this is configure the compiler used to compile our Java code.   

The most important thing we configure though this plugin is the **version of Java** that we'll be using to compile our code.  

For example, this sets the version to Java 17:

```
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-compiler-plugin</artifactId>
      <version>3.8.0</version>
      <configuration>
        <release>17</release>
      </configuration>
    </plugin>
```


Learn More: <https://maven.apache.org/plugins/maven-compiler-plugin/

## jacoco-maven-plugin

This plugin allows us to invoke the Jacoco (Java Code Coverage) tool to measure how well our JUnit tests are covering
our code.

This version works with JUnit 5 and Java 17:

```
   <plugin>
      <groupId>org.jacoco</groupId>
      <artifactId>jacoco-maven-plugin</artifactId>
      <version>0.8.7</version>
      <executions>
          <execution>
              <goals>
                  <goal>prepare-agent</goal>
              </goals>
          </execution>
          <execution>
              <id>report</id>
              <phase>prepare-package</phase>
              <goals>
                  <goal>report</goal>
              </goals>
          </execution>
      </executions>
  </plugin>
```

## maven-surefire-plugin

This plugin has to do with gathering information about runs of the test suites that are part of an application.

Our experience has been that when migrating a project to JUnit5, it is necessary to specify a version of this plugin
that is at least higher than version 22.2.0, or the tests may not run.

Example:

```
            <!-- needed to get JUnit 5 tests to run -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <!-- JUnit 5 requires Surefire version 2.22.0 or higher -->
                <version>2.22.0</version>
            </plugin>
```

According to the documentation:

> The Surefire Plugin is used during the test phase of the build lifecycle to execute the unit tests of an application. 
> It generates reports in two different file formats:
>
> * Plain text files (*.txt)
> * XML files (*.xml)
> 
> By default, these files are generated in `${basedir}/target/surefire-reports/TEST-*.xml`

* Documentation: <https://maven.apache.org/surefire/maven-surefire-plugin/>


