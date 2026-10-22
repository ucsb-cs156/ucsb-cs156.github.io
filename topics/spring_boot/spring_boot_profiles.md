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

This is specifically useful in a couple of cases:
1. You have dependencies (`@Bean`, `@Service`, etc) or configuration classes that only need to be active at specific times.
2. You have properties that you'd like to be available at particular times.

# Defining which Spring Boot profile runs

## Maven

We have the ability to define which Spring Profiles are set via a Maven property. We can use maven profiles (which differ from Spring profiles) to decide which Spring profiles are active during a given time. For example, most of our codebases as of 10/2026 use some version of the following code:

```xml

<profiles>
    <profile>
        <id>localhost</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <springProfiles>localhost</springProfiles>
        </properties>
    </profile>
    <profile>
        <id>production</id>
        <activation>
            <property>
            <name>env.PRODUCTION</name>
            </property>
        </activation>
        <properties>
            <springProfiles>production</springProfiles>
        </properties>
    </profile>
</profiles>

```

This means that by default, the maven profile `localhost` is active and it sets the Spring Profile `localhost`. If the environment variable PRODUCTION is set, instead of localhost, the profile `production` will run. It will set `springProfiles` to the Spring Profile `production`.

This is then substituted into `application.properties` with the following line:
```yaml
spring.profiles.active=@springProfiles@
```

The value of `springProfiles` will be substituted for `@springProfiles` with at *packaging time*, rather than runtime.


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

## Dynamically adding a Spring Profile at Runtime
Maven is a useful way to add spring profiles at packaging time; however, sometimes, like on Dokku, the environmental variables are not available at packaging time. As a result, Spring Boot offers a way to add profiles at runtime. You can wire a Spring Factory, placing it under META-INF, with a reference to the environment processor, and dynamically add a Spring Profile prior to the app being fully instantiated. It will then behave normally.


For an example of what this looks like, see [here](https://github.com/ucsb-cs156/proj-frontiers/blob/7e4dca2b4512dece9232b9324287bae30d702fa4/src/main/java/edu/ucsb/cs156/frontiers/startup/AzureProfileEnabler.java), and [here](https://github.com/ucsb-cs156/proj-frontiers/blob/7e4dca2b4512dece9232b9324287bae30d702fa4/src/main/resources/META-INF/spring.factories) for an example of spring.factories. As a note, you'll have to manually add the `application-<profile>.properties` to the classpath source, as it won't be picked up.