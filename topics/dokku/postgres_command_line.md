---
parent: Dokku
grand_parent: Topics
layout: default
title: "Dokku: Postgres Database: Command Line"
description:  "What you can do at the postgres -command line"
---

# {{page.title}}

Sometimes it may be helpful when working with a postgres database to use the postgres command line to 
examine the database directly, rather than just looking at what you can see in the running app, or
in the logs of the Spring Boot backend.

To do this, you can use the postgres command line, which can be accessed via the command:

<code>dokku postgres:connect <i>appname-db</i></code>

(Note that <code><i>appname-db</i></code> is just the naming convention we've adopted in this course for convenience; 
the postgres service on dokku for the app  <code><i>appname</i></code> does not *have* to be named  <code><i>appname-db</i></code>,
but if you've been following the instructions for this course, it probably will be.)

The first thing we'll tell you is how to quit out of this: the command is `\q`.    

But you probably want to know more.

# What can you do at the postgres command line?

Basically two types of things:
* backslash commands such as `\q`, `\dt`, `\l` etc.
* SQL commands

We'll document both of these below.

It's not our intention to make this page a full tutorial on all of the backslash commands and SQL commands, but we will show a few of the most useful ones, and then
point you to full documentation where you can learn the rest.

# Backslash Commands

A few useful backslash commands:

## `\dt` lists the tables

Example:
```
courses_db=# \dt
              List of relations
 Schema |       Name       | Type  |  Owner   
--------+------------------+-------+----------
 public | courses          | table | postgres
 public | historygrade     | table | postgres
 public | jobs             | table | postgres
 public | personalschedule | table | postgres
 public | ucsb_subjects    | table | postgres
 public | users            | table | postgres
(6 rows)

courses_db=# 
```

## `\d table_name` describes a table

You can use `\d table_name` to describe a table, i.e. show the names of the columns (fields in each row).

Example:

```
courses_db=# \d users
                                        Table "public.users"
     Column     |          Type          | Collation | Nullable |              Default              
----------------+------------------------+-----------+----------+-----------------------------------
 id             | bigint                 |           | not null | nextval('users_id_seq'::regclass)
 admin          | boolean                |           | not null | 
 email          | character varying(255) |           |          | 
 email_verified | boolean                |           | not null | 
 family_name    | character varying(255) |           |          | 
 full_name      | character varying(255) |           |          | 
 given_name     | character varying(255) |           |          | 
 google_sub     | character varying(255) |           |          | 
 hosted_domain  | character varying(255) |           |          | 
 locale         | character varying(255) |           |          | 
 picture_url    | character varying(255) |           |          | 
Indexes:
    "users_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "personalschedule" CONSTRAINT "fk4b2ycqqc913cibta56bkwog66" FOREIGN KEY (user_id) REFERENCES users(id)
    TABLE "courses" CONSTRAINT "fk51k53m6m5gi9n91fnlxkxgpmv" FOREIGN KEY (user_id) REFERENCES users(id)
    TABLE "jobs" CONSTRAINT "fkkjpyguuyd5shxtabv9v5jpe6x" FOREIGN KEY (created_by_id) REFERENCES users(id)

courses_db=# 
```


# SQL commands

The most basic SQL command is this one, which lists all of the data in the table named `tablename`.

```
 SELECT * FROM tablename;
```

Example: 

```
courses_db=# SELECT * FROM users;
 id | admin |        email         | email_verified | family_name |  full_name   | given_name |      google_sub       | hosted_domain | locale |                                        picture_url                                         
----+-------+----------------------+----------------+-------------+--------------+------------+-----------------------+---------------+--------+--------------------------------------------------------------------------------------------
  1 | t     | phtcon@ucsb.edu      | t              | Conrad      | Phill Conrad | Phill      | 115856948234298493496 | ucsb.edu      | en     | https://lh3.googleusercontent.com/a/AAcHTtdT2VLgNRYK0KzORTbjYgfU5Yxwaw5mbFcxGvYNVSVp=s96-c
  2 | f     | benjamin_ye@ucsb.edu | t              | Ye          | Benjamin Ye  | Benjamin   | 108916786450195076889 | ucsb.edu      | en     | https://lh3.googleusercontent.com/a/ACg8ocKKJiZ8XZZuIWUm5BvEnQ-Vg03XpK-PIncsuyPAScEH=s96-c
(2 rows)

courses_db=# 
```

Typically, however, in a terminal window, it will look sometnhing like this because the terminal is narrow:

```
courses_db=# SELECT * FROM users;
 id | admin |        email         | email_verified | family_name
 |  full_name   | given_name |      google_sub       | hosted_dom
ain | locale |                                        picture_url
                                         
----+-------+----------------------+----------------+------------
-+--------------+------------+-----------------------+-----------
----+--------+---------------------------------------------------
-----------------------------------------
  1 | t     | phtcon@ucsb.edu      | t              | Conrad     
 | Phill Conrad | Phill      | 115856948234298493496 | ucsb.edu  
    | en     | https://lh3.googleusercontent.com/a/AAcHTtdT2VLgNR
YK0KzORTbjYgfU5Yxwaw5mbFcxGvYNVSVp=s96-c
  2 | f     | benjamin_ye@ucsb.edu | t              | Ye         
 | Benjamin Ye  | Benjamin   | 108916786450195076889 | ucsb.edu  
    | en     | https://lh3.googleusercontent.com/a/ACg8ocKKJiZ8XZ
ZuIWUm5BvEnQ-Vg03XpK-PIncsuyPAScEH=s96-c
(2 rows)

courses_db=# 
```

To make it look less confusing, you can select out specifc field names separated by commas like this:

```
courses_db=# SELECT id, admin, email FROM users;
 id | admin |        email         
----+-------+----------------------
  1 | t     | phtcon@ucsb.edu
  2 | f     | benjamin_ye@ucsb.edu
(2 rows)

courses_db=# 
```

There are also commands you can use to create new rows (`INSERT`), modify existing rows (`UPDATE`) and destroy existing rows (`DELETE`); for details see the documentation of each at the links shown:
* [INSERT](https://www.w3schools.com/sql/sql_insert.asp)
* [UPDATE](https://www.w3schools.com/sql/sql_update.asp)
* [DELETE](https://www.w3schools.com/sql/sql_delete.asp)

You can also drop a table entirely with `DROP TABLE nameOfTable;` 

For a full treatement of SQL,see: <https://www.w3schools.com/sql/default.asp>

## More backslash commands

These backslash commands are seldom needed for CS156, but we provide them here for the rare occasions on which they are needed.

## `\l` lists the databases

Note that typically the database that you'll be using for the app is the one called `appname_db`, e.g. `team02_db`, `team03_db`, `courses_db`, `happycows_db` etc.
and that's typically the only database you need to concern yourself with.   When you use `dokku postgres:connect appname-db` that database is automatically
the default.   

```
courses_db=# \l
                                                 List of databases
    Name    |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Local
e Provider |   Access privileges   
------------+----------+----------+------------+------------+------------+------
-----------+-----------------------
 courses_db | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc 
           | 
 postgres   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc 
           | 
 template0  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc 
           | =c/postgres          +
            |          |          |            |            |            |      
           | postgres=CTc/postgres
 template1  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc 
           | =c/postgres          +
            |          |          |            |            |            |      
           | postgres=CTc/postgres
(4 rows)

courses_db=# 
```

## `\c dbname` connects to a specific database

After listing the databases with `\l` you can use `\c dbname` to connect to a specfic database.

## `\?` lists all available backslash commands

Example:

```
courses_db=# \?
General
  \copyright             show PostgreSQL usage and distribution terms
  \crosstabview [COLUMNS] execute query and display result in crosstab
  \errverbose            show most recent error message at maximum verbosity
  \g [(OPTIONS)] [FILE]  execute query (and send result to file or |pipe);
                         \g with no arguments is equivalent to a semicolon
  \gdesc                 describe result of query, without executing it
  \gexec                 execute query, then execute each value in its result
  \gset [PREFIX]         execute query and store result in psql variables
  \gx [(OPTIONS)] [FILE] as \g, but forces expanded output mode
  \q                     quit psql
  \watch [SEC]           execute query every SEC seconds

Help
  \? [commands]          show help on backslash commands
  \? options             show help on psql command-line options
  \? variables           show help on special variables
  \h [NAME]              help on syntax of SQL commands, * for all commands

... [Output truncated...]
```

For more information, see: <https://www.geeksforgeeks.org/postgresql-psql-commands/>
