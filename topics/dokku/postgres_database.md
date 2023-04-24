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
dokku postgres:link my-new-app my-new-app-db
```

* The command `dokku postgres:create my-new-app-db` creates the database. While it is not required that the name be the app name with `-db` appended, we encourage following  this naming convention (or a similar one) to reduce confusion.
* The command  `dokku postgres:link my-new-app my-new-app-db` links the app to the database

Here's an example:

<img width="691" alt="output from dokku postgres:create my-new-app-db" src="https://user-images.githubusercontent.com/1119017/234112263-1f541242-1a4d-41e9-8f35-48d65b1cf9be.png">

<img width="693" alt="output from dokku postgres:link my-new-app my-new-app-db" src="https://user-images.githubusercontent.com/1119017/234112369-e3485fa8-c47e-49b5-8d7b-3b319221b7f1.png">


