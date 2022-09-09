---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Xlint options"
description:  "For example, what to do when you get `Recompile with -Xlint:unchecked for details`"
indent: true
---

Occasionally, you might get a message about `unchecked or unsafe operations` that asks you to `Recompile with -Xlint:unchecked for details`.

```
[INFO] /Users/pconrad/github/sb/try-spring-boot-pac4j-oauth/src/main/java/code/zetcode/service/CityService.java: 
/Users/pconrad/github/sb/try-spring-boot-pac4j-oauth/src/main/java/code/zetcode/service/CityService.java 
uses unchecked or unsafe operations.
[INFO] /Users/pconrad/github/sb/try-spring-boot-pac4j-oauth/src/main/java/code/zetcode/service/CityService.java: 
Recompile with -Xlint:unchecked for details.
```

This typically happens when some code is doing something such as using `ArrayList thing = new ArrayList();` when it should be doing
`ArrayList<SomeClass> thing = new ArrayList<SomeClass>();`

A similar message may come up about `-Xlint:deprecation` if you are using methods or classes that have been marked by their authors as *deprecated*, meaning
their usage is discouraged, and they may be discontinued in a future release of Java, or the library that defines them.

# What to do to fix this

You need to see the detail in order to know what the specific problem is.  That's that the `-Xlint:unchecked` or `-Xlint:deprecation` switch does for you
.

If you are using command line `javac`, the remedy to see the extra detail is to recompile with `javac -Xlint:unchecked` to see the additional error
messages.  But if you are using Maven, it may be difficult to know how to proceed.   Here's the magic sauce to get the extra detail in your `mvn compile` output:

1.  In the `pom.xml`, locate the `<build>` section, and under it, the section for `<plugins>`.  If you don't have one already, create one:

   ```xml
   <build>
     <plugins>
     ...
     </plugins>
   </build>
   ```
   
2. In that section, put this `<plugin></plugin>` nested inside the `<plugins>..</pluging>` element.

   ```xml
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.0</version>
        <configuration>
          <compilerArgs>
            <arg>-Xlint:deprecation</arg>
            <arg>-Xlint:unchecked</arg>
          </compilerArgs>
        </configuration>
      </plugin>
   ```
   
    
