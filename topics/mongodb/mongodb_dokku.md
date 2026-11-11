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

The Mongo command line is very useful for:
* Debugging what's going wrong with reading/writing documents in a Mongo collection.
* Checking whether your code worked in cases where it might not be obvious from changes in the application's user interface.

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

## Find one document (any document)

Here's how to show one document in a collection, when you don't care which one (you just want to see what documents look like).

Use: <tt>db.<i>collection</i>.findOne()</tt>

```
courses_dev_ooiuut_mongo> db.courses.findOne()
{
  _id: ObjectId("6aed36653c9a790d310e64e5"),
  courseInfo: {
    quarter: '20221',
    courseId: 'CMPSC     5A -1',
    title: 'INTRO DATA SCI 1',
    description: 'Introduction to data science methods and Python programming language for st udents with little to no experience in the subjects. Topics include foundat ional programming concepts, problem-solving strategies and code design, and data science concepts as table operations, exploratory data analysis, basi c probability.',
    generalEducation: []
  },
  section: {
    enrollCode: '57109',
    section: '0100',
    enrolledTotal: 68,
    maxEnroll: 80,
    secondaryStatus: 'R',
    departmentApprovalRequired: false,
    instructorApprovalRequired: false,
    restrictionMajor: '-CMPSC',
    concurrentCourses: [],
    timeLocations: [
      {
        room: '1930',
        building: 'BUCHN',
        roomCapacity: '100',
        days: ' T R   ',
        beginTime: '11:00',
        endTime: '12:15'
      }
    ],
    instructors: [
      {
        instructor: 'SOLIS S W',
        functionCode: 'Teaching and in charge'
      }
    ]
  },
  _class: 'edu.ucsb.cs156.courses.documents.ConvertedSection'
}
courses_dev_ooiuut_mongo> 
```

## Narrowing your search

Suppose you want to find all documents that have the value `20221` in the `quarter` field inside `courseInfo`.

Here's how you do it:

```
courses_dev_ooiuut_mongo> db.courses.countDocuments({ "courseInfo.quarter": "20221" })
7211
courses_dev_ooiuut_mongo> 
```

And if you want to show one document that has `20271` as the quarter, you can do it like this:

```
courses_dev_ooiuut_mongo> db.courses.findOne({ "courseInfo.quarter": "20221" })
{
  _id: ObjectId("6aed36653c9a790d310e64e5"),
  courseInfo: {
    quarter: '20221',
    courseId: 'CMPSC     5A -1',
    title: 'INTRO DATA SCI 1',
    description: 'Introduction to data science methods and Python programming language for st udents with little to no experience in the subjects. Topics include foundat ional programming concepts, problem-solving strategies and code design, and data science concepts as table operations, exploratory data analysis, basi c probability.',
    generalEducation: []
  },
  section: {
    enrollCode: '57109',
    section: '0100',
    enrolledTotal: 68,
    maxEnroll: 80,
    secondaryStatus: 'R',
    departmentApprovalRequired: false,
    instructorApprovalRequired: false,
    restrictionMajor: '-CMPSC',
    concurrentCourses: [],
    timeLocations: [
      {
        room: '1930',
        building: 'BUCHN',
        roomCapacity: '100',
        days: ' T R   ',
        beginTime: '11:00',
        endTime: '12:15'
      }
    ],
    instructors: [
      {
        instructor: 'SOLIS S W',
        functionCode: 'Teaching and in charge'
      }
    ]
  },
  _class: 'edu.ucsb.cs156.courses.documents.ConvertedSection'
}
courses_dev_ooiuut_mongo> 
```

## Getting even more specific with the search

To find how many documents there are for `CMPSC` for `20271` you can do this:

```
courses_dev_ooiuut_mongo> db.courses.countDocuments({
...   "courseInfo.quarter": "20271",
...   "courseInfo.courseId": /^CMPSC/
... })
137
courses_dev_ooiuut_mongo> 
```

The syntax `/^CMPSC/` is regular expression syntax, where the `^` marks the start of the string.

## Showing just some fields of the documents


If we were to show all of the documents for `CMPSC` for `20271`, the output would be pages long.

But if we are only interested in the courseId field, we can do this:

