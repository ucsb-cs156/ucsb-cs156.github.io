---
parent: Topics
layout: default
title: "Maven: Hello World"
description:  "A relatively simple Hello World app with Maven"
indent: true
---

# A very simple pom.xml

The following pom.xml shows the minimal code we can come up with to compile a simple project using Java 17:


```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>edu.ucsb.cs156</groupId>
    <artifactId>hello</artifactId>
    <version>1.0.0</version>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.0</version>
                <configuration>
                    <release>17</release>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>
```

# Brief explanation

The outermost set of tags indicates that this is a Maven `project` element.  The `p` in `pom.xml` stands for `project`.  All Maven `pom.xml` files must contain, and the top level of nesting of tags and elements, exactly one `project` element (no more, no fewer).

```xml
<project>
...
</project>
```

The next four elements are required for all Maven projects:

```xml
    <modelVersion>4.0.0</modelVersion>
    <groupId>edu.ucsb.cs156</groupId>
    <artifactId>hello</artifactId>
    <version>1.0.0</version>
```

The `modelVersion` refers to the version of the Project Object Model.  As of Fall Quarter 2020, the current version is `4.0.0`.  So this element should always be exactly the text: `<modelVersion>4.0.0</modelVersion>`


Together, the `groupId`, `artifactId`, and `version` give a unique name to the project you a building; in Maven documentation, these are sometimes called the *coordinates* of a project.    

The `groupId` provides additional scope.  Using "reverse domain name" ordering is typical here (we'll see that Java packages often use a similar naming convention).    So the `groupId` value of `edu.ucsb.cs156` is the reverse of `cs156.ucsb.edu`.   According to the [Maven Naming Conventions](https://maven.apache.org/guides/mini/guide-naming-conventions.html), the group id is supposed to follow Java's [package naming rules](https://docs.oracle.com/javase/tutorial/java/package/namingpkgs.html), though that doesn't always happen.

The `artifactId` gives a name to your project; here we use `hello`.  We could also have used `helloWorld`, or `lab00`, or `jpa00`.   
* The `artifactId` is used to name the jar file, and as such should not contain spaces.  
* The naming conventions also suggest that you should stick to lowercase letters and avoid strange symbols.
* If your project is being autograded, it's important to use whatever name your instructor specified here, since the autograder may be expecting a particular name. 

If you want a "human friendly" name that contains spaces, etc. there is a separate element called `name` that can go in the POM (see: <https://ucsb-cs156.github.io/topics/maven_pom_xml_order/>, item 6).

Finally, the version number specifies the version of the item you are building.  The normal convention is to use something called [Semantic Versioning](https://ucsb-cs56.github.io/topics/semantic_versioning/) (*semver* for short), which assigns particular meaning to each of the digits.  For small practice projects, a version number of `0.1.0` or `1.0.0` is fine.

The next section specifies that you want to use a particular version of the Maven Compiler plugin, and that you want to use that plugin with Java 11.  

```
    <build>
        <plugins>
           ...
        </plugins>
    </build>
```

The outer-most element, `build` specifies that this is the section of the `pom.xml` that controls how the compilation is done.   The `build` can be configured with various `plugins`; in this case, we have only one `plugin`.    

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

Inside the `plugin` element, we see the `groupId/artifact/version` of the plugin (i.e. the plugin's *coordinates*); these are used to go and retrieve the specific version of the Maven Compiler Plugin (at run time) from the internet.  Finally, the `configuration` element contains a `release` element where we specify the Java release (in this case Java 17) that we want to use for compiling the project.

# Basic commands

The basic commands provided by this `pom.xml` include:

* `mvn compile` to compile the code
* `mvn package` which will compile the code *and* produce a `.jar` file, e.g.

   ```
   [INFO] Building jar: target/hello-1.0.0.jar
   ```
You can run the produced jar with the `java` command by
* specifying the jar file as the argument to `-cp` 
* specifying the class containing the main you want to run immediately following that

For example:

```
java -cp target/hello-1.0.0.jar Hello
```


# Warnings you may be able to ignore

Some warnings that you might get with a very simple project that are likely safe to ignore:

```
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
```

This indicates that the `pom.xml` file did not specify a default [*encoding*](https://www.w3.org/International/questions/qa-what-is-encoding), i.e. a map of binary values to Unicode characters, so the default for the system you are running on, `UTF-8`, is used.  We can fix this (and probably should) by specifying an encoding (usually `UTF-8`).  We'll do that in more complete `pom.xml` files.  For now, we are trying to keep things simple.


```
[INFO] skip non existing resourceDirectory /Users/pconrad/github/ucsb-cs156-f20/lab00-AUTOGRADER-PRIVATE/localautograder/submission/src/main/resources
```

This indicates that your project doesn't have a `src/main/resources` directory.  That's normal for simple projects.  When we get into more complex project later (e.g. Spring Boot web backends), there will almost always be a file called [`application.properties`](https://www.tutorialspoint.com/spring_boot/spring_boot_application_properties.htm) in that folder.   But for now, it's safe to ignore this warning.


# Another Example

This repo contains a relatively simple Hello World app in Maven, along with a single JUnit test that checks whether
the main method of the `edu.ucsb.cs56.pconrad.App` class prints `"Hello World!` (followed by a newline) on `System.out`.

* <https://github.com/ucsb-cs56-pconrad/hello-maven>

See the [README.md](https://github.com/ucsb-cs56-pconrad/hello-maven/blob/master/README.md) for more details.




