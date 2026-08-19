---
parent: Topics
layout: default
title: Liquibase
description:  "Database migration framework"
has_children: true
---

# Liquibase

Liquibase is a framework utilized to automate changes to existing databases while working on a live codebase.

Liquibase allows the users to describe changes and maintain a version-controlled log of a live database, which allows the users to roll back unwanted changes as well as evolve the existing tables to support a constant integration cycle.

## What is the problem that liquibase solves

Changes to code frequently involve changes to the database *schema*.  

The word *schema* here is a technical term that includes:
* The names of the tables in the database
* The names and data types of the columns in the database
* Which field is the primary key
* Integrity constraints, such as:
  * Whether a field is nullable or not
  * Whether whether it must be in a particular range
  * Whether the value must be a key in another table (a so-called *foreign key*)
  * etc.
 
Collectively, these are the *database schema*.

It is important that changes to the code and changes to the database schema happen at the same time.

## Why not just use `auto-ddl`?

Spring Boot has a feature called `auto-ddl` that tries to *infer* the database changes from the changes in the code.

For very small simple "practice" projects, this is often good enough.  When a project is "just for practice", 
and the data doesn't really matter, `auto-ddl` is a lot less work.  And in the cases where it doesn't get the job done, you just throw away the data and start over!

But, for actual production systems where *the contents of the database matter*, using `auto-ddl` is a high risk strategy, 
and not considered good practice.

A database migration system such as liquibase (or flyway, the other major database migration system for Spring Boot), is considered a better strategy.

## What other database migration frameworks exist?

Here is a table of popular backend web frameworks along with their primary programming languages and database migration tools/strategies.
As you can see, a few frameworks such as Django, Ruby on Rails and Laravel have database migrations built into the framework, while
others rely on add-on frameworks.

