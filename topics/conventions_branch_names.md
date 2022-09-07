---
parent: Topics
layout: default
title: "Conventions: Branch Names"
description:  "How to name your branches"
indent: true
category_prefix: "Conventions: "
---

# Default Branch is `main`

The default branch for all projects in CMPSC 156 is `main`.  

Some older code bases created prior to the GitHub switch from `master` to
`main` might still be using `master`; we'll phase that out over time.

# Feature Branches

For feature branches on teams, use the team name as the prefix for the branch, e.g. `5pm-a`, `6pm-c`, etc. followed by either a `kebob-case` or `camelCase` summary
of what feature or bugfix is being implemented on the branch:

Examples:

```
5pm-a-search-by-course-name
5pm-a-search-by-ge
5pm-b-CreateMenuItemPersonalSchedule
5pm-b-backend-schedule
5pm-b-frontend-schedule-crud-operations
5pm-b-schedule-crud-operations
5pm-b-schedule-crud-operations-frontend
5pm-c-AvgClassSizeByDept
5pm-c-courseOccupancyByDivision
5pm-c-numFullCoursesByDept
5pm-d-AddBasicCoursesTable
5pm-d-AddCourseButton
5pm-d-AddSectionsDaysAndTimes
```

For branches created by the course staff (instructor, TAs, LAs) use `staff-` followed by the quarter as the prefix.  Examples:

```
staff-f20-addArchivedCourseRepo
staff-f20-fixCodeCovBadgeInREADME
staff-f20-refactorBasicCourseSearch
```
