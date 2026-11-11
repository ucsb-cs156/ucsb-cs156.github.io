---
parent: MongoDB
grand_parent: Topics
layout: default
title: "MongoDB: Brutally Short Intro"
description:  "If you have never heard of MongoDB or NoSQL databases before"
---

 
# A brutally short intro to MongoDB

This article tries to answer these questions?

* What is MongoDB
* Why would I want or need to use it instead of SQL tables (i.e. H2 / Postgres)
* What do I need to know to get started?


## What is MongoDB

MongoDB is a popular "NoSQL" database.  The easiest way to think of it is as a way to store JSON objects in the cloud.

## Why would I want/need MongoDB instead of SQL tables

If you already have the ability to create database tables based on the relational database model (e.g. with an SQL-based database such as H2/Postgres,
as illustrated with the `@Entity` and `@Repository` annotations in the example Spring projects in CMPSC 156, you may wonder why a MongoDB database is
used in some cases.  

It isn't just because "it's another cool technology to learn that might be useful in a future job", though that is also true.   Rather, it's because
MongoDB is the "right tool for the job" for a particular use case that arises in some of our applications; a use case where an SQL table *could* be used,
but would be much more challenging, time-consuming, and error prone.

That use case is when the data we want to work with is already in JSON form, such as this example of a data about a course retrieved from the [UCSB Developer API](https://developer.ucsb.edu):

(Note: the original object is much larger; I've removed some fields that don't add anything to the explanation, and the original had four elements in the sections
array.)

```json
{
  "quarter": "20232",
  "courseId": "CMPSC   156  ",
  "title": "ADV APP PROGRAM",
  "description": "Advanced application programming using a high-level, virtual-machine-based language. Topics include generic programming, exception handling, automatic memory management, and application development, management, and maintenanc e tools, third-party library use, version control, software testing, issue tracking, code review, and working with legacy code.",
  "unitsFixed": 4,
  "classSections": [
    {
      "enrollCode": "07419",
      "section": "0100",
      "enrolledTotal": 72,
      "maxEnroll": 72,
      "timeLocations": [
        {
          "room": "1431",
          "building": "SH",
          "roomCapacity": 76,
          "days": " T R   ",
          "beginTime": "14:00",
          "endTime": "15:15"
        }
      ],
      "instructors": [
        {
          "instructor": "CONRAD P T",
          "functionCode": "Teaching and in charge"
        }
      ]
    },
    {
      "enrollCode": "07427",
      "section": "0101",
      "enrolledTotal": 24,
      "maxEnroll": 24,
      "timeLocations": [
        {
          "room": "3525",
          "building": "PHELP",
          "roomCapacity": null,
          "days": "  W    ",
          "beginTime": "17:00",
          "endTime": "17:50"
        }
      ],
      "instructors": [
        {
          "instructor": "DE A",
          "functionCode": "Teaching but not in charge"
        },
        {
          "instructor": "ROSS V E",
          "functionCode": "Teaching but not in charge"
        }
      ]
    },
  ]
}
```

As you can see, the overall shape of the JSON is that:
* At the top level, there is an object with some keys and values.  If we only needed to store the first four values, that could easily be done with a row in an SQL database table.
* But then we encounter an array of sections.  In a relational database, that would require a separate table, and a "join" relationship where we associate the sections
  with the top level course record.  We'd have to manage the keys properly to get the correct relationship.
* Then, it gets worse.  Each section can have multiple times/locations, and multiple instructors.  That means a third and fourth table, and managing all of *those* keys.

By contrast, with MongoDB, we can just store this entire object, *as is* as a single object, what MongoDB calls a *document*.


## Basic Terminology

First, some basic terminology:

* What we call a "table" in an SQL database is called a "collection" in a MongoDB database.
* What we call a "row" in a table in called a "document" in an MongoDB database.

But, unlike a row that has specific fields (columns), 
a document in a MongoDB database is essentially a JSON object stored in the cloud; 
thus it can have arbitrarily deep nested structure.


Also, note the following hierarchy.  Each level in the hierachy can have
multiple items at the next level down, i.e. an organization can have many projects, a project can have many databases,
a database can have many collections, and a collection can have many documents.

* Database (e.g. `database01`)
  * Collection (e.g. `reddit_posts`)
    * Document (e.g. the JSON representation of a specific reddit post, e.g. )


# What do I need to know to get started?

The basic unit of data in MongoDB is a *document*.  A document is any JSON value, which can be as simple as a scalar value (e.g. `true`, `Michelle`, `24`),
or an array, or a deeply nested JSON object.

Documents are grouped into what are known as *Collections*.

It's not a requirement, but a typical good practice is that all documents in a particular store documents with the same json "shape" (i.e. the same
keys, and same nesting structure, sometimes called a JSON *schema*.

# Where can I learn more?

There's lots more to learn about MongoDB.  Here are some resources:
* <https://ucsb-cs156.github.io/topics/mongodb/>
* W3 Schools MongoDB tutorial (shorter): <https://www.w3schools.com/mongodb/>
* MongoDB online course (longer): <https://learn.mongodb.com/learning-paths/introduction-to-mongodb>


# Javadoc

* [MongoDB 3.7 Javadoc](http://mongodb.github.io/mongo-java-driver/3.7/javadoc/)

A particularly useful page is this one:
* <http://mongodb.github.io/mongo-java-driver/3.7/javadoc/com/mongodb/client/MongoCollection.html>