| Framework | Language | Database Migration Strategy / Tools |
| --- | --- | --- |
| [Django](https://www.djangoproject.com/) | Python | [included in framework](https://docs.djangoproject.com/en/stable/topics/migrations/) |
| [Ruby on Rails](https://rubyonrails.org/) | Ruby | [included in framework](https://guides.rubyonrails.org/active_record_migrations.html) |
| [Laravel](https://laravel.com/) | PHP | [included in framework](https://www.google.com/search?q=https://laravel.com/docs/migrations) |
| [ASP.NET Core](https://dotnet.microsoft.com/apps/aspnet) | C# | [EF Core Migrations](https://learn.microsoft.com/en-us/ef/core/managing-schemas/migrations/), [FluentMigrator](https://fluentmigrator.github.io/), [DbUp](https://dbup.readthedocs.io/) |
| [Spring Boot](https://spring.io/projects/spring-boot) | Java | [Flyway](https://flywaydb.org/), [Liquibase](https://www.liquibase.org/) |
| [Express.js](https://expressjs.com/) | JavaScript / TypeScript | [Knex.js](https://knexjs.org/guide/migrations.html), [Prisma](https://www.google.com/search?q=https://www.prisma.io/docs/concepts/components/prisma-migrate), [TypeORM](https://typeorm.io/migrations), [Sequelize](https://sequelize.org/docs/v6/other-topics/migrations/) |
| [NestJS](https://nestjs.com/) | TypeScript | [TypeORM](https://typeorm.io/migrations), [Prisma](https://www.google.com/search?q=https://www.prisma.io/docs/concepts/components/prisma-migrate), [MikroORM](https://mikro-orm.io/docs/migrations) |
| [FastAPI](https://fastapi.tiangolo.com/) | Python | [Alembic](https://alembic.sqlalchemy.org/) (via SQLAlchemy), [yoyo-migrations](https://pypi.org/project/yoyo-migrations/) |
| [Gin](https://gin-gonic.com/) | Go | [golang-migrate](https://github.com/golang-migrate/migrate), [Goose](https://github.com/pressly/goose), [GORM Migrations](https://gorm.io/docs/migration.html) |
| [Phoenix](https://www.phoenixframework.org/) | Elixir | [included in framework](https://hexdocs.pm/ecto_sql/Ecto.Migration.html) (via Ecto) |
| [Rocket](https://rocket.rs/) | Rust | [Diesel Migrations](https://www.google.com/search?q=https://diesel.rs/guides/getting-started.html%23running-migrations), [SQLx Migrations](https://docs.rs/sqlx/latest/sqlx/macro.migrate.html) |
| [Play Framework](https://www.playframework.com/) | Scala / Java | [included in framework](https://www.google.com/search?q=https://www.playframework.com/documentation/latest/Evolutions) (Evolutions), [Flyway](https://flywaydb.org/) |


## What is the tl;dr that I need to know about liquibase for CS156?

This section is NOT everything you need to know about liquibase for working with CS156 projects, but it does include the most
important things:

1. Any time you add a new entity, delete an entity or modify an entity, you need a new database migration.
2. NEVER edit an existing migration if it has already been executed on the `main` branch in production.  Only make changes via new migrations.
3. Even for qa instances, if a database migration has already been run, and you then *change* it, you are going to have trouble.  After doing
   this, you'll get the dreaded checksum error, the `ValidationFailedException`.  The error looks something like this:
   ```
   liquibase.exception.CommandExecutionException: liquibase.exception.ValidationFailedException: Validation Failed:
     1 changesets check sum
       db/migration/changes/005-create-ucsbapiquarter-table.json::005-create-ucsbapiquarter-table::pconrad was: 9:654e80c1bf6fda5ffa1f0412a8aa87a8 but is now: 9:95c9a791de4538ad7bc160a697d7e1d2
   ```
   This error means that the liquibase migration named (in the example, `005-create-ucsbapiquarter-table` attributed to use `pconrad`) already ran on this database, but with a different set of instructions.   Liquibase says, essentially: "whoa, this is not what I expected, and so the database is probably going to end up in a messed up state if I just proceed, so I'm going to stop".  
   
## Changelog

The `changelog` in the main file to know about liquibase. It is used to describe the database changes to liquibase and should be maintained throughout the project.

## Multi-file vs Master file
There are essentially 2 ways to describe the changes on `changelog`. The first way is to use a master file approach where all changes are described in a single file, this method could be useful for an evolving database that contains few or one table. The other approach to be used is the multi-file approach, where the user will have one master `changelog` that points to other changelogs. This approach is useful because it can keep the changes more organized making it easier to look for changes to a specific table if the needs arises.

## How to describe changes

The changes on the `changelog` can be described in `xml`, `yaml`, and `json`. Each of the languages has its pros and cons and it will be ultimately up to the developer to choose what will fit the project they are working on.   For CS156 we've chosen `json` since we already use it extensively in our backend and frontend implementations.

## ChangeSet

Inside each `changelog` will be a collection of `ChangeSets`. Each `ChangeSet` describes a sequence of changes to be applied to the database. Each change set will have its unique ID as well as the author of that particular `ChangeSet`. The ID will be used to let liquibase know which change sets have been applied to the database already to avoid all changes being reapplied every time the project is started.

## Changes

A Change is something you want to do with the database like `createTable`, `addColumn` etc. Multiple changes can be described in a single `ChangeSet` just like multiple `ChangeSets` can be described in each `ChangeLog`. For all possible change types, you can check [Changes](https://docs.liquibase.com/change-types/home.html)

## Preconditions

Preconditions are conditions you can specify that need to be met in order to run a certain change or to specify what liquibase should do in case a certain change fails to be applied, for example when it tries to create a table that already exists, instead of failing it should mark that change as complete

## DATABASECHANGELOG

The `DATABASECHANGELOG` table contains a log of all `ChangeSets` that have been applied to the database and in which order, as well as their ID and author.

## Commands

Liquibase has multiple commands that can be used to modify the database, roll back changes, verify the changelogs, sync the database to changes, verify which changes will be run on the next update, etc. For all commands check [Commands](https://docs.liquibase.com/commands/home.html)
