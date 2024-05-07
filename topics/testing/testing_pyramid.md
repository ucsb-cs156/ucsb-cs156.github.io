---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Pyramid"
description:  "The three levels"
---

# The Testing Pyramid

The [testing pyramid](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html#testing_pyramid:~:text=units%20work%20together.-,Testing%20Pyramid,-Even%20with%20both) puts 
end-to-end testing (also sometimes called UI testing) at the top of the pyramid. While the testing pyramid is not a perfect representation of the importantance of each level of testing, it serves as a very good high level overview of what kind of balance to strike between the various kinds of tests in an application.  The idea is that you should have lots of unit tests (which are 
fast, but only test the code in a shallow way) and very few end-to-end tests, which test the code the way a real user interacts with your application,
but are expensive to run and expensive to maintain.

<img width="454" alt="testing pyramid" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/cfbc9f96-af05-45de-bf54-bff7472a262a">

# The Three Levels 

## Unit Testing

At the base of the testing pyramid, we have unit tests, which is the widest portion becuase they should make up the majority of the tests written for an application. 

Unit tests only test a single portion of the code at a time, where everything outside of that portion is mocked, in order to determine whether or not what we have written in the single portion works the way we intend. Mocked meaning that the behavior of those elements is simulated as opposed to using the real components. For example, a controller unit test might test whether or not an item can be deleted using the `DELETE` endpoint, and components typically involved in this transaction like the network and database are mocked. 

The advantage of unit tests is that they run quickly, meaning having unit tests for each portion of an application does not cause an extreme slowdown in the test suite. Not only that, there are additional metrics that can help ensure some level of quality in order tests, namely [test coverage](https://ucsb-cs156.github.io/topics/testing/#test-coverage) and [mutation coverage](https://ucsb-cs156.github.io/topics/testing/#test-coverage).

While unit tests have the potential to expose more complex issues, unit tests often miss issues caused by the interaction of multiple components. Additionally, some level of knowledge of the program's implementation is required in order to write effective tests especially when considering additional quality metrics. 

## Integration Testing

In some cases, just unit tests may not be enough to reliably determine whether or not the intereactions of some portions of an application will go according to plan. For some assignments in this course, you may have noticed that despite all of the unit tests pass with 100% code coverage and all mutations killed, that the application does not work correctly. That is one of the major downsides to only having unit tests in a test suite, which is why the testing pyramid is made up of multiple levels.

Integration tests come in many forms and can even have the same structure as a unit test, but instead of mocking everything outside of the unit that you are testing, real versions of some units are used instead of their mocks.

For example, a controller integration test may have the exact same structure as a controller unit test, but instead of mocking the calls to the database, a real database is used with real calls made to it. 

This brings up some of the important considerations for tests in a test suite beyond unit testing, maintaing the database in a controlled way such that we can make assumptions about its contents prior to the test, and assertions after. If we have consecutive tests that involve database operations we do not want stuff from the first test to affect the second test, as it can result in uncertainty about the state of the database in the second test. There are a number of options to achieve this, all of which incur some level of cost. More on how we decided to tackle this issue in [`this article`](https://ucsb-cs156.github.io/topics/testing/testing_integration_e2e_tests.html).

## End-to-end Testing

...despite all this, not to burst anyone's bubble, but even with more advanced topics in testing (fuzzing, concolic execution), it is impossilbe to prove for non-trivial applications, that they are free of bugs.
