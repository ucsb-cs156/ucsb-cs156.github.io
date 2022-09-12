---
parent: SQL
grand_parent: Topics
layout: default
title: "SQL: Postgres"
description:  "An implementation of an SQL relational database, available on Heroku"
---

# {{page.title}}

Postgres is a particular implementation of an SQL-based relational database.

It is available on the free tier of Heroku, which is why we tend to use it for our database applications in this course.

This article isn't (yet) a complete introduction to Postgres; instead it's a collection of tips and notes that we've found useful in dealing
with Postgres databases on Heroku, and with Spring Boot Java webapps.

# Postgres Heroku tips

On the free tier of Heroku, you are permitted only up to 10,000 rows total across *all tables* in your database.

You can monitor how close you are getting with:

```
heroku pg:info --app APP
```

# Dumping a Heroku Postgres database

You can dump the contents of a postgres database on Heroku to a special binary format used by the `pgdump` tool.

This is documented here: <https://devcenter.heroku.com/articles/heroku-postgres-import-export>, but
* NOTE that you may need the `--app APP` suffix on the commands such as `heroku pg:backups:capture`

The file that is downloaded is called `latest.dump`, and it's in an ideosyncratic binary format.

That can be converted to a text `.sql` file with the process documented here: <https://stackoverflow.com/questions/21429335/how-do-i-convert-a-binary-pgdump-compressed-to-a-plain-sql-file>

For example:

```
pg_restore -f latest.sql latest.dump 
```

That requires you to have postgres installed on your local machine so that you have the `pg_restore` command available.


