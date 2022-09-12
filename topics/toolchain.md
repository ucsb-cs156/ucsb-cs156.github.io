---
parent: Topics
layout: default
title: "Toolchain"
description:  "The set of tools you need for software dev in CS56"
---


# {{page.title}}

## What is a toolchain?

According to Wikipedia: "In software, a toolchain is a set of programming tools that 
is used to perform a complex software development task or to create a software product, 
which is typically another computer program or a set of related programs."

The Toolchain we'll use in CS56 includes:

General Tools:
* The `VS Code` editor
* git and GitHub

Backend Tools:
* Java 17 (the `javac` and `java` commands, plus others that come with the OpenJDK 17 Java Deveopment Kit)
* Maven (the `mvn` command)
* Git (the `git` command)
* Testing tools: JUnit, Jacoco, Pitest
* Swagger: documentation/testing/prototyping for backend RESTful APIs

Frontend Tools:
* npm (node pacakge manager)
* React
* Storybook: documentation/testing/prototyping for frontend components
* Testing tools: jest, Stryker-js

Database Tools:
* Postgres: SQL-based database
* H2: In memory SQL-based database for testing
* Liquibase: Database migrations
* MongoDB: NoSQL database

Also may be useful:
* Spring CLI (Downloaded from <https://repo.spring.io/snapshot/org/springframework/boot/spring-boot-cli>
