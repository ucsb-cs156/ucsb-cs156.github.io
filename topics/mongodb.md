---
parent: Topics
layout: default
title: "MongoDB: "
description:  "A particular NoSQL database platform"
category_prefix	: "MongoDB: "
---

* [MongoDB Javadoc](http://mongodb.github.io/mongo-java-driver/3.6/javadoc/)

MongoDB is a particular implementation of a technology known as NoSQL databases.

The basic idea is that you can store JSON objects in the cloud.   
Everything else is just sort of a riff on that theme.

To get started with MongoDB, I recommend this sequence of articles:

* [mongodb_new_database](https://ucsb-cs156.github.io/topics/mongodb_new_database) Setting up an account and a new database
* [mongodb_spring_boot_basic_collection](https://ucsb-cs156.github.io/topics/mongodb_spring_boot_basic_collection/) Setting up a simple collection in a Spring Boot application, i.e. one that has a flat structure of attributes (just one top level object per document, rather than one with nested objects).
* [mongodb_spring_boot_nested_collection](https://ucsb-cs156.github.io/topics/mongodb_spring_boot_nested_collection/) Setting up a collection in Spring Boot that has nested objects and/or arrays/lists.


# Javadoc

* <http://mongodb.github.io/mongo-java-driver/3.7/javadoc/com/mongodb/client/MongoCollection.html>


# Obsolete materials

The following materials are likely obsolete; they refer to mlab, which is a now defunct platform providing a MongoDB compatible database:

They are included only in case they are useful to update to current platforms at some point in the future.

Here is a repo that demos MLab in the context of a Spring Boot application:
* <https://github.com/pconrad-webapps/simple-java-mlab-demo>

There is a lot of info about MongoDB at this other website: <http://pconrad-webapps.github.io/topics/mongodb/>
* In particular, this page about Java stuff: <http://pconrad-webapps.github.io/topics/mongodb_java/>
* It also discusses how to get started with [MLab](http://pconrad-webapps.github.io/topics/mongodb_mlab/) which is a particular provider of MongoDB (e.g. Mlab is to MongoDB like github is to git)
