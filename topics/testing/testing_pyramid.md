---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Pyramid"
description:  "Integration and End to End testing with our stack"
---

The [testing pyramid](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html#testing_pyramid:~:text=units%20work%20together.-,Testing%20Pyramid,-Even%20with%20both) puts 
end-to-end testing (also sometimes called UI testing) at the top of the pyramid. While the testing pyramid is not a perfect representation of the importantance of each level of testing, it serves as a very good high level overview of what kind of balance to strike between the various kinds of tests in an application.  The idea is that you should have lots of unit tests (which are 
fast, but only test the code in a shallow way) and very few end-to-end tests, which test the code the way a real user interacts with your application,
but are expensive to run and expensive to maintain.

<img width="454" alt="testing pyramid" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/cfbc9f96-af05-45de-bf54-bff7472a262a">

# The three levels 

## Unit Testing

At the base of the testing pyramid, we have unit tests, which is the widest portion becuase they should make up the majority of the tests written for an application. Unit tests only test a single portion of the code at a time, where everything outside of that portion is mocked, in order to determine whether or not what we have written in the single portion works the way we intend. Mocked meaning that the behavior of those elements is simulated as opposed to using the real components. For example, a controller unit test might test whether or not an item can be deleted using the `DELETE` endpoint, and components typically involved in this transaction like the network and database are mocked. 

The advantage of unit tests is that they run quickly, meaning having unit tests for each portion of an application does not cause an extreme slowdown in the test suite. Not only that, there are additional metrics that can help ensure some level of quality in order tests, namely [test coverage](https://ucsb-cs156.github.io/topics/testing/#test-coverage) and [mutation coverage](https://ucsb-cs156.github.io/topics/testing/#test-coverage).

While unit tests have the potential to expose more complex issues, unit tests often miss issues caused by the interaction of multiple components, which is why we have higher levels in the testing pyramid.

## Integration Testing

## End-to-end Testing

...despite all this, not to burst anyone's bubble, but even with more advanced topics in testing (fuzzing, concolic execution), it is impossilbe to prove for non-trivial applications, that they are free of bugs.

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
