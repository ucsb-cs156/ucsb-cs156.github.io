---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Pyramid"
description:  "Integration and End to End testing with our stack"
---

The [testing pyramid](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html#testing_pyramid:~:text=units%20work%20together.-,Testing%20Pyramid,-Even%20with%20both) puts 
end-to-end testing (also sometimes called UI testing) at the top of the pyramid.  The idea is that you should have lots of unit tests (which are 
fast, but only test the code in a shallow way) and very few end-to-end tests, which test the code the way a real user interacts with your application,
but are expensive to run and expensive to maintain.

<img width="454" alt="testing pyramid" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/cfbc9f96-af05-45de-bf54-bff7472a262a">

In our applications, we run end to end tests using these tools:

* Playwright (the Java version), to do simulation of what a user types in a browser
* Wiremock, to simulate OAuth2 authentication with external OAuth providers (e.g. Google, Github) so that we don't have to hardcode real usernames and passwords
* H2 to set up a database for these end-to-end tests.

This article describes some of the things you may need to know about how we use these tools.

## Playwright

ANDREW FILL THIS IN.  You may make reference to the code in the STARTER-jpa03 and/or STARTER-team03 repos if it helps.

## Wiremock

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
