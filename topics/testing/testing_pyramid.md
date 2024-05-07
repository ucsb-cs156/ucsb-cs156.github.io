---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Pyramid"
description:  "The three levels"
---

# The Testing Pyramid

The [testing pyramid](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html#testing_pyramid:~:text=units%20work%20together.-,Testing%20Pyramid,-Even%20with%20both) (shown below) is a way of thinking about three kinds of tests:

* Unit tests, at the bottom of the pyramid, test each unit of the system *in isolation from all other units*.  Ideally, for unit tests, anything external to the unit (e.g. database calls, api calls, etc.) is *mocked*; i.e. instead of the test depending on the correct behavior of the external method or function, a mock of that method or function is supplied that supplies the values that the test expects.
* Integration tests, in the middle, test how two or more units function together.  Here, we are still testing some individual unit of software (for example, a backend controller), but in this case, we might actually use actual database calls to a real live database. That allows us, for example, to perform a `POST` operations on an end point, and then assert that the number of rows in the appropriate database table went up by one, and that the contents of the affected database row are correct. In this case, it's important that the external dependencies (e.g. the database) be in a *known start state* and are *isolated* from the effects of other tests.  Some things, though, that are external might still need to be mocked (for example, an API that changes the state of the world in some way in a system other than the one under test, or an API that might return different information depending on the time of day.)
* End to End tests, at the top, are tests where we try as much as possible to *not* depend on specific implementations of features, but instead, just interact with the system the way a human user would.  For end to end tests, we use a testing framework that can simulate the actions of a human user interacting with a real browser. 

<img width="454" alt="testing pyramid" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/cfbc9f96-af05-45de-bf54-bff7472a262a">

The pyramid puts 
end-to-end testing (also sometimes called UI testing) at the top of the pyramid and unit tests at the bottom.  The pyramid is meant to represent the idea that most of your tests
should be unit tests, with fewer integration tests, and even fewer end-to-end tests.  Unit tests are tend to run quickly, and test failures are typically easier to debug.  However, units
testing only tests the code in a relatively shallow way; bugs may remain even if all of the unit tests pass.  End-to-end tests test the code much more thoroughly, and interact 
wtih your systems the way a real user interacts with your application, which can be more valuable in terms of finding problems. However, they run much more slowly,  are expensive to write
and maintain, and it can be much more difficult to pin down the reason for a test failure.  Integration tests fall somewhere in the middle.

This article from a blog maintained by developers at Google goes into more detail about this idea:

* <https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html#testing_pyramid:~:text=units%20work%20together.-,Testing%20Pyramid,-Even%20with%20both>



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

End-to-end testing is the level closest to manual testing. Conceptually, it is basically an automated form of manual testing. Writing end-to-end tests requires little or no knowledge of the application's implementation, and treats the application as a "black box". Some kind of browser automation software is used to simulate the actions a user would take on an instance of a real browser. The software can simulate clicking buttons, filling out fields, and can make assertions about the contents of the web page.

The point of end-to-end tests is not quite to catch any specific issue in a single unit (thats what unit tests are for), rather it's for verifying that the application behaves as expected for various tasks.

End-to-end tests have two modes they are typically run in:

1. “headless”, where there is no real browser being rendered on a screen; it’s all just simulated in memory. This is the usual way of running end-to-end tests because its a lot faster.
2. “not headless” where the tester can actually watch all of the interactions happen on screen (albeit very quickly) as the tests are being run. This is typically only used when developing or debugging the end-to-end tests.

You can find out more about the tools we have used for end-to-end testing in our stack here: 

[Testing: Integration and End-to-end Testing](https://ucsb-cs156.github.io/topics/testing/testing_integration_e2e_tests.html)
