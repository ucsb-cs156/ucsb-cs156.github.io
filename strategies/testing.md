---
parent: Strategies
layout: default
title: Testing 
description:  "Hints for writing good tests and getting them to pass"
---

# Testing Strategies

## Focus on one failing test at a time

If you have a large number of failing tests, the output can get overwhelming. This will slow you down.

Instead, try to focus on one test at a time.  Here are specific strategies for doing that:

**Backend**: Use a command like this to run only one set of backend tests.  Here `FooControllerTests` is the name of the test class (not the unit under test):

```
mvn test -Dtest=FooControllerTests
```

You can further limit the run to a single test by using:

```
mvn test -Dtest=FooControllerTests\#method_name_of_test
```

You can also limit the tests by commenting out all tests, and uncommenting them one at a time.  Each time a test fails, focus on fixing that one until they all pass.

**Frontend**: You can use this command to focus on tests for one file at a time. In this case, the expression after the `--` is treated as a regular expression, so you only need as many characters as are needed to match what you are testing:

```
npm test -- FooTable
```

You can further control which tests run by changing code as follows:

| Change this | To This | For this result |
|-|-|-|
| `test(...)` | `test.only(...)` | Only this test will run. If there are multiple tests marked with `.only`, that set of tests will run |
| `test(...)` | `test.skip(...)` | Skip this test. |


You can also apply `.only` and `.skip` to entire `describe` blocks, and to tests marked with `it` instead of `test`.

## Maybe the test is right and the code is wrong

If you are trying to figure out why a test is not passing, and you are stuck, ask yourself this question:

* Is it possible that the test is *right* and the *code* is wrong?

Things to try:
* If this is a frontend test: do you have a storybook entry for the component? If so, try walking through all of the steps of the test in the storybook component. (If you don't have a storybook entry yet, make one; that process may help you discover what you've missed).
* Try actually running the code *for real* with the full backend and frontend, either on `localhost` or a `dokku` deployment.  Does the code actually *do* what it's supposed to do? 

## `Stryker was here` mutations

If you are having difficulty killing a `Stryker was here` mutation, here's a strategy:

1. Make the mutation your self in the code.  For example, actually change:
   ```js
     const [courseNumber, setCourseNumber] = useState(");
   ```

   to
   ```js
      const [courseNumber, setCourseNumber] = useState("Stryker was here);
   ```

2. Then, load the component on Storybook and see if there is a circumstance where you can actually *see* the impact of the mutation on the component.

3. Then, try to write a test that fails because of the impact of the mutation.

Note that this is actually a strategy for *any* kind of mutation, but the `Stryker was here` is often the easiest to see in the component.

For example, when I made the change above, I got this:

<img width="903" height="168" alt="image" src="https://github.com/user-attachments/assets/0af9abf3-d973-4457-a698-bf7a28cc7bfd" />

The problem with my test is that I was checking for the contents of this field like this:

```js
expect(screen.getByTestId("CourseOverTimeSearchForm.SearchString")).toHaveTextContent("ANTH");
```

when I needed to use a regular expression to be sure that I wasn't just finding a substring. The `^` means "start of string", and the `$` means end of string.

```js
expect(screen.getByTestId("CourseOverTimeSearchForm.SearchString")).toHaveTextContent(/^ANTH$/);
```
