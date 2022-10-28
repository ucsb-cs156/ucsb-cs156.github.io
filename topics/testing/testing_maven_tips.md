---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Maven Tips"
description:  "Tips on running tests with Maven for Spring/React projects"
category_prefix: "Testing: "
indent: true
---

# Summary of Maven Testing Tips

| Command | What it does | 
|-|-|
| `mvn test` | Run only backend tests |
| `mvn test jacoco:report` | Run only backend tests, and generate jacoco report |
| In web browser: `target/site/jacoco/index.html` | The detailed backend coverage report |
| `mvn test pitest:mutationCoverage` | Run only backend tests, and generate mutation coverage |
| `mvn test -DFooTests ` | Run just a single test file from the backend (specify filename) |
| `mvn test -DFooTests\#test_method_name ` | Run just a single *test*  from the backend (specify filename, then `\#`, then method name of test) |


# Details

Suppose you've run `mvn test` and you get a report like this:

<img width="1391" alt="image" src="https://user-images.githubusercontent.com/1119017/198691152-293c8677-d1fa-4a64-b35c-d60dcc615a3b.png">

Finding and fixing the root cause can be tedious, given that there is so much output.

Here's a strategy to make it easier:
* First locate the file and test method for a *single* failure
* Rerun the test suite to focus on *only that single failure*. Now the output is greatly reduced, and it will be easier to discover the cause!
* Repeat for each test that is failing

For example, in the output above, we see:

```
SystemInfoControllerTests.systemInfo__logged_out:31 Response status expected:<403> but was:<200>
```

The information given here tells us which class the test was in (`SystemInfoControllerTests`) and the name of the method: `systemInfo__logged_out`.  We can turn that into a command that will run only that one test.   

(Regrettably, we must replace the `.` between the class name and method name with `\#`; that's just how the system works.)

```
mvn test -Dtest=SystemInfoControllerTests\#systemInfo__logged_out
```

Now we can much more easily find the root cause.

Two other tips: I suggest bringing up two windows or tabs in your editor: one with the test that is failing, and another with the "unit under test", i.e. the specific method that the test is designed to examine.
