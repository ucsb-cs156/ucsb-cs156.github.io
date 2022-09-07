---
parent: Topics
layout: default
title: "Spring Boot: Testing"
description:  "Writing tests for Spring Boot code, especially controllers"
category_prefix: "Spring Boot: "
indent: true
---


When writing tests for Spring Boot controllers, one thing to keep in mind is that any of the modules that the controller depends on via *dependency injection* have to be
provided for in backend tests.

For example, suppose that a controller declares that it depends on having access to two database tables with code like this:


```java
  @Autowired
  private CommonsRepository commonsRepository;
  @Autowired
  private UserCommonsRepository userCommonsRepository;
```

Then, in any controller test code, we have to provide access to those same database tables, either real tables, or mocks of those tables.

We typically use *mocks* in tests, because that is more predictable and relilable than testing with a real database, and because we are
not testing the database functionality; we are testing our own controller code.

So in the controller test, what we need is:

```java
  @MockBean
  UserCommonsRepository userCommonsRepository;

  @MockBean
  CommonsRepository commonsRepository;
```

If one of these is missing, you'll get an error such as this one:

```
[ERROR] joinCommonsTest  Time elapsed: 0 s  <<< ERROR!
java.lang.IllegalStateException: Failed to load ApplicationContext
Caused by: org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'commonsController': Unsatisfied dependency expressed through field 'userCommonsRepository'; nested exception is org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type 'edu.ucsb.cs156.happiercows.repositories.UserCommonsRepository' available: expected at least 1 bean which qualifies as autowire candidate. Dependency annotations: {@org.springframework.beans.factory.annotation.Autowired(required=true)}
Caused by: org.springframework.beans.factory.NoSuchBeanDefinitionException: No qualifying bean of type 'edu.ucsb.cs156.happiercows.repositories.UserCommonsRepository' available: expected at least 1 bean which qualifies as autowire candidate. Dependency annotations: {@org.springframework.beans.factory.annotation.Autowired(required=true)}
```