```
courses_dev_ooiuut_mongo> db.courses.find(
...   { "courseInfo.quarter": "20271", "courseInfo.courseId": /^CMPSC/ },
...   { "courseInfo.courseId": 1, _id: 0 }
... )
[
  { courseInfo: { courseId: 'CMPSC     5A -1' } },
  { courseInfo: { courseId: 'CMPSC     5A -1' } },
  { courseInfo: { courseId: 'CMPSC     5A -1' } },
  { courseInfo: { courseId: 'CMPSC     5A -1' } },
  { courseInfo: { courseId: 'CMPSC     8  -1' } },
  { courseInfo: { courseId: 'CMPSC     8  -1' } },
  { courseInfo: { courseId: 'CMPSC     8  -1' } },
  { courseInfo: { courseId: 'CMPSC     8  -1' } },
  { courseInfo: { courseId: 'CMPSC     9  -1' } },
  { courseInfo: { courseId: 'CMPSC     9  -1' } },
  { courseInfo: { courseId: 'CMPSC     9  -1' } },
  { courseInfo: { courseId: 'CMPSC     9  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    16  -1' } },
  { courseInfo: { courseId: 'CMPSC    24  -1' } }
]
Type "it" for more
courses_dev_ooiuut_mongo> it
[
  { courseInfo: { courseId: 'CMPSC    24  -1' } },
  { courseInfo: { courseId: 'CMPSC    24  -1' } },
  { courseInfo: { courseId: 'CMPSC    24  -1' } },
  { courseInfo: { courseId: 'CMPSC    24  -1' } },
  { courseInfo: { courseId: 'CMPSC    24  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    32  -1' } },
  { courseInfo: { courseId: 'CMPSC    41  -1' } },
  { courseInfo: { courseId: 'CMPSC    41  -1' } },
  { courseInfo: { courseId: 'CMPSC    41  -1' } },
  { courseInfo: { courseId: 'CMPSC    41  -1' } },
  { courseInfo: { courseId: 'CMPSC    64  -1' } },
  { courseInfo: { courseId: 'CMPSC    64  -1' } },
  { courseInfo: { courseId: 'CMPSC    64  -1' } },
  { courseInfo: { courseId: 'CMPSC    64  -1' } },
  { courseInfo: { courseId: 'CMPSC    64  -1' } }
]
Type "it" for more
courses_dev_ooiuut_mongo> 
```

That second argument to find is a *projection*. It tells MongoDB which fields to return. It doesn’t change which documents match; the first argument decides that.

* `"courseInfo.courseId": 1` means include this field. The 1 is a flag meaning “yes” (true works too). Dot notation reaches into the nested courseInfo object, and the result keeps that nesting: { courseInfo: { courseId: ... } }.
* `_id: 0` means exclude _id. `_id` is returned by default even when you list other fields, so you have to turn it off explicitly. The `0` means “no” (`false` works too).

When you list fields with 1, only those fields (plus _id unless you exclude it) come back. Everything else is left out.

There are two ways to write a projection:

* Inclusion: `{ a: 1, b: 1 }` returns only a and b.
* Exclusion: `{ section: 0 }` returns everything except section.

You can’t mix the two in one projection, for example `{ a: 1, b: 0 }` is an error. The one exception is `_id: 0`, which you can add to an inclusion projection. That’s the pattern used here.

In the output above, we are getting multiple lines per course because of all of the sections.

To show that, we can include the section information: 

```
courses_dev_ooiuut_mongo> db.courses.find( { "courseInfo.quarter": "20271", "courseInfo.courseId": /^CMPSC/ }, { "courseInfo.courseId": 1, "section.section":1,  _id: 0 })
[
  {
    courseInfo: { courseId: 'CMPSC     5A -1' },
    section: { section: '0100' }
  },
  {
    courseInfo: { courseId: 'CMPSC     5A -1' },
    section: { section: '0101' }
  },
  {
    courseInfo: { courseId: 'CMPSC     5A -1' },
    section: { section: '0102' }
  },
  {
    courseInfo: { courseId: 'CMPSC     5A -1' },
    section: { section: '0103' }
  },
  {
    courseInfo: { courseId: 'CMPSC     8  -1' },
    section: { section: '0100' }
  },
  {
    courseInfo: { courseId: 'CMPSC     8  -1' },
    section: { section: '0101' }
  },
  {
    courseInfo: { courseId: 'CMPSC     8  -1' },
    section: { section: '0102' }
  },
  {
    courseInfo: { courseId: 'CMPSC     8  -1' },
    section: { section: '0103' }
  },
  {
    courseInfo: { courseId: 'CMPSC     9  -1' },
    section: { section: '0100' }
  },
  {
    courseInfo: { courseId: 'CMPSC     9  -1' },
    section: { section: '0101' }
  },
  {
    courseInfo: { courseId: 'CMPSC     9  -1' },
    section: { section: '0102' }
  },
  {
    courseInfo: { courseId: 'CMPSC     9  -1' },
    section: { section: '0103' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0100' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0101' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0102' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0103' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0104' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0105' }
  },
  {
    courseInfo: { courseId: 'CMPSC    16  -1' },
    section: { section: '0106' }
  },
  {
    courseInfo: { courseId: 'CMPSC    24  -1' },
    section: { section: '0100' }
  }
]
Type "it" for more
courses_dev_ooiuut_mongo> 
```

