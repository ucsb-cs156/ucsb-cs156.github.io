---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Logging"
description:  "How to write information to the log in Spring Boot"

---

Log4J is short for  [Apache Logging For Java](https://logging.apache.org/log4j)

The easiest way to use log4j in a Spring Boot application is to use the annotation `@Slf4j` on the class, like this:

```
@Slf4j
public class MyClass {
```

The import statement for this is: 

```
import lombok.extern.slf4j.Slf4j;
```

The annotation can be combined with others, as in this example:

```

@Slf4j
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "courses")
public class Course {
```

This gives you a variable `log` that you can use to write information to the log like this:

```
 log.trace("A TRACE Message");
 log.debug("A DEBUG Message");
 log.info("An INFO Message... profile.getUsername()="+profile.getUsername());
```

The various levels such as `trace`, `debug`, `info` and so forth give you fine grained control over how much detail is in the logs.

Use `info` for things that you would normally want to see, and `trace` and `debug` for things you would normally want hidden except when you are debugging.

# How to set the debug level

To set the level of debugging, you can set the value in one of these ways.  This can be done at the level of individual packages.

1. In the file `src/main/resources/application.properties` like this:
   ```
   logging.level.org.pac4j.springframework.web=DEBUG
   logging.level.org.pac4j.core.engine=DEBUG
   logging.level.path.to.your.class=INFO
   ```
2. If you have a way of setting up the environment variable `SPRING_APPLICATION_JSON`, you can set the variables there also.


# The old way (without `@Slf4j`)

The old way of doing this is to use the following imports:

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

# See Also

* <http://www.springboottutorial.com/logging-with-spring-boot-logback-slf4j-and-log4j>
* <https://www.baeldung.com/spring-boot-logging>
