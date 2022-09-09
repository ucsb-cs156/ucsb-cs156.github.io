---
parent: Maven
grand_parent: Topics
layout: default
title: "Maven: FAQ"
description:  "Frequently Asked Questions and misc tips/troubleshooting"
indent: true
---


# `The JAVA_HOME environment variable is not defined correctly`...

If you are working on CSIL and get this error
```
The JAVA_HOME environment variable is not defined correctly
This environment variable is needed to run this program
NB: JAVA_HOME should point to a JDK not a JRE
```
Then here's the fix:

```
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

```

Type that once before you use mvn commands

To avoid having to type that every time you work on CSIL, you can add that line to your Shell startup files.   That file might be, for example, `.bash_profile` by running the following:

```bash
echo 'JAVA_HOME=/usr/lib/jvm/java-17-openjdk' >> ~/.bash_profile
```

You can verify that this worked properly by doing the following:

```bash
source ~/.bash_profile
$JAVA_HOME/bin/javac -version
```

You should see `javac 17.0.1` as the output. 

Disconnect and reconnect to double check that it still works; if it still does, then you've solved the problem.

# `Error: A JNI error has occurred, please check your installation and try again`

This error usually indicates a mismatch between the Java versions being used. For example, you may have compiled with Java 17 but are using an older version of the JRE. First make sure your `JAVA_HOME` variable is set to JAVA 17 (following the instructions in the first part of this post if necessary), then make sure your `PATH` environment variable is updated to make sure the JRE for Java 17 is being used: 

```
export PATH=$JAVA_HOME/bin:$PATH
```
To make this change permanent, add it to your `.bash_profile`:
```
echo 'PATH=$JAVA_HOME/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
```

# What the heck: `[WARNING] Using platform encoding (UTF-8 actually)`

Here's what to do:

```xml
 <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>
```


# Making `mvn clean` remove app specific files


If you want `*.log` from the `logs` directory (or any other custom fileset or directory) to be deleted when you do `mvn clean`, here is how you can accomplish that: just "configure the `maven-clean-plugin`" in your pom.xml (as explained [here](https://maven.apache.org/plugins/maven-clean-plugin/examples/delete_additional_files.html)).  Be sure this goes in the `build` plugsin (not the `reporting` plugins, for example.)

```xml
   <!-- also remove logs on maven clean -->
      <plugin>
        <artifactId>maven-clean-plugin</artifactId>
        <version>3.1.0</version>
        <configuration>
          <filesets>
            <fileset>
              <directory>logs</directory>
              <includes>
                <include>**/*.log</include>
              </includes>
            </fileset>
          </filesets>
        </configuration>
      </plugin>
```
