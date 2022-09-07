---
parent: Topics
layout: default
title: "Spring Boot: Application Properties"
description:  "Defining the application.properties"
category_prefix: "Spring Boot: "
indent: true
---

In each Spring Boot application, there are values that can be configured without having to recompile the Java code. 

These are typically configured in a file called `application.properties` which lives under:

```
src/main/resources/application.properties
```

In practice, it may *feel* like you have to recompile,
because you still have to run `mvn:package` or `spring-boot:run` which packages up this file into it's proper location
in the `jar` file or `target` directory. However, no actual Java source get recompiled to make the changes that you make
in `application.properties` take effect.

# Examples of things that go in `application.properties`

The most common thing you'll see in `application.properties` are these two lines:

```
server.port: ${PORT:8081}
logging.level.org.springframework.web: DEBUG
```

# What about `application.yml`

Note that some applications will use `src/main/resources/application.yml` which serves the same function, but uses
a different syntax.

# Should `application.properties` go into git?

Typically we do put `application.properties` into git, but we *need to be careful*.   
* Some things that go into `application.properties` are meant to be kept secret such as database passwords
* Other things are things that are meant to be configured as you run or debug (e.g. debug levels), or adjusted for development, QA and production

We'll discuss more how to handle these cases as they arise.  The most important one is handling secrets, which is discussed below.

# Handling Secrets

Note that some instructions will tell you to put certain things in the `application.properties` that should really NEVER go into git.

One way of handling this is to define an *Environment Variable*.   

* When running on localhost, this is a Unix, MacOS, or Windows Environment Variable.
* When running on Heroku, this is a Config Variable.

Names of environment variables are, by convention, all upper case and use snake case (underscores).  

The environment variable used 
by Spring Boot to override `application.properties` values is called `SPRING_APPLICATION_JSON`.  It shoudl be set equal to a JSON string that defines keys/values for each application property that needs to be override or supplement the values in the `application.properties` file.

An example of this is illustrated in the repo: <https://github.com/ucsb-cs56-pconrad/spring-boot-app-config>

# More on `application.properties`

* <https://www.tutorialspoint.com/spring_boot/spring_boot_application_properties.htm>
