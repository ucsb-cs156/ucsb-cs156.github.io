---
parent: MongoDB
grand_parent: Topics
layout: default
title: "MongoDB: Dokku"
description:  "How to deploy a MongoDB database on Dokku, and connect to it"
---


# {{page.title}} - {{page.description}}

## Managing Mongo Deployments on Dokku

We create and manage deployments of MongoDB in much the same as we create and manage deployments for our Postgres databases. 

This table compares the commands:

| Task | Postgres Command | MongoDB Command |
|-|-|-|
| Create a database | `dokku postgres:create myapp-db` | `dokku mongo:create myapp-m` |
| Link database to app | `dokku postgres:link myapp-db myapp` | `dokku mongo:link myapp-m myapp` |
| Connect to database command line tool | `dokku postgres:connect myapp-db` | `dokku mongo:connect myapp-m` |
| List all databases | `dokku postgres:list` | `dokku mongo:list` |


## Mongo Command Line

Here is an example of how to access and use the mongo command line.

First, make sure you know the name of your mongo deployment.  You can use `dokku mongo:list` to show the names:

```
pconrad@dokku-02:~$ dokku mongo:list
=====> MongoDB services
courses-dev-ekuchhal-m-db
courses-dev-matthewvnguyen110-m-db
courses-dev-ooiuut-mongo
courses-dev-timothyhu1-m-db
courses-dev-zsjkwon-m-db
courses-dev1-zsjkwon-m-db
pconrad@dokku-02:~$ 
```

Once you identify your mongo deployment (for example, suppose it is `courses-dev-ooiuut-mongo`), use the command:

```
dokku mongo:connect courses-dev-ooiuut-mongo
```

Here's what that looks like:

```
pconrad@dokku-02:~$ dokku mongo:connect courses-dev-ooiuut-mongo
Current Mongosh Log ID:	6af4f18324d06f73c38a906b
Connecting to:		mongodb://<credentials>@127.0.0.1:27017/courses_dev_ooiuut_mongo?directConnection=true&serverSelectionTimeoutMS=2000&authSource=courses_dev_ooiuut_mongo&appName=mongosh+1.10.1
Using MongoDB:		6.0.7
Using Mongosh:		1.10.1

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

courses_dev_ooiuut_mongo> 
```

Now you have a prompt where you can enter Mongo Shell commands.

## How to exit: `exit`

First things first: to exit, type `exit`:

```
courses_dev_ooiuut_mongo> exit
pconrad@dokku-02:~$ 
```


## `show collections`

Use `show collections` to see what collections you have:

```
courses_dev_ooiuut_mongo> show collections
courses
updates
courses_dev_ooiuut_mongo> 
```

## Counts of documents

Use: <tt>db.<i>collection</i>.countDocuments({})</tt>

```
courses_dev_ooiuut_mongo> db.courses.countDocuments({})
124310
courses_dev_ooiuut_mongo> db.updates.countDocuments({})
4104
courses_dev_ooiuut_mongo> 
```
