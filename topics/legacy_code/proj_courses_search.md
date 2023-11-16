---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Courses Search"
description:  "Project specific documentation"
---

# {{page.title}}

Courses search is intended as an application that provides a more functional version of the official public
facing course search app available at the address: <https://my.sa.ucsb.edu/public/curriculum/coursesearch.aspx>

Our version, currently deployed at <https://courses.dokku-00.cs.ucsb.edu> provides many more features:

For example:
* Search by instructor (What courses has Diba Mirza taught?)
* Search by course over a range of quarters (Who has taught CMPSC 130A over time?)
* and many more

## UCSB_API_KEY values

To deploy proj-courses, in addition to the usual GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET needed for other OAuth apps
in this course, you will also need a value for UCSB_API_KEY.  This is a key that gives you access to the API for UCSB course information.  These keys are obtained from the website <https://developer.ucsb.edu>.

You can request your own account, but it is typically faster to get one from the instructor, who will provide it to you on your
team slack channel.

## MongoDB Collections

The Courses Search application uses a MongoDB collection as backup storage for the UCSB Curriculum information, so you will also 
need to set up a MongoDB collection and put the URL for that collection in your environment variables.  Read on for more explanation.

## Why MongoDB for UCSB Courses Search

While it might seem redundant to cache curriculum information in a separate database (vs. just going to the API each time), doing so provides several important advantages:

* It may be faster to get data from the MongoDB collection than from the UCSB API for some queries
* Some query types are not supported directly by the UCSB API; in particular, the UCSB API does not support searches across multiple quarters; it can
  only retrieve data for one quarter at a time.
* It provides a backup in case the UCSB API ever becomes unavailable temporarily or permanently.

In addition, it provides an opportunity to learn about how to work with a MongoDB database.

## The main collection

The main database in your MongoDB deployment should be called `database`, and the main collection should be called `courses`.

You can do queries like as shown below.  This is a query that finds all records for quarter `20231` (Winter 2023) and the enroll code `07443`. 

```
{ 'courseInfo.quarter' : '20231', 'section.enrollCode' : '07443' }
```

<img width="967" alt="image" src="https://user-images.githubusercontent.com/1119017/203236404-32c67f00-11b7-46ae-8c98-d1b6f27548ce.png">

As we can see here, this brings up two records; this is the result of loading the data for this quarter twice without first defining an index to prevent duplicates (as illustrated below).


## Avoiding Duplicate Data

To avoid duplicate data, it is helpful to define an indexes that prevents storing multiple documents with the same quarter and enroll code.  Here's how.

First, we want to ensure that the combination of `courseInfo.quarter` (e.g. "20231") and `section.enrollCode` (e.g. `07443`) is unique, so that we don't end up storing duplicate data.  We can do that by defining an index like this:

Go to the index tab (second over in MongoDB.com collections page):

<img width="977" alt="image" src="https://user-images.githubusercontent.com/1119017/203235608-4ba7d26b-65c2-4042-800f-b303fcc920ae.png">

Click the `Create Index` button at right: 

<img width="126" alt="image" src="https://user-images.githubusercontent.com/1119017/203235693-e4e97ab5-b9fd-4a4c-adcd-a40c460edc3c.png">

That brings up this modal: 

<img width="714" alt="image" src="https://user-images.githubusercontent.com/1119017/203235761-c7918199-2af8-481e-b529-97351301de54.png">

Fill in `Fields` with:

```
{
  "courseInfo.quarter": 1,
  "section.enrollCode" : 1
}
```

Then fill in options with:

```
{unique:true}
```

So that it looks like this:

<img width="701" alt="image" src="https://user-images.githubusercontent.com/1119017/203236005-98152214-4f72-435f-9344-c5f43a7a95a5.png">


Then click "Review".

Note that if you already have duplicate data, adding this constraint will not eliminate those. You may need to drop the collection and recreate it with the constraint in place (i.e. add the constraint before you start adding data.)

# Querying Data in MongoDB

The animation below shows how to do some basic queries in MongoDB.

A few tips:
* Use single quotes, not double quotes.
* Query by simply listing the keys (using dot notation for nested fields) and the values those fields should have.
* Examples:

  ```
  { 'courseInfo.quarter' : '20231'}
  ```

  ```
  { 'courseInfo.quarter' : '20231', 'courseInfo.title': 'INTRO DATA SCI 1' }
  ```
  
  
  ```
  { 'courseInfo.quarter' : '20231', 'courseInfo.title': 'INTRO DATA SCI 1' , 'section.enrollCode' : '07443'}
  ```

  


![see-mongodb-data](https://user-images.githubusercontent.com/1119017/203417526-acb3ebab-3669-4940-a434-5e3953022541.gif)

# Queries with regex

You can use regular expressions to match course ids that start with a certain subject area.  For example, this will find courses
in quarter `20231` where the `courseInfo.courseId` field starts with `MATH`:

```
{ 'courseInfo.quarter' : '20231', 'courseInfo.courseId': { $regex: /MATH/ }}
```
