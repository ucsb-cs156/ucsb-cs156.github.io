---
parent: Topics
layout: default
title: "Testing"
description:  "Everything having to do with testing: Unit testing, Integration Testing, Test Coverage"
category_prefix: "Testing: "
has_children: true
---

# Testing


# Test Coverage

It's helpful to be able to measure how much of our code is covered by tests.  This metric is known as "test coverage" or "code coverage".  

* General Introduction, including line vs. branch coverage: <https://ucsb-cs156.github.io/topics/testing_coverage/>
* JaCoCo, a test Coverage Tool for Java: <https://ucsb-cs156.github.io/topics/testing_jacoco/>
* `coverage`, a test coverage Tool for javascript: <https://www.npmjs.com/package/coverage>

If a very large portion of our code base is not covered by tests, that's not good; it means that bugs in that part of the code base will not be detected.

However, 100% code coverage is *not* a guarantee that our code won't have bugs; it's easy to write tests that "cover" the code (i.e. execute it) but lack
any assertions about whether the code is, or is not, correct.  For that, we can use a more powerful tool called *mutation testing* (see below).

# Mutation Testing

Mutation testing is another way to check the quality of our tests.

Test coverage is easy to "game", so if we want to have strong confidence in our test suite, we can use a more powerful tool called *mutation testing*.

Mutation testing creates dozens or even hundreds copies of our code base, each with a single *mutation*&mdash;a change that should cause some test to fail/
* Each version of the code base is called a *mutant*
* For each *mutant*, we run the entire test suite against the mutant to see what happens.
* If some test fails, we say that the mutant is "killed".  That's a good outcome; it means our tests are powerful enough to detect that bug.
* If the mutant passes all of the tests, we say the mutant "survived". That's a bad outcome.  It means that there is a class of bugs that our test suite cannot detect.

Mutation testing frameworks typically also calculate line coverage as part of their process, but go beyond it, reporting also on the percentage of mutants that were killed or survived.

# Timeouts of individual mutation tests

Note that as a consequnce of the [Halting Problem](https://en.wikipedia.org/wiki/Halting_problem) (discussed in CMPSC 138) it is not possible to write an general algorithm to determine whether some code represnents an infinite loop or not; accordingly, there is a third outcome beyond "killed" and "survived".  A mutation, may inadvertantly introduce an infinite loop into the code that is being run by a test, and there is no known way to deal with this other to simply set an arbitrary upper limit on how long each test is given to run, and at some point, assuming the test is in an infinite loop.

These mutants are reported as having "Timed Out", and the results of these tests are inconclusive, and generally ignored.  This is a known weakness of mutation testing, but one that is generally outweighed by its advantages.

# Timeouts of the entire mutation run

If you are running mutation testing in a Github Actions script, you may find that the overall time allocated to the job is not enough.  This is not the same as the "halting problem" issue discussed above, but is more a consequence of the fact that mutation testing makes dozens or hundreds of copies of your entire code base, and runs the whole test suite on each one of them.

If you find that a Github Action doing mutation testing is timing out, look for a line such as this on in the `.yml` file for the workflow (typically under the directory `.github/workflows` at the top level of the repo): 

```
   timeout: 30
```

Each time you experience a timeout, consider doubling this time, e.g. replacing `timeout: 30` with `timeout: 60`.


# Test Coverage vs. Mutation Testing

* Test coverage is much, much faster than mutation testing (like 100 or 1000 times faster), so it's usually good to run coverage first, before running mutation testing.
  - If you see uncovered parts of the code, you know where to start writing tests.
  - Test coverage is good at quickly and efficiently identifying where to start when you don't have any tests at all for some part of the code base.
  - However, 100% test coverage is not a guarantee of good tests.  It just means you have something, as opposed to nothing.
* Mutation testing is much, much slower, but gives you much more confidence.
  - While it cannot guarantee that your code is bug free, it can catch many things that simple test coverage doesn't.
  

# Testing Strategies

Sometimes a developer can get lost in a sea of failing tests (backend or frontend), and get get really frustrated and unable to make progress.

In that situation, consider the following strategy:

* **Temporarily** comment out the failing tests on your feature branch.  
  - Note that it is a bad practice to merge commented out code into the `main` branch
  - But, it's perfectly fine to comment out code in a `feature` branch *while you are working on it*, as a debugging strategy.
* Test the app with actual functionality: running the backend and frontend together
  - Test the backend with Swagger
  - Test the frontend with either Storybook, or with the real frontend that's connected to the backend
  - Fix anything that’s broken so that a ‘real user’ would perceive that the app works properly.
  - Fix (or comment out) any tests that you might break along the way
* Now with a green test suite, run the coverage checks first:
  - `mvn test jacoco:report` for backend
  - `npm run coverage` for the frontend
  - Address any test gaps, which might include uncommenting and fixing some of the commented out tests, or adding new tests
* Still with a green test suite, run mutation coverage reports
  - `mvn pitest:mutationCoverage` for the backend
  - `npx stryker run` for the backedn
  -  Address any additional test gaps, which might include uncommenting and fixing some of the commented out tests, or adding new tests
* When you are at a stage where all of the following are true, you can just remove the commented out tests before your PR is merged to main
  - the app works properly for the end user
  - it passes all of the unit tests (`mvn test` for backend, `npm test` for the frontend)
  - 100% on both test coverage (jacoco/coverage) and mutation coverage (pitest/stryker) 

# Flaky Tests

The term *flaky tests* refers to tests that have an unpredictable outcome. Typically, these tests sometimes pass and sonetimes fail, even when neither the test has changed, nor has the code being tested changed.

## Articles about flaky tests

* <https://semaphoreci.com/blog/flaky-react>
