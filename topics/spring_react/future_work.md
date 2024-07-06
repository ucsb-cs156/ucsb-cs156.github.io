---
parent: "Spring/React"
grand_parent: Topics
layout: default
title: "Spring/React: Future Work"
description:  "Ways in which we would like to improve the CS156 Spring/React code bases"
category_prefix: "Spring React: "
indent: true
---


We have identified several projects that could be undertaken to extend the current framework in support of one or more of these goals:
* Providing students with a more authentic experience of widely used industry practices
* Supporting a wider range of target applications
* Improving the code base


# End to end testing with Playwright

The main idea is this: currently the CMPSC 156 legacy code projects (Gauchoride, Happy Cows, Courses Search) all have unit testing for both the frontend (Javascript) and backend code.  But there is no end to end testing, which means that bugs that involve incorrect integration of front and backend units, or even incorrect integration of units within the front and backend may go undetected.   A solution to this problem is  end to end testing , which typically involves:

* Automating the setup of a full test  deployment of the application, including external dependencies such as database systems (in our case, the relevant technologies would be Spring Boot Testcontainers and Docker.)
* Digging into the Spring Boot Authentication/Authorization system to provide an alternative to OAuth authentication that only applies in the test environment, but is close enough to the real Google OAuth Authentication that the test results are still valid.
* Using Playwright to automate the actions that a user would take in a browser and make assertions about the content of the returned pages.

It's a challenging project, but you'd potentially have some help; there may be other students working on it as well.

See also:
* <https://www.youtube.com/watch?v=B2bGxIqkuIM>
* <https://www.lukegjpotter.com/2024/07/spring-boot-testcontainers-with.html?m=1>

# Database Migrations

Currently, whenever we make a change to a CMPSC 156 project that alters the database schema, the application breaks unless we rebuild the database from scratch.

But we are on the brink of actually going live with at least two (possibly three) of the applications, with real live production users.  Once that happens, jsut "resetting the database" when there is a schema change is no longer a viable strategy.  Instead, we need a proper database migration solution such as Flyway or Liquibase.

The work here is to:
* Examine pros/cons of Liquibase vs. Flyway, and choose one.
* Construct examples and programming exercises for first staff, then students, to get comfortable with the technology.
* Incorporate it into our actual practice.

# Speeding up Stryker 

Folks in m23-10am-4 (esp. Iain) worked on a workflow that would only do stryker mutation testing on the changed files in the PR.

We should review this, and consider establishing this as the new workflow for all of our STARTER code bases, and each of our legacy projects.

# Paged database queries

The proj-happycows app has a new example of how to do paged database queries and present those to the user with a paged frontend; there
are likely many other places in our code bases where this could be done as well.

# Autograders for team01, team02, team03

There is an autograder for team01, but it needs some updating.

It would be great to have autograders for team02 and team03 as well.  This may require some updates to the assignments, but that's ok.

# Speed up Dokku Deploys

Figure out the mystery of this: https://dokku.com/docs/deployment/zero-downtime-deploys/

```
No CHECKS file found. Simple container checks will be performed.
For more efficient zero downtime deployments, create a CHECKS file. See https://dokku.com/docs/deployment/zero-downtime-deploys/ for examples
```

# Add more observability 

* <https://codeline24.com/spring-boot-observability-tracing-monitoring-logging/>