If we want just the course numbers, and we don't want duplicates, we can use `distinct` instead of `find`:

```
db.courses.distinct("courseInfo.courseId", {
...   "courseInfo.quarter": "20271",
...   "courseInfo.courseId": /^CMPSC/
... })
[
  'CMPSC     5A -1',  'CMPSC     8  -1',  'CMPSC     9  -1',
  'CMPSC    16  -1',  'CMPSC    24  -1',  'CMPSC    32  -1',
  'CMPSC    41  -1',  'CMPSC    64  -1',  'CMPSC    99  -1',
  'CMPSC   130A -1',  'CMPSC   130B -1',  'CMPSC   138  -1',
  'CMPSC   140  -1',  'CMPSC   148  -1',  'CMPSC   154  -1',
  'CMPSC   162  -1',  'CMPSC   165B -1',  'CMPSC   174A -1',
  'CMPSC   176A -1',  'CMPSC   178  -1',  'CMPSC   181  -1',
  'CMPSC   184  -1',  'CMPSC   186  -1',  'CMPSC   189B -1',
  'CMPSC   190N -1',  'CMPSC   192  -1',  'CMPSC   193  -1',
  'CMPSC   196  -1',  'CMPSC   196B -1',  'CMPSC   199  -1',
  'CMPSC   211B -1',  'CMPSC   216  -1',  'CMPSC   225  -1',
  'CMPSC   270  -1',  'CMPSC   281B -1',  'CMPSC   292A -1',
  'CMPSC   292G -1',  'CMPSC   293B -1',  'CMPSC   293G -1',
  'CMPSC   293S -1',  'CMPSC   493  -1',  'CMPSC   502  -1',
  'CMPSC   592  -1',  'CMPSC   595N -1',  'CMPSC   596  -1',
  'CMPSC   596  -10', 'CMPSC   596  -11', 'CMPSC   596  -12',
  'CMPSC   596  -13', 'CMPSC   596  -14', 'CMPSC   596  -15',
  'CMPSC   596  -16', 'CMPSC   596  -17', 'CMPSC   596  -18',
  'CMPSC   596  -19', 'CMPSC   596  -2',  'CMPSC   596  -20',
  'CMPSC   596  -21', 'CMPSC   596  -3',  'CMPSC   596  -4',
  'CMPSC   596  -5',  'CMPSC   596  -6',  'CMPSC   596  -7',
  'CMPSC   596  -8',  'CMPSC   596  -9',  'CMPSC   597  -1',
  'CMPSC   598  -1',  'CMPSC   599  -1'
]
courses_dev_ooiuut_mongo> 
```

Here the result is returned as Javascript array of strings.  We can assign it to a variable and use Javascript functions and methods on it.

This example shows storing the results in a variable called `results` then using `map` with a Javascript arrow function to convert
every item in the array to lowercase.

