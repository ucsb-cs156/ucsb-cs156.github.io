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




