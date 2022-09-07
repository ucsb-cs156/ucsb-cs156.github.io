---
parent: Topics
layout: default
title: Databases
description:  "SQL, Postgres, H2, etc"
category_prefix: "Databases: "
---

In CS56 Spring Boot projects, we use:
* H2 in-memory database when running on localhost
* Postgres database when running on Heroku

# H2 Console Access

A console is enabled at `/h2-console` when running with H2.  However, to be able to access it in applications with logins enabled,
you may have to do some configuration.

Here is an article that may help: 
* <https://www.logicbig.com/tutorials/spring-framework/spring-boot/jdbc-security-with-h2-console.html>
