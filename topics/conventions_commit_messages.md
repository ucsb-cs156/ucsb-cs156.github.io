---
parent: Topics
layout: default
title: "Conventions: Commit Messages"
description:  "How to make a commit message"
indent: true
category_prefix: "Conventions: "
---

For commit messages, we use these conventions:

# Initials at the start of your commit message: `pc - `

When *solo programming*, start the commit message with your initials, then a space and a hyphen, e.g.

```
ks - Renamed some controlIds for form components in CourseSearchCourseStartEndQtr.js.
lp - added table to the ge search and changed 'Ethnicities' to 'Ethnicity' in drop down menu
```

When pair programming, the initials of the person typing go first, then a slash, then initials of the pair partner:

```
lp/kp - added tests for GeCourseSearchForm
ab/hk - Added tests for lecture and sections days and times showing up properly
```

When mob programming (i.e. writing code with more than two people) you can either put everyone's initials, or you can just put `team`
if it's pretty much the entire team mob programming.  Examples:

```
sc/pc/md/al - add missing config variables to both localhost and heroku property files
sc/team - admins created automatically must be permanent admins
```
