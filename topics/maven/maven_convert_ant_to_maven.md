---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: Convert Ant to Maven"
description:  "replacing ant build.xml with maven pom.xml"
indent: true
---

# Quick version

First, read the official Apache [Maven in 5 minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html) guide, and practice using Maven with a "Hello World" type scratch project so that you understand how Maven works BEFORE trying to convert your first pre-existing Ant based project to Maven. 

Now, assuming that your CS56 project is set up in the normal way with Ant:

1. You probably have a `src` directory has has under it, the packages, e.g. `src/edu/ucsb/cs56/package/Foo.java`.   

   To migrate this to the Maven way:
   
   * Create a directory `src/main/java` with `mkdir -p src/main/java`
   * Move everything in src to src/main/java:
      ```
      mv src/* src/main/java
      ```
      
      You'll get a message that src/main/java can't be moved into itself, which is normal, e.g.
      
      ```
      mv: rename src/main to src/main/java/main: Invalid argument
      ```
      
      But the rest of the files should be moved ok, and then the `edu/ucsb/cs56...` tree should be under `src/main/java`.

2.  If you have a directory with resources, put those files in `src/main/resources`

3.  If you have tests, those go under `src/test/java/` then the full package name, e.g. `src/test/java/edu/ucsb/cs56/TestFoo.java`.    The Maven convention is to keep test code separate from regular code.
   Instead, you need to create a directory java sources to src/main/java,

4. Create a `pom.xml` following this convention.

Be sure to change `YOUR_PROJECT_NAME_HERE` to the name of your project, and also fix the line with the name of the Main class that you want to run (look for `ClassWithTheMainInIt` in the example `pom.xml` below.)

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">

  <modelVersion>4.0.0</modelVersion>

  <groupId>edu.ucsb.cs56.projects.YOUR_PROJECT_NAME</groupId>

  <artifactId>YOUR_PROJECT_NAME</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>YOUR_PROJECT_NAME</name>
  <url>http://maven.apache.org</url>

  <properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
      <scope>test</scope>
    </dependency>
    
  </dependencies>
    
  <!-- Make jar file executable -->
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-jar-plugin</artifactId>
        <version>3.0.2</version>
        <configuration>
          <archive>
            <manifest>
              <!-- full package name of class with the main you want to run -->
              <mainClass>edu.ucsb.cs56.FULL.PACKAGE.NAME.ClassWithTheMainInIt</mainClass>
            </manifest>
          </archive>
        </configuration>
      </plugin>
    </plugins>
  </build>

</project>
```

Then, you should be able to at least do:

```
mvn compile
```

5.   If you get errors that some features are not supported in a given version of Java, 
   you may need to modify the pom.xml to indicate the level of Java needed.  For example:

   ```
   [ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin:3.1:compile (default-compile) on project cs56Parser: Compilation failure
   [ERROR] /Users/pconrad/github/lab06_starter_code/src/main/java/edu/ucsb/cs56/pconrad/parsing/tokenizer/Tokenizer.java:      [33,27] lambda expressions are not supported in -source 1.5 
   [ERROR] (use -source 8 or higher to enable lambda expressions)
   [ERROR] -> [Help 1]
   [ERROR] 
   ```
   Here is an [article that explains how to set the version of the compiler](https://maven.apache.org/plugins/maven-compiler-plugin/examples/set-compiler-source-and-target.html).  Or, here's the quick version:  add this to your `pom.xml`:
   
6.  The next problem you may encounter is this one:

   ```
   [ERROR] COMPILATION ERROR : 
[INFO] -------------------------------------------------------------
[ERROR] /Users/pconrad/github/lab06_starter_code/src/main/java/edu/ucsb/cs56/pconrad/parsing/parser/ParserTest.java:[8,24] package org.junit does not exist
   ```
   
   This may be because you have code that references JUnit under the `src/main/java` directory, when it should be under the `src/test/java` directory.   Disentangling these for a complex project may be complicated, but for many CS56 projects with comparatively little test coverage, it may not be that hard.   The idea is to move all the classes that reference JUnit into a parallel directory hierarchy under `src/test/java/...` where the `...` is the package name.
   
   Start with the first file that is reporting an error.
   
   Copy paste its full path name from the error message into the terminal, with an `ls` command to make sure you have the name right.
   
   ```
   ls /Users/pconrad/github/lab06_starter_code/src/main/java/edu/ucsb/cs56/pconrad/parsing/parser/ParserTest.java
   ```
   
   Then, use your up arrow to edit the command.   Remove the filename `ParserTest.java` from the end, replace `ls` with `mkdir -p` and replace `src/main/java` with `src/test/java`, like this:
   
   ```
   mkdir -p /Users/pconrad/github/lab06_starter_code/src/test/java/edu/ucsb/cs56/pconrad/parsing/parser/
   ```
   
   Then, again using copy/paste, `mv` the filename of the offending file into the directory you just created:
   
   ```
   mv /Users/pconrad/github/lab06_starter_code/src/main/java/edu/ucsb/cs56/pconrad/parsing/parser/ParserTest.java /Users/pconrad/github/lab06_starter_code/src/test/java/edu/ucsb/cs56/pconrad/parsing/parser/
   ```
   
   Run the compile again.  With luck and skill, the first file will no longer be on the list of complaints.  Repeat until you get them all.
   
7.  To generate javadoc, you'll need to include the [Maven javadoc plugin](https://maven.apache.org/plugins/maven-javadoc-plugin/index.html).

Put this plugin in the `<plugins>` element of your `pom.xml`:

```
 <project>
   <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-javadoc-plugin</artifactId>
        <version>3.0.0-M1</version>
        <configuration>
          <reportOutputDirectory>docs</reportOutputDirectory>
        </configuration>

      </plugin>
    </plugins>
 </project>
```

The most commonly used maven goals for this plugin are these (more can be found [here](https://maven.apache.org/plugins/maven-javadoc-plugin/plugin-info.html)):

| Goal | Description |
|------|-------------|
| `mvn javadoc:javadoc` | generates the Javadoc files for the project |
| `mvn javadoc:test-javadoc` | generates the *test* Javadoc files for the project |


The configuration part in the `pom.xml` snippet above overrides the default for where  the generated javadoc goes, setting it to `docs`.  This is compatible with publishing the docs via github pages.   

To make a link to that directory, you'll need a link to `http://OWNER.github.io/repo-name/apidocs/`  where `OWNER` is the name of the organization or user that owns the repo.

In addition, you may want to customize the `mvn clean` goal so that it wipes out the docs/apidocs directory when `mvn clean` is run.  To do that, add this plugin as well:

```xml
      <plugin>
        <artifactId>maven-clean-plugin</artifactId>
        <version>3.0.0</version>
        <configuration>
          <filesets>
            <fileset>
              <directory>docs/apidocs</directory>
            </fileset>
          </filesets>
        </configuration>
      </plugin>
 ```
 

# Resources:

* This [Stack Overflow Answer](https://stackoverflow.com/questions/4029501/how-to-convert-ant-project-to-maven-project) has at least some good information, though still leaves a lot out.
* The page [How to convert from "Ant to Maven in 5 minutes"](http://blog.sonatype.com/2009/04/how-to-convert-from-ant-to-maven-in-5-minutes/) from "Sonotype" comes up often in web searches, and is mentioned in Stack Overflow articles on the subject, but doesn't really have a lot of specifics, and in my view isn't particularly helpful to beginners.  YMMV.
