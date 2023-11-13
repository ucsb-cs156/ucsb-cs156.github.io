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

We want to generate a change log.  

The first step is to choose a file name.  We should look in the directory `src/main/resources/db/migration/changes/` to see what the next avaiable number is; the naming convention we use in CS156 is a four digit number followed by an underscore, followed by a brief title that describes the migration.   For example, we see: 

<img width="465" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/21014506-a632-48c3-a3ce-4e85c5e64648">

The next available number is `0005_` and we are defining the course table, so we choose the name `0005_CreateCourseTable.json`.

The full name is `src/main/resources/db/migration/changes/0005_CreateCourseTable.json`.

The next step is to generate a full change log that represents the entire database; we'll then edit it down to only the change that we want.

We can do that with the following command:

```sh
mvn liquibase:generateChangeLog > src/main/resources/db/migration/changes/0005_CreateCourseTable.json
```

We can then open that file in our editor.

