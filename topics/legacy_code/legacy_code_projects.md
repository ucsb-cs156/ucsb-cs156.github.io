---
parent: Legacy Code
grand_parent: Topics
layout: default
title: "Legacy Code: Projects"
description:  "A list of legacy code projects associated with this course"
---

# Legacy code project under current active devlopment

All are implemented as web apps using the [Spring/React](/topics/spring_react/) stack with Google OAuth login.

* Courses
  - Provides various ways to search data related to courses offered at UC Santa Barbara
  - <https://github.com/ucsb-cs156/proj-courses>
* Happy Cows
  - Simulation game to explore the "Tragedy of the Commons", used in CHEM 123 (Environmental Chemistry) at UC Santa Barbara
  - <https://github.com/ucsb-cs156/proj-courses>
* Gauchoride
  - When it goes live, this app will allow UC Santa Barbara students that qualify for transportation assistance due to physical disabilities to reserve rides on golf carts provided by
    the Division of Student Affairs.
    The program is coordinated by the [Office of Veterans and Military Services](https://veterans.sa.ucsb.edu/), however students do not need to be
    Veterans or have a connection to the US Military to be eligible; eligibility is determined in coorination with the [Disabled Students Program](https://dsp.sa.ucsb.edu/).
  - <https://github.com/ucsb-cs156/proj-courses>

# Possible future applications

## Replacement for ucsb-cs-github-linker

This project involves constructing a Minimum Viable Product  (MVP) for a replacement to the ucsb-cs-github-linker app (currently in Ruby on Rails) in Spring/React (the CMPSC 156 tech stack).

Currently, the ucsb-cs-github-linker is used in a variety of courses at UCSB.  However, the code base is difficult to maintain, because few students know
Ruby on Rails.  It is very hard to onboard new students to this tech stack (it can take two weeks just to on board someone 
to the point of being able to run the application in dev mode).    

If we could build an MVP using the Spring Boot / React stack, then the CMPSC 156 class could maintain the app going forward.  This would provide
a valuable example of a real app with real users for the course.

The main features are (this is a brutally summarized outline of an MVP):

* Login with Github OAuth instead of Google OAuth.
* Admins can assign roles: default role is student, but also Instructor, TA/LA, Admin.
* CRUD operations for courses
* CSV upload and interactive CRUD for roster students associated with courses
* Workflow to "join a course" and generate invitation to course organization.

There are many features beyond that list that could be added next, some of which are in the current Ruby on Rails app:

For instructors:
* Automatically setting up teams based on CSV file 
* Automatically setting up repos for assignments on individual or team level
* Gathering information/statistics about these repos
 
For researchers:

* Ability to subscribe to and process GitHub event triggers
* Ability to connect GitHub event triggers to Slack events
* Abiity to gather commit, PR, timeline event information 

