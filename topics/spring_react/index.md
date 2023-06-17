---
parent: Topics
layout: default
title: "Spring/React"
description:  "The basic framework for CMPSC 156 projects (From F20 forward)"
category_prefix: "Spring React: "
has_children: true
---

The basic framework for web applications in CMPSC 156 from F20 forward is a particular way of combining:
* A Spring Boot backend
* A React frontend

The code bases that serve as the base for legacy code apps in CMPSC 156 provide many affordances, and examples:
* Users can login with Google OAuth
* Roles can be defined including generic roles such as User, Admin, and custom roles such as Driver and Rider
* Data can be stored in either SQL based Postgres relational database tables, or MongoDB no-SQL collections
* There are many examples of frontend forms and tables for CRUD operations
* Asynchronous batch processing (background jobs) can be performed on demand or on a fixed schedule (with cron syntax)
* There is support for Swagger for documenting and testing Restful API endpoints (so that backend endpoints can be tested independently of the frontend)
* There is a CI/CD pipeline for Storybook for documenting React components (so that they can be tested independently of the backend)
* There is a CI/CD pipeline for unit testing (with code coverage and mutation test coverage) of both frontend Javascript and backend Java code in all pull requests and for the main branch
* There is a CI/CD pipeline for publishing Javadoc to document all classes and methods for backend Java code for the main branch, and each pull request
* Linting of Javascript code is integrated into the CI/CD pipeline via eslint

The pages below describe this architecture in more detail.

