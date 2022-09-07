---
parent: Topics
layout: default
title: "Log4J: Spring Boot"
description:  "Using Log4J with Spring Boot"
category_prefix: "Log4J: "
indent: true
---


See also: <http://www.springboottutorial.com/logging-with-spring-boot-logback-slf4j-and-log4j>

Log4J is short for  [Apache Logging For Java](https://logging.apache.org/log4j)

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

To set the level of debugging, you can set the value in one of these ways:

1. In the file `src/main/resources/application.properties` like this:
   ```
   logging.level.org.pac4j.springframework.web=DEBUG
   logging.level.org.pac4j.core.engine=DEBUG
   logging.level.path.to.your.class=INFO
   ```
2. If you have a way of setting up the environment variable `SPRING_APPLICATION_JSON`, you can set the variables there also.
