---
parent: Topics
layout: default
title: SQL
description:  "SQL-based relational databases (sqlite3, Postgres, MySQL, etc.)"
category_prefix: "SQL: "
has_children: true
---

# {{page.title}}

Currently, the commonly used techniques for storing persistent data are:

* SQL based databases, e.g. sqlite3, Postgres, MySQL
* NoSQL datastores, such as MongoDB, CouchDB, Aerospike, Cassandra, Couchbase, and Voldemort

This article (and series of subarticles) deals with SQL based databases, and how to access those from Java code.

## In CMPSC 156, we use Postgres

Why Postgres (instead of sqlite3, MYSQL, for example)?

* Historically, when Heroku had a free tier, it included convenient automatic
  deployment of Postgres databases.  This is the main reason.
* The rationale is not as strong now, but it can be tedious and error prone
  to switch database technologies; even though, in principle, SQL is standard
  across all of these platforms, there are nevertheless small incompatibilities, and each requires it's own separate "driver" to connect.

## Related topics:

* [liquibase](liquibase): A database migration technology
* 