---
parent: "Spring Boot"
grand_parent: Topics
layout: default
title: "Spring Boot: Postgres"
description:  "Using Spring Boot with Postgres"
category_prefix: "Spring Boot: "
indent: true
---

# What is Postgres

There are many SQL based database systems.   *Postgres* is one particular implementation (MySQL, SQLite, and Oracle, being three others, with H2 being a commonly used
"in memory" only database.)

# Why use Postgres?

The main reason we prefer Postgres in CMPSC 56 is that it comes for free with the free tier of Heroku, and is automatically provisioned.

No other database system comes in the free tier and is so easy to provision.

# What are Hibernate, JPA, JDBC

Hibernate, JPA and JDBC are parts of the "middleware" that connect your Spring Boot application to 
a relational database.   A deeper discussion is beyond the scope of this short article, but is is helpful
to at least have that context, so that if/when you run into problems, you are aware that searches
that include these keywords may be relevant.

# Postgres Spring Boot Tutorials

* <https://dzone.com/articles/bounty-spring-boot-and-postgresql-database>
* <http://blog.michalszalkowski.com/java/spring-boot-switch-from-h2-to-postgresql/>
* <http://clouddatafacts.com/heroku/heroku-spring-boot-psql/spring_boot_psql_short.html#clone-the-source-code/>


# Trouble connecting to Postgres on Heroku

If you were successful at connecting to Postgres on localhost, but then have trouble when running on Heroku:

1. Check that you actually provisioned the "Heroku Postgres Add-On" for your application.

   If you did, then on the "Settings" tab of the dashboard of your app, when you click on 
   "Reveal&nbsp;Config&nbsp;Vars", you should see a value for `DATABASE_URL` such as this one (fictional and shortened):
   
   ```
   postgres://usowuzp:2a805d7c9d@ec2-174-129-252-226.compute-1.amazonaws.com:5432/ll05td
   ```
   
   If you don't see this then see item 2 below for how to provision the database.
   
2. If you don't see the Heroku Postgres Add on, then under the "Resources" tab, go to the search bar for Add-Ons, and type in Postgres.  Heroku Postgres should come up as an option.  Select it, and click to provision it at the "Hobby/Dev" level (the Free tier.)


3. In the `src/main/resources/application.properties` file, you should see the following:

```
spring.datasource.url=${JDBC_DATABASE_URL}
spring.datasource.username=${JDBC_DATABASE_USERNAME}
spring.datasource.password=${JDBC_DATABASE_PASSWORD}
```

Note that as explained in the [Heroku Documentation on connecting to JDBC Databases from Heroku](https://devcenter.heroku.com/articles/connecting-to-relational-databases-on-heroku-with-java#using-the-jdbc_database_url-in-a-spring-boot-app) the `JDBC_DATABASE_URL`, `JDBC_DATABASE_USERNAME`, and `JDBC_DATABASE_PASSWORD` are defined from the values in the `DATABASE_URL` whenever the Heroku "Dyno" (server) starts up whenever Heroku detects a Java Application.


# Disabling contexutal LOB exception

The following error sometimes occurs when using relational databases with Hibernate.

```
Disabling contextual LOB creation as createClob() method threw error : 
java.lang.reflect.InvocationTargetException
```

The following article explains that this error is usually harmless, and how to supress the exception message by
a line of configuration in your `applicaion.properties`:

* <https://stackoverflow.com/questions/4588755/disabling-contextual-lob-creation-as-createclob-method-threw-error>
