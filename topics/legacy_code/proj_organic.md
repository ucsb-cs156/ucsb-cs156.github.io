---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Organic"
description:  "Project specific documentation"
---

Organic is a webapp that, when complete, will offer a replacement for the app <https://ucsb-cs-github-linker.herokuapp.com>.
The purpose of the app is to help instructors manage Github Organizations that are being used for programming and software development courses
(whether individual assignments, or group assignments.)

The former app provided many functions, but the following is the MVP:
* Login via Github OAuth for admins, instructors and students
* Admins can designate roles for users (admin, instructor, student)
* Instructors can create courses in the app, and associate each course with a github organization
* Instructors can upload a course roster for a course that associates an email address and student id with each student.
* Students can login and see a list of courses in progress.  They can click to join the course; if any of the emails associated
  with their Github account matches the email on the course roster, an invitation to the Github organization will be automatically
  generated.  They will be presented a link to that invitation which they can then accept.
* Once students have completed this procedure, instructors will be able to access a .csv file that associates students name, id, and email with their github id.

Future functionality for Organic (beyond MVP) that mirrors functions already present in the previous app:
* Instructors can create repos for individual assignments with a consistent naming convention
* Instructors can automatically create teams in Github from a CSV, and/or sync Organic's data on team membership from the teams on Github (two-way sync)
* Instructors can create repos for team assignments (and permissions are set appropriately automatically)
* Instructors can upload data on informed consent after a course is complete (which students opted in or opted out of making their data available for research studies)
* Instructors can download data about repos (commit messages, PRs, issues, etc); the data is marked with data about consent so that data can be filtered out if it is data 
  for non-consenting students, or teams that do not have 100% consent rates.
  
| Explanation | Link |
|-------------|------|
| Source code | <https://github.com/ucsb-cs156/proj-organic> |
| Production Deployment | <https://organic.dokku-00.cs.ucsb.edu> |
| QA Deployment (for CMPSC156 course staff) | <https://organic-qa.dokku-00.cs.ucsb.edu> |
