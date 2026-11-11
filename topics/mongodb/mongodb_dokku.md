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




