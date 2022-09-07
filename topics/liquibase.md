---
parent: Topics
layout: default
title: "Liquibase: "
description:  "A database migration framework"
category_prefix: "Liquibase: "
---

## Why use Liquibase?
When implementing backend changes, you may need to alter how data is stored in the database. By default, Spring Boot has
a mechanism which attempts to restructure the database to match the structure implied by the Java code. This system
works in some cases, but there are many cases where this system is unable to understand how you want the database to
be modified. Liquibase allows us to explicitly specify what we want to do to the database, which is generally less
error-prone and is safer to use on real production data.

## (Recommended) Setting up your editor
If you use VS Code, you may want to install the
[XML Language Support plugin](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-xml). This plugin offers
validation and code completion for XML files such as the `pom.xml` or Liquibase's `changelog.xml`, which is very
helpful when making changes to those files.

## Understanding the `changelog.xml`
The Liquibase `changelog.xml` (located in the `db` folder in CS156 projects) is a list of all the changes that must be
made to an empty database in order to create the correct database schema/structure. Any changes you with to make to the
database should be encapsulated inside a `<changeSet>` tag with an id (that must be unique within the entire file) and
the author name (which usually should just be your GitHub username). The `<changeSet>` tag can contain a number
of changes, each of which describes an action to be performed on the database. A full list of these change types
can be found [here](https://docs.liquibase.com/change-types/home.html).

## Updating the database
If you are starting from a fresh database or have changesets in the `changelog.xml` which have not been applied
(because you either wrote a new changeset or pulled changes that add to the changelog), you will have to run
`./mvnw liquibase:update` in order to apply those changesets.

