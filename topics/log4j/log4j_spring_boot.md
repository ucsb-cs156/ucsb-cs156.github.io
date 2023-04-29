---
parent: "Log4J"
grand_parent: Topics
layout: default
title: "Log4J: Spring Boot"
description:  "Using Log4J with Spring Boot"
category_prefix: "Log4J: "
indent: true
---

# {{page.title}} - {{page.description}}

A common debugging technique in any application, language or framework is to put in "debugging print statements", e.g.

```
   System.out.println("Inside method foo, myVariable = " + myVariable);
```

Of course, these can get noisy if there are too many of them. And the burden of adding and deleting these can get cumbersome. Therefore, many frameworks provide a way to manage these debugging print statements with a *logging framework* that allows the developer to turn off and turn off various levels of debugging output.

For Java applications, a commonly used logging framework is called `Log4J`.

# Using Log4J with the Lombok `Log4J` annotation

In our code base, the simplest way to use `Log4J` is to add the `@Log4J` annotation to the top of the class, like this:

```
@RestController
@Log4J
public class HelloController {
...
```

This annotation requires the following import:

```
import lombok.extern.log4j.Log4J;
```

Then, anytime you want logging information to appear, you can use statements such as these:

```
 log.trace("A TRACE Message");
 log.debug("A DEBUG Message");
 log.info("An INFO Message... profile.getUsername()="+profile.getUsername());
```


If the import is not able to be resolved, click the triangle for advice on what needs to be in your `pom.xml` for Maven to find Project Lombok imports.

<details markdown="1">
<summary>
Click here to get details on adding Lombok to your pom.xml
</summary>

If you are getting the error that:
```
package lombok.extern.log4j does not exist
```

Check that `lombok` is a dependency in your pom.xml.  It should look something like this:

```
    <!-- https://mvnrepository.com/artifact/org.projectlombok/lombok -->
    <dependency>
      <groupId>org.projectlombok</groupId>
      <artifactId>lombok</artifactId>
      <version>1.18.26</version>
      <scope>provided</scope>
    </dependency>
```

You can check here for the latest version: <https://mvnrepository.com/artifact/org.projectlombok/lombok>

</details>

# More on log4j

See also: <http://www.springboottutorial.com/logging-with-spring-boot-logback-slf4j-and-log4j>

Log4J is short for [Apache Logging For Java](https://logging.apache.org/log4j)

# Setting the debugging level

To set the level of debugging, you can set the value in one of these ways:

1. In the file `src/main/resources/application.properties` like this:
   ```
   logging.level.org.pac4j.springframework.web=DEBUG
   logging.level.org.pac4j.core.engine=DEBUG
   logging.level.path.to.your.class=INFO
   ```
2. If you have a way of setting up the environment variable `SPRING_APPLICATION_JSON`, you can set the variables there also.


# Setting up log4j the old fashioned way

You can also use log4j without Lombok.  Here's how:

In a Spring Boot application, inside any class where you want to do logging, you need these two import statements:

```
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
```

And then you need to put this line of code inside the class.  Substitute the actual name of the class
followed by `.class` inside the parameter to `LoggerFactory.getLogger`.  It is a good practice to put this
first in the class, so that if the class name changes, you remember to change the name of the class on the next line.

```
public class ThisIsTheClassName {
    private Logger logger = LoggerFactory.getLogger(ThisIsTheClassName.class);
...
```

Then, anytime you want logging information to appear, you can use statements such as these:

```
 logger.trace("A TRACE Message");
 logger.debug("A DEBUG Message");
 logger.info("An INFO Message... profile.getUsername()="+profile.getUsername());
```

