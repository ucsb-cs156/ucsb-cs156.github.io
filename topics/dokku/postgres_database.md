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
   DATABASE_URL:  postgres://postgres:93402a78c99a6bcb2e98cb89a98b348@dokku-postgres-starter-team02-db:5432/starter_team02_db
   ```
    
   This value has the following parts:
   
   | part | explanation |
   |------|-------------|
   | `postgres://` | protocol |
   | `postgres`    | username |
   | `93402a78c99a6bcb2e98cb89a98b348` | password |
   | `dokku-postgres-starter-team02-db` | hostname |
   | `5432` | port | 
   | `starter_team02_db` | database |
   
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

4. Set up a config variable called `JDBC_DATABASE_URL` constructed as follows:

   * Starts with `jdbc:postgresql://localhost:5432/` followed by *your* database name
   * For example: `jdbc:postgresql://localhost:5432/starter_team02_db`
   
   So the command will be something like:
   
   ```
   dokku config:set --no-restart jpa03-cgaucho JDBC_DATABASE_URL=jdbc:postgresql://localhost:5432/starter_team02_db
   ```

Once these values are all set up, you can restart the app with `dokku ps:restart jpa03-cgaucho`, or by pushing an empty commit.

Note that we **do not put these values in `.env`** since that file is used for `localhost`, and we do not typically use postgres when running on localhost (we use H2, an database embedded in the Spring Boot server instead).

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




