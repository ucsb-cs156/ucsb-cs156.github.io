---
parent: Topics
layout: default
title: "Conventions: Tags"
description:  "Tags (only for course staff)"
indent: true
category_prefix: "Conventions: "
---

# This page is only for course staff

We are using tags/versions/releases as a way to manage the long term development of the legacy code projects.

Accordingly, adding tags/versions/releases should be done only by course staff.

Students may be interested, though, to know how this works in case they want to incorporate a similar strategy into their own
independent projects outside the scope of this course.

# Convention for tags

For tags, we follow the conventions of semantic versioning, except that:

* We increase the major version once at the start of student work on each quarter, and at the end of student work for that quarter.
  
  Examples:
  - v1.0.0 is the start of student work for F20
  - v2.0.0 is the end of student work for F20, i.e. before any "between quarter maintenance" by course staff.
  - v3.0.0 will be the start of student work for W21
  - v4.0.0 will be the end of student work for W21.
  
  Thus, odd numbered major versions are the start of student work for a quarter, and even numbered major versions are the end of 
  student work for a quarter.

  This allows us to track student work, in contradistinction to work done by course staff.
 
# Mechanics

Adding a tag:

```
git tag -a v1.0.0 -m "F20 starting point, before student work"
git push origin v1.0.0
```
