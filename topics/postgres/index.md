---
parent: Topics
layout: default
title: "Postgres"
description:  "An SQL database"
---

# {{page.title}} -- {{page.description}}

Postgres is an SQL database that is production ready (supports concurrency and realistic loads).

We typically use:
* H2, a different SQL database on localhost
* Postgres on dokku

## Why H2 on localhost and Postgres on dokku?

The reason we use H2 on localhost is:
* H2 is fully embedded inside the Spring Boot libraries
* Therefore, you don't have to manually download and install anything on your laptop to use it.
* Using Postgres on localhost would require a whole separate download and configuration step

## Why Postgres on dokku and not H2

H2 isn't designed to handle the loads of a realistic application deployment.  It's a lightweight implementation
that uses either an in memory database, or a single file on the file system.

Postgres is designed to handle the loads of a realistic application deployment.


