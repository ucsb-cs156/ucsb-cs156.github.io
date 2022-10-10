---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Profiles"
description:  "Giving a name to different contexts in which your application might run"
---

# {{page.title}}

Spring Boot has a concept of `profiles`, which are different contexts in which your application might run.  

The first thing to note is that *Maven profiles* and *Spring Boot* profiles are **different concepts
with the same name**, which can be very confusing!   Be sure, before you read on, that you aren't confusing the two!

# The use case for Spring Profiles

For example, we might define profiles for:

* development
* production
* test

Or for:

* h2
* postgres

It is possible to have more than one profile active; there are pros and cons to this.  It is helpful to separate concerns, but it can also be difficult to make sure that
every combination of profiles works properly.

# Defining which Spring Boot profile runs

## Localhost


On localhost: you can can include an option on the `mvn spring-boot:run` command [as documented here](https://docs.spring.io/spring-boot/docs/2.0.1.RELEASE/maven-plugin/examples/run-profiles.html).  For example, to run with the `production` and `postgres` profiles,
you can use:

```
mvn -Dspring-boot.run.profiles=production,postgres spring-boot:run
```

## Heroku

For Heroku, the command that runs your application by default (unless you override it in a Procfile) (as documented [here](https://devcenter.heroku.com/articles/java-support#default-web-process-type)) is: 

```
java -Dserver.port=$PORT $JAVA_OPTS -jar target/*.jar
```

So, you can override the default profile by defining an Environment Variable (Heroku calls these Config Vars) called `JAVA_OPTS` and setting the value to this, for example, to
set the active profiles to `production` and `postgres`:

```
-Dspring.profiles.active=production,postgres
```

