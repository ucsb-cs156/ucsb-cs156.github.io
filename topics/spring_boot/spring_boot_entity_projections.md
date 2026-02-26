---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Entity Projections"
description:  "Projecting directly to records and interfaces from repositories"
---

## Introduction
Java is a very verbose language. At times, it can require a lot of boilerplate code to accomplish a goal (for instance, an interface, a factory, and an implementation). One of the important parts of
Spring Boot is Data Transfer Objects (known as DTOs). Due to the nature of Java, these can require a lot of code in order to allow mapping between concrete entity types and the sorts of DTOs that should
be output from controllers.

As a result, Spring Boot provides some shortcuts to cut down on the amount of boilerplate required. It does so by allowing repository methods to project directly to both `records` and `interfaces`.
Both behave slightly differently, however at it's simplest you can do this: 

With the `@Entity` Course:
```java
@Entity
public class Course{
  @Id
  private Long id;
  private String name;
  private String term;
  private String school;
}
```

Projection CourseProjection:
```java
public record CourseProjection(String name, String term){ }
```

Inside of CourseRepository, you can do this:
```java
Optional<CourseProjection> findProjectionById(Long id);
```

Note that the method name is `findProjectionById` -- the addition of Projection is not required; However, notably, Spring Boot will ignore anything between the initial verb (in this case `find`),
and the first `By` -- this allows us to differentiate methods to prevent signature conflicts.

The difference between the CourseProjection and the Course is that Hibernate will only request the selected fields when generating the SQL statement. In cases like ours, where we have a number of joins,
this can reduce the number of joins significantly to just the data we need.

## Interfaces
You can project to an interface in Spring-data-JPA. The benefit of doing so is that with interfaces, you can join mapped columns, like a `OneToMany` or `ManyToMany`. You can then select for subcolumns from
those mapped columns.

However, the downside is that without adding default definitions, you cannot tell Jackson how to map these to JSON.

## Records
Records are another alternative for projection. The benefit of a record is that you can apply Jackson properties to instruct it how to deserialize them, ie (`@JsonProperty`). However, these can only map
join to single linked records, like a `OneToOne` or a `ManyToOne`. 

For more information, see Spring Data JPA: https://docs.spring.io/spring-data/jpa/reference/repositories/projections.html
