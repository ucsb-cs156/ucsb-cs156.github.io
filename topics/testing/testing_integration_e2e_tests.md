---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Integration and End-to-End Testing"
description:  "Integration and End-to-end testing in our stack"
category_prefix: "Testing: "
indent: true
---

# In the Context of our Stack

In our applications, we run end to end tests using these tools:

* Playwright (the Java version), to simulate how a user interacts with the application in a browser
* Wiremock, to simulate OAuth2 authentication with external OAuth providers (e.g. Google, Github) so that we don't have to hardcode real usernames and passwords
* H2 to set up a database for these end-to-end tests.

This article describes various aspects about these tools that you may need to know when working with our stack.

## Playwright

Playwright is an automation library for browser testing that allows us to simulate actions that a user might perform when interacting with our web application. You may have heard of similar libraries like Cypress and Selenium. 
ANDREW FILL THIS IN.  You may make reference to the code in the STARTER-jpa03 and/or STARTER-team03 repos if it helps.

## Wiremock

The projects in this course all use third party authentication providers, in most cases Google, and in the case of Organic, Github. Using authentication providers give
ANDREW FILL THIS IN.  You may make reference to the code in the STARTER-jpa03 and/or STARTER-team03 repos if it helps.

## H2

One of the issues when using a database in integration tests is to ensure that the contents of the database from one test don't interfere with the contents
of the database in another test.  Essentially, we want each integration test to have its own "private copy" of the database.  

That allows us
to do things like start with a table of Users that has 5 rows, delete 2 users, and then assert that the number of rows in the table is 3.

Clearly, if there were more than one test running against the same database, adding and deleting users, with the tests running in parallel,
this could get dodgy.

The way we accomplish this in the code is with the following lines in the code base:

1. The line: `spring.datasource.url=jdbc:h2:mem:${random.uuid}` in `src/main/resources/application-integration.properties`
2. The  annotation `@DirtiesContext(classMode = ClassMode.BEFORE_EACH_TEST_METHOD)` in the tests themselves.
3.
```

ANDREW: Continue from here.
```

## Running the Integration Tests

ANDREW: describe the commands for running the tests

## Debugging the Integration Tests

ANDREW: describe the commands for running the tests with `HEADLESS=false` and why you might want to do that, and maybe even show some
animations of what it looks like when you do.

You can use licecap to create the animations...
