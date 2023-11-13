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

## Step 1: Create the `@Entity` and `@Repository` classes

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

We also need the `@Repository` class, for example:

```java
@Repository
public interface CourseRepository extends CrudRepository<Course, Integer> {

}
```

Create these files first. Then you are ready for the next step.

## Step 2: Temporarily modify `application.properties` so that the table is created

Next, find this section in `src/main/resources/application.properties`:

```
# There are two settings for spring.jpa.hibernate.ddl-auto, namely "update" and "none"
# Normally the value should be none, because we are using liquibase to manage migrations
# However, temporarily, the value may need to be "update" when you want tables created
# or updated automatically by Spring Boot.

spring.jpa.hibernate.ddl-auto=none    
# spring.jpa.hibernate.ddl-auto=update 
```

As explained in the comment, you need to temporarily switch this to: 

```
# spring.jpa.hibernate.ddl-auto=none   
spring.jpa.hibernate.ddl-auto=update 
```

And then run the command:
```
mvn spring-boot:run
```

You do not need to run the frontend.  The web browser will show this:

<img width="668" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/a63340ad-cf3b-4e56-a3b6-b166bd38c46b">

Click on the link for the h2-console and connect.  You should see the new database tables have been created, for example:

<img width="477" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/195d4cfe-b7d2-4a33-ae17-b35ec12ad046">

<img width="211" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/75abb587-12ff-4498-be46-d5d962f9cd55">

## Step 3: Change `application.properties` back

Now CTRL/C to stop the backend running, and change the value in `src/main/resources/application.properties`: back to:

```
spring.jpa.hibernate.ddl-auto=none    
# spring.jpa.hibernate.ddl-auto=update 
```

## Step 4: Choose a filename for the change log


We next want to generate a change log, so we much choose a filename.  The choice is important, because change logs in multiple file are applied
in the order of their filenames (in alphabetical order, or more precisely, in "lexicographic order".)   We have chosen a naming convention to 
ensure the migrations are applied in the order we intend.

Look in the directory `src/main/resources/db/migration/changes/` to see what the next avaiable number is; the naming convention we use in CS156 is a four digit number followed by an underscore, followed by a brief title that describes the migration.   For example, we see: 

<img width="465" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/21014506-a632-48c3-a3ce-4e85c5e64648">

The next available number is `0005_` and we are defining the course table, so we choose the name `0005_CreateCourseTable.json`.

The full name is `src/main/resources/db/migration/changes/0005_CreateCourseTable.json`.

## Step 5: Generate the full migration change log

The next step is to generate a full change log that represents the entire database; we'll then edit it down to only the change that we want.

We can do that with the following command:

```sh
mvn liquibase:generateChangeLog > src/main/resources/db/migration/changes/0005_CreateCourseTable.json
```

After you do this command, look in your editor at the file you just created.  You may see some extra stuff at the top of the file like this:


