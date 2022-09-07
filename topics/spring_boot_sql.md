---
parent: Topics
layout: default
title: "Spring Boot: SQL"
description:  "Working with SQL and Databases in Spring Boot"
category_prefix: "Spring Boot: "
indent: true
---

# Debugging Help

When working with SQL-based databases in Spring Boot, it is helpful to put the following line in your `application.properties`:

```
logging.level.org.hibernate.SQL=debug
```

This will output the SQL statements to the log so that you can see what is going on.  This is particularly useful when the 
various middleware layers are doing the SQL statements for you, and for example, you aren't even entirely sure what the names of the 
SQL tables are.


# Initial Values in Database

You can seed your database with some initial values.  This can be helpful especially during development and debugging phases.

The file `data.sql` can be placed in `src/main/resources` and has a syntax like this:

```
INSERT INTO course_offering (course,quarter,instructor) VALUES ('CMPSC 56','F19','Conrad');
INSERT INTO tutor (fname,lname,email) VALUES ('Scott','Chow','scottpchow@ucsb.edu');
```

