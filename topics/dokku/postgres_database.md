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

# Configuring the application

To configure a Spring-Boot application to access Postgres, you'll need to take these steps. These all assume that your application is called `jpa03-cgaucho`

1. Obtain the value of `DATABASE_URL` by typing 
   ```
   dokku config:show jpa03-cgaucho
   ```
   
   It will be something like this:
   
   ```
   DATABASE_URL:  postgres://postgres:93402a78c99a6bcb2e98cb89a98b348@dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db
   ```
    
   This value has the following parts:
   
   | part | explanation |
   |------|-------------|
   | `postgres://` | protocol |
   | `postgres`    | username |
   | `93402a78c99a6bcb2e98cb89a98b348` | password |
   | `dokku-postgres-starter-team02-db` | hostname |
   | `5432` | port | 
   | `jpa03_cgaucho_db` | database |
   
   Although, in principle, it should be possible to simply use this value for Spring Boot, as of this writing I have been unable to 
   determine how to get Spring Boot to accept this value unmodified.  The next step shows how we need to pick this value apart.
   
2. Set up a config variable called `JDBC_DATABASE_USERNAME` with the value `postgres` (the username), like this:

   ```
   dokku config:set --no-restart jpa03-cgaucho JDBC_DATABASE_USERNAME=postgres
   ```
   

3. Set up a config variable called `JDBC_DATABASE_PASSWORD` with the value of the password from *your* `DATABASE_URL` (not the one shown in the example below, but the output between the colon (`:`) and the at-sign (`@`) in the `DATABASE_URL` value on your screen.

   ```
   dokku config:set --no-restart jpa03-cgaucho JDBC_DATABASE_PASSWORD=93402a78c99a6bcb2e98cb89a98b348
   ```

   
4. Now, you need to determine the hostname and port of your dokku postgres service, along with the database name as it appears in the URL.

   For example, if the value of the `DATABASE_URL` is:

   ```
   DATABASE_URL:  postgres://postgres:93402a78c99a6bcb2e98cb89a98b348@dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db
   ```

   Then the part we want is basically everything after the `@` sign, i.e. this:

   ```
   dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db
   ```

   We'll use that value in the next step.

6. Set up a config variable called `JDBC_DATABASE_URL` constructed as follows:

   * Starts with `jdbc:postgresql://`
   * Then has the hostname, port and database name as formatted in the `DATABASE_URL` (i.e. everything after the `@`).
   
   For example:
   * If we have `DATABASE_URL:  postgres://postgres:93402a78c99a6bcb2e98cb89a98b348@dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db`
   * You need to define `JDBC_DATABASE_URL` as: `jdbc:postgresql://dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db`
   
   ```
   dokku config:set --no-restart jpa03-cgaucho JDBC_DATABASE_URL=jdbc:postgresql://dokku-postgres-starter-team02-db:5432/jpa03_cgaucho_db
   ```

Once these values are all set up, you can start the app by:
* Following the instructions in the `Deploying An App` section of [Getting Started](https://github.com/ucsb-cs156/ucsb-cs156.github.io/blob/main/topics/dokku/getting_started.md#deploying-an-app)
* With `dokku ps:rebuild jpa03-cgaucho`

Note that we **do not put the `JDBC_DATABASE_*` values in `.env`** since that file is used for `localhost`, and we do not typically use postgres when running on localhost (we use H2, an database embedded in the Spring Boot server instead).

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

## Dropping the Database
To drop the database without having to reconfigure postgres:
1. Connect using <code>dokku postgres:connect <i>appname-db</i></code>
2. Use `\c postgres` to connect to the default dbase instead of `appname_db` (**note that inside postgres, the database name uses underscores, not hyphens**).
3. Use the SQL command `DROP DATABASE appname_db;` to drop the database
4. Use the SQL command `CREATE DATABASE appname_db;` to create a new fresh database
5. Use `\c appname_db` to connect back to the original database name
6. Use `\dt to double check that there are no tables (relations) in the database.

## Resetting the entire database

This is the heavyweight approach.  It best to use this only as a last resort, since it's time consuming.

To rebuild the entire database:

1. Login to your dokku server (e.g., from CSIL, `ssh dokku-15.cs.ucsb.edu`
2. Stop the application, e.g. `dokku ps:stop app-name`
3. Unlink the database, e.g. `dokku postgres:unlink app-name-db app-name`
4. Destroy the database, e.g. `dokku postgres:destroy app-name-db`
5. Follow all of the procedures to recreate and relink the database, including updating all of the relevant config vars, from the very top of this page.
6. Restart the app, e.g. `dokku ps:restart app-name`


