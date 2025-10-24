---
parent: Dokku
grand_parent: Topics
layout: default
title: "Postgres Database"
description:  "How to deploy a postgres database"
---

# {{page.title}} - {{page.description}}

These instructions assume you are already familiar with the instructions on the [Getting Started](https://ucsb-cs156.github.io/topics/dokku/getting_started.html) page.

Suppose your app called `my-app` requires a postgres database.

To create this, login to the Dokku server and do the following:

```
dokku postgres:create my-new-app-db
dokku postgres:link my-new-app-db my-new-app
```

* The command `dokku postgres:create my-new-app-db` creates the database. While it is not required that the name be the app name with `-db` appended, we encourage following  this naming convention (or a similar one) to reduce confusion.
* The command  `dokku postgres:link my-new-app-db my-new-app` links the app to the database

It is normal to get a message `App image (dokku/my-new-app:latest) not found` if you have not yet deployed the app, which is typical at this stage.

After you do this, try the command:

```
dokku config:show my-new-app
```

You should see a config variable called `DATABASE_URL` that has the credentials (username/password) for the database embedded in it.  Starting with Spring 2025, the Spring Boot apps we use in CMPSC 156 include a script that picks up the necessary values from this URL.   (Apps written prior to that quarter may require extra configuration).

Note that we **do not put the `DATABASE_*` values in `.env`** since that file is used for `localhost`, and we do not typically use postgres when running on localhost (we use H2, an database embedded in the Spring Boot server instead).

# Postgres command line

From the dokku server, you can access the postgres command line where you can:
* List the database tables (relations)
* Enter SQL commands

First, list the databases with the command:
* `dokku postgres:list`

If your database is `jpa03-cgaucho-db`, then you can access the Postgres command line with:

* `dokku postgres:connect jpa03-cgaucho-db`

At this command:
* `\dt` can be used to list the tables (relations).
* `\q` can be used to quit the application

A cheatsheet of other `psql` commands can be found here:  <https://www.geeksforgeeks.org/postgresql-psql-commands/>


# Resetting the Database

During development, sometimes you may find that the database tables get corrupted, and this leads to SQL errors, even when your code is correct.

The cause is typically a change in the database schema, i.e. adding, changing, or removing a column from an `@Entity` class in your Spring Boot backend.

There are two ways to reset the database:
1. If you know which table is causing the problem, you can just delete (`DROP`) a single table, and Spring Boot will rebuild it when the app is redeployed.
2. If you don't know which table is causing the problem, you can remove the entire database, and then relink it.

More details on each way below

## Dropping a Single Table

To drop a single table:

1. Login to your dokku server (e.g., from CSIL, `ssh dokku-15.cs.ucsb.edu`
2. Connect to the postgres database, e.g.
   ```
   dokku postgres:connect my-app-name-db
   ```
3. This gives you a postgres problem. Use `\dt` to list the database tables
4. Use `DROP TABLE table_name;` to drop the table.  Make sure the command ends in a semicolon (`;`).
5. Use `\q` to quit the postgres command line
6. Restart the application with: `dokku ps:restart app-name`

## Dropping all tables

To drop all tables without having to reconfigure postgres:

1. Stop your application by running `dokku ps:stop appname`
2. Connect using <code>dokku postgres:connect <i>appname-db</i></code>
3. Copy paste the following SQL command from [this Stack Overflow answer](https://stackoverflow.com/a/61221726) at the postgres prompt:
   ```sql
   DROP SCHEMA public CASCADE;
   CREATE SCHEMA public;
        
   GRANT ALL ON SCHEMA public TO postgres;
   GRANT ALL ON SCHEMA public TO public;
   ```
4. Use `\dt to double check that there are no tables (relations) in the database.
5. Then, restart your app with `dokku ps:rebuild appname`

## Resetting the entire database

This is the heavyweight approach.  It best to use this only as a last resort, since it's time consuming.

To rebuild the entire database:

1. Login to your dokku server (e.g., from CSIL, `ssh dokku-15.cs.ucsb.edu`
2. Stop the application, e.g. `dokku ps:stop app-name`
3. Unlink the database, e.g. `dokku postgres:unlink app-name-db app-name`
4. Destroy the database, e.g. `dokku postgres:destroy app-name-db`
5. Follow all of the procedures to recreate and relink the database, including updating all of the relevant config vars, from the very top of this page.
6. Restart the app, e.g. `dokku ps:restart app-name`


