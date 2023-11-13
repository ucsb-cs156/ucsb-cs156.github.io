---
parent: Liquibase
grand_parent: Topics
layout: default
title: "liquibase: adding a table"
description:  "How to add a new table"
indent: true
---

# {{page.title}}

When not using liquibase, to add a new table, you simple create the `@Entity` class and the `@Repository` class.

When using liquibase, there is an additional step: you must generate the changelog file and store it in `src/main/resources/db`

You can generate the changelog by hand, but it is easier to use a tool to do it.   

# Example: Adding a `course` table

As an example, suppose you are adding the following `@Entity` (imports omitted to save space):

```java
@Data
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Entity(name = "courses")
public class Course {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private long id;

  private String name;
  private String school;
  private String term;
  private LocalDateTime start;
  private LocalDateTime end;
  private String githubOrg;
}
```