```
courses_dev_ooiuut_mongo> results = db.courses.distinct("courseInfo.courseId", { "courseInfo.quarter": "20271", "courseInfo.courseId": /^CMPSC/ })
[
  'CMPSC     5A -1',  'CMPSC     8  -1',  'CMPSC     9  -1',
  'CMPSC    16  -1',  'CMPSC    24  -1',  'CMPSC    32  -1',
  'CMPSC    41  -1',  'CMPSC    64  -1',  'CMPSC    99  -1',
  'CMPSC   130A -1',  'CMPSC   130B -1',  'CMPSC   138  -1',
  'CMPSC   140  -1',  'CMPSC   148  -1',  'CMPSC   154  -1',
  'CMPSC   162  -1',  'CMPSC   165B -1',  'CMPSC   174A -1',
  'CMPSC   176A -1',  'CMPSC   178  -1',  'CMPSC   181  -1',
  'CMPSC   184  -1',  'CMPSC   186  -1',  'CMPSC   189B -1',
  'CMPSC   190N -1',  'CMPSC   192  -1',  'CMPSC   193  -1',
  'CMPSC   196  -1',  'CMPSC   196B -1',  'CMPSC   199  -1',
  'CMPSC   211B -1',  'CMPSC   216  -1',  'CMPSC   225  -1',
  'CMPSC   270  -1',  'CMPSC   281B -1',  'CMPSC   292A -1',
  'CMPSC   292G -1',  'CMPSC   293B -1',  'CMPSC   293G -1',
  'CMPSC   293S -1',  'CMPSC   493  -1',  'CMPSC   502  -1',
  'CMPSC   592  -1',  'CMPSC   595N -1',  'CMPSC   596  -1',
  'CMPSC   596  -10', 'CMPSC   596  -11', 'CMPSC   596  -12',
  'CMPSC   596  -13', 'CMPSC   596  -14', 'CMPSC   596  -15',
  'CMPSC   596  -16', 'CMPSC   596  -17', 'CMPSC   596  -18',
  'CMPSC   596  -19', 'CMPSC   596  -2',  'CMPSC   596  -20',
  'CMPSC   596  -21', 'CMPSC   596  -3',  'CMPSC   596  -4',
  'CMPSC   596  -5',  'CMPSC   596  -6',  'CMPSC   596  -7',
  'CMPSC   596  -8',  'CMPSC   596  -9',  'CMPSC   597  -1',
  'CMPSC   598  -1',  'CMPSC   599  -1'
]
courses_dev_ooiuut_mongo> results.map(s => s.toLowerCase())
[
  'cmpsc     5a -1',  'cmpsc     8  -1',  'cmpsc     9  -1',
  'cmpsc    16  -1',  'cmpsc    24  -1',  'cmpsc    32  -1',
  'cmpsc    41  -1',  'cmpsc    64  -1',  'cmpsc    99  -1',
  'cmpsc   130a -1',  'cmpsc   130b -1',  'cmpsc   138  -1',
  'cmpsc   140  -1',  'cmpsc   148  -1',  'cmpsc   154  -1',
  'cmpsc   162  -1',  'cmpsc   165b -1',  'cmpsc   174a -1',
  'cmpsc   176a -1',  'cmpsc   178  -1',  'cmpsc   181  -1',
  'cmpsc   184  -1',  'cmpsc   186  -1',  'cmpsc   189b -1',
  'cmpsc   190n -1',  'cmpsc   192  -1',  'cmpsc   193  -1',
  'cmpsc   196  -1',  'cmpsc   196b -1',  'cmpsc   199  -1',
  'cmpsc   211b -1',  'cmpsc   216  -1',  'cmpsc   225  -1',
  'cmpsc   270  -1',  'cmpsc   281b -1',  'cmpsc   292a -1',
  'cmpsc   292g -1',  'cmpsc   293b -1',  'cmpsc   293g -1',
  'cmpsc   293s -1',  'cmpsc   493  -1',  'cmpsc   502  -1',
  'cmpsc   592  -1',  'cmpsc   595n -1',  'cmpsc   596  -1',
  'cmpsc   596  -10', 'cmpsc   596  -11', 'cmpsc   596  -12',
  'cmpsc   596  -13', 'cmpsc   596  -14', 'cmpsc   596  -15',
  'cmpsc   596  -16', 'cmpsc   596  -17', 'cmpsc   596  -18',
  'cmpsc   596  -19', 'cmpsc   596  -2',  'cmpsc   596  -20',
  'cmpsc   596  -21', 'cmpsc   596  -3',  'cmpsc   596  -4',
  'cmpsc   596  -5',  'cmpsc   596  -6',  'cmpsc   596  -7',
  'cmpsc   596  -8',  'cmpsc   596  -9',  'cmpsc   597  -1',
  'cmpsc   598  -1',  'cmpsc   599  -1'
]
courses_dev_ooiuut_mongo> 
```

Here's an example that returns just the first 13 characters of each string:

```
courses_dev_ooiuut_mongo> results.map(s => s.substring(0, 13).trim())
[
  'CMPSC     5A', 'CMPSC     8',  'CMPSC     9',  'CMPSC    16',
  'CMPSC    24',  'CMPSC    32',  'CMPSC    41',  'CMPSC    64',
  'CMPSC    99',  'CMPSC   130A', 'CMPSC   130B', 'CMPSC   138',
  'CMPSC   140',  'CMPSC   148',  'CMPSC   154',  'CMPSC   162',
  'CMPSC   165B', 'CMPSC   174A', 'CMPSC   176A', 'CMPSC   178',
  'CMPSC   181',  'CMPSC   184',  'CMPSC   186',  'CMPSC   189B',
  'CMPSC   190N', 'CMPSC   192',  'CMPSC   193',  'CMPSC   196',
  'CMPSC   196B', 'CMPSC   199',  'CMPSC   211B', 'CMPSC   216',
  'CMPSC   225',  'CMPSC   270',  'CMPSC   281B', 'CMPSC   292A',
  'CMPSC   292G', 'CMPSC   293B', 'CMPSC   293G', 'CMPSC   293S',
  'CMPSC   493',  'CMPSC   502',  'CMPSC   592',  'CMPSC   595N',
  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',
  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',
  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',
  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',
  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',  'CMPSC   596',
  'CMPSC   596',  'CMPSC   597',  'CMPSC   598',  'CMPSC   599'
]
courses_dev_ooiuut_mongo> 
```

There are many more things you can do with the Mongo Shell.  You can
look up the documentation, or use an LLM to ask the syntax to accomplish 
various tasks.

