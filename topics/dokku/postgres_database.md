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

   
4. Now, you need to determine the IP address of the virtual host where the database server is running.  To do this, type
   this command (substituting in your database name instead of <tt><b><i>jpa03-cgaucho-db</i></b></tt>):
   
   * <tt>dokku postgres:info <b><i>jpa03-cgaucho-db</i></b></tt>
   
   You'll get output like this.  The part we care about is the part labelled `Internal ip:`, i.e. in this case the value `172.17.0.18`
   
   You need that value in the next step.
   
   ```
   pconrad@dokku-00:~$ dokku postgres:info jpa03-cgaucho-db
   =====> jpa03-cgaucho-db postgres service information
          Config dir:          /var/lib/dokku/services/postgres/jpa03-cgaucho-db/data
          Config options:                               
          Data dir:            /var/lib/dokku/services/postgres/jpa03-cgaucho-db/data
          Dsn:                 postgres://postgres:71d9cacbd1a4ed9c20884691199a4a9a@dokku-postgres-jpa03-cgaucho-db:5432/jpa03_cgaucho_db
          Exposed ports:       -                        
          Id:                  e61728e1c3450d86fdfbab2f836eb5e142607dbabcffb6508d5cba049581359e
          Internal ip:         172.17.0.18              
          Initial network:                              
          Links:               jpa03-cgaucho            
          Post create network:                          
          Post start network:                           
          Service root:        /var/lib/dokku/services/postgres/jpa03-cgaucho-db
          Status:              running                  
          Version:             postgres:15.2            
   pconrad@dokku-00:~$ 
```


5. Set up a config variable called `JDBC_DATABASE_URL` constructed as follows:

   * Starts with `jdbc:postgresql://`
   * Then list the IP address from the previous step, e.g. `172.17.0.18`
   * Then we need `:5432/` 
   * Finally, *your* database name 
     - Note that it may have underscores (`_`) in place of hyphens (`-`). Use the underscores.
   * For example: `jdbc:postgresql://172.17.0.18:5432/jpa03_cgaucho_db`
   
   So the command will be something like:
   
   ```
   dokku config:set --no-restart jpa03-cgaucho JDBC_DATABASE_URL=jdbc:postgresql://172.17.0.18:5432/jpa03_cgaucho_db
   ```

Once these values are all set up, you can start the app by:
* Following the instructions in the `Deploying An App` section of [Getting Starter](https://github.com/ucsb-cs156/ucsb-cs156.github.io/blob/main/topics/dokku/getting_started.md#deploying-an-app)
* With `dokku ps:restart jpa03-cgaucho` if you have built the application already.

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


# Resetting the postgres database

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

## Resettig the entire database

This is the heavyweight approach.  It best to use this only as a last resort, since it's time consuming.

To rebuild the entire database:

1. Login to your dokku server (e.g., from CSIL, `ssh dokku-15.cs.ucsb.edu`
2. Stop the application, e.g. `dokku ps:stop app-name`
3. Unlink the database, e.g. `dokku postgres:unlink app-name-db app-name`
4. Destroy the database, e.g. `dokku postgres:destroy app-name-db`
5. Follow all of the procedures to recreate and relink the database, including updating all of the relevant config vars, from the very top of this page.
6. Restart the app, e.g. `dokku ps:restart app-name`


