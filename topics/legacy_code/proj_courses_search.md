---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Courses Search"
description:  "Project specific documentation"
---


# MongoDB Collections

The Courses Search application uses a MongoDB collection as backup storage for the UCSB Curriculum information.

## Why MongoDB for UCSB Courses Search

While it might seem redundant to cache curriculum information in a separate database (vs. just going to the API each time), doing so provides several important advantages:

* It may be faster to get data from the MongoDB collection than from the UCSB API for some queries
* Some query types are not supported directly by the UCSB API; in particular, the UCSB API does not support searches across multiple quarters; it can
  only retrieve data for one quarter at a time.
* It provides a backup in case the UCSB API ever becomes unavailable temporarily or permanently.

In addition, it provides an opportunity to learn about how to work with a MongoDB database.

## The main collection

The main database in your MongoDB deployment should be called `database`, and the main collection should be called `courses`.

In addition, it is helpful to define some indexes on this collection.  Here's how.

