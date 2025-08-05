---
parent: Liquibase
grand_parent: Topics
layout: default
title: "liquibase: llms"
description:  "Using llms to generate migrations"
indent: true
---

# {{page.title} - {{page.description}}

There are many possible uses for LLMs to assist with software engineering. 

LLMs are particularly well-suited for small focused tasks such as generating a database migration.   The key is to make the prompt as specific as possible.

Here's an example from `proj-frontiers`.


# Gemini Interaction for Spring Boot Database Migration

This document chronicles an interaction with Gemini to generate a database migration file for a Spring Boot project. The goal was to document how to use an AI assistant to produce appropriate database migration files based on changes to a Java entity class.


### Prompt 1: Initial Entity Changes

```
I'm working in a Spring Boot project that uses database migrations in JSON format.

Here are the changes to one of my entity files. Can you generate a suitable database migration file?

Before:

package edu.ucsb.cs156.frontiers.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String installationId;

    private String orgName;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonIgnore
    @ToString.Exclude
    private User creator;

    private String courseName;

    private String term;

    private String school;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "course")
    @Fetch(FetchMode.JOIN)
    @JsonIgnore
    @ToString.Exclude
    private List<CourseStaff> courseStaff;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "course")
    @Fetch(FetchMode.JOIN)
    @JsonIgnore
    @ToString.Exclude
    private List<RosterStudent> rosterStudents;
}


After:

package edu.ucsb.cs156.frontiers.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class Course {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String installationId;

    private String orgName;

    private String instructorEmail;

    private String courseName;

    private String term;

    private String school;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "course")
    @Fetch(FetchMode.JOIN)
    @JsonIgnore
    @ToString.Exclude
    private List<CourseStaff> courseStaff;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "course")
    @Fetch(FetchMode.JOIN)
    @JsonIgnore
    @ToString.Exclude
    private List<RosterStudent> rosterStudents;
}
```

Please call the database migration file 002-update-course.json


### Reply 1: Initial Migration File

To address the changes made to the `Course` entity, which involved removing the `creator` field and adding a new `instructorEmail` field, you'll need to create a database migration file that modifies the `course` table accordingly.

Here is the JSON content for the database migration file, named **002-update-course.json**:

```json
{
  "changeSet": {
    "author": "your-name",
    "id": "002-update-course",
    "changes": [
      {
        "renameColumn": {
          "tableName": "course",
          "oldColumnName": "user_id",
          "newColumnName": "instructor_email",
          "columnDataType": "varchar(255)"
        }
      }
    ]
  }
}
```

This migration file renames the existing `user_id` column to `instructor_email` and sets its data type to `varchar(255)`, which is the standard for string fields in Spring Boot. This approach is more efficient than dropping the old column and creating a new one, as it preserves any existing data that might be present in the table.

After applying this migration, you will need to manually update the data in the `instructor_email` column to reflect the correct email addresses, since the old `user_id` column contained a foreign key to the `user` table.

-----

### Prompt 2: Refining the Migration

```
Is there a way to modify this database migration so that it will populate the new `instructor_email`
column with the email value from the `user` entity that the old `user_id` referred to?
```


### Reply 2: Migration with Data Population

Yes, you can modify the database migration to automatically populate the new `instructor_email` column with the email from the `user` table. This involves two separate steps in your migration: first, adding the new `instructor_email` column, and second, updating that new column with the data from the `user` table based on the old `user_id` foreign key.

Here's the modified JSON for the database migration file, **002-update-course.json**:

```json
{
  "changeSet": {
    "author": "your-name",
    "id": "002-update-course",
    "changes": [
      {
        "addColumn": {
          "tableName": "course",
          "columns": [
            {
              "column": {
                "name": "instructor_email",
                "type": "VARCHAR(255)"
              }
            }
          ]
        }
      },
      {
        "sql": {
          "sql": "UPDATE course SET instructor_email = (SELECT email FROM user WHERE user.id = course.user_id);"
        }
      },
      {
        "dropColumn": {
          "tableName": "course",
          "columnName": "user_id"
        }
      }
    ]
  }
}
```

-----

### How the Migration Works

1.  **Add `instructor_email` column**: The first step uses `addColumn` to create the new `instructor_email` column in the `course` table. This column is initially empty.
2.  **Populate `instructor_email`**: The `sql` block then runs a raw SQL `UPDATE` statement. This statement joins the `course` table with the `user` table on the `user_id` foreign key and populates the new `instructor_email` column with the corresponding `email` value from the `user` table.
3.  **Drop `user_id` column**: The final step uses `dropColumn` to remove the old `user_id` foreign key column, as it's no longer needed after the data has been migrated.


## Prompt to get a Gemini Session in Markdown

I used the following prompt to get all of this in a format suitable for 
inclusion on this page:

```
I'd like to include this entire session in a Markdown file, with both my prompts, and your replies highlighted in some appropriate way.
The idea is to have some documentation of how to interact with Gemini to produce appropriate migrations.
Can you give me a markdown file I can download with everything up to, but not including, this prompt?
```


