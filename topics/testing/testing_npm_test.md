---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: npm test"
description:  "options for running npm test"
---

In most projects in this course, when running `npm test`, you are actually invoking a script defined in `package.json` like this:

```json
 "scripts": {
    "test": "react-scripts test",
```

Some documentation for this can be found here:
* <https://create-react-app.dev/docs/running-tests/>

# Command line options for `npm test`

By typing the following command (note the extra `--` in the middle) you can get a list of command line options for `npm test`.

* Note that the `--` means that any further command line options are passed to `jest`, which  is the software that is used by `npm test`, rather than being passed to `npm` itself.


```
npm test -- --help
```

A reference for these options appears here: <https://jestjs.io/docs/cli>

# Running only some tests

One of the most useful command line options is the simple `-t` option, which takes a regular expression for the test description as its argument.

## Running only tests from a certain file

Suppose the test you are working on is in the file `frontend/src/tests/components/Commons/CommonsTable.test.js`.

You can copy this path in VSCode by right clicking at the top of the file tab 
and selecting `Copy Relatve Path`, like this:

<img width="466" alt="right click on top tab, select 'Copy Relative Path'" src="https://user-images.githubusercontent.com/1119017/201546083-58e9d952-fd44-4838-ab6b-e5338c6a42c8.png">

Then you can paste that into this command (note that you must use the arrow key on the command line to delete the prefixed `frontend/` since you are already in that directory:

```
npm test -- src/tests/components/Commons/CommonsTable.test.js
```

This runs only tests from this file, as shown below:

<img width="1130" alt="screenshot showing tests only run from one file" src="https://user-images.githubusercontent.com/1119017/201546158-a8bc7095-d98d-4847-b942-9299bbb79262.png">

## Running only tests with a certain description:

Suppose you are working on this test:

```
 test("Has the expected column headers and content for adminUser", () => {
```

If you type the following, it will run only tests that match this description:

```
npm test -- -t "Has the expected column headers and content for adminUser"
```

As it turns out, when I ran this example, there were two tests that matched this description, in two different files.  One passed and the other failed, as shown in this
output:

<img width="1119" alt="screenshot showing that one test passed and another failed" src="https://user-images.githubusercontent.com/1119017/201545531-065b3a2e-7bd9-406b-ab77-3ed831f04c27.png">

Since the argument is a regular expression, we can often specify just part of it with the same effect.  For example, this has the same effect as the longer command above:

```
npm test -- -t "Has the expected column headers"
```

Here's what that looks like; note that it matches the output above in terms of which tests were run:

<img width="858" alt="screenshot showing that one test passed and another failed" src="https://user-images.githubusercontent.com/1119017/201546235-093e9bfe-d0d7-4063-83d6-e239989418ab.png">


## Running only tests from a specific file with a specific description

We can also restrict to running only tests from a certain source file, for example, only the tests in `frontend/src/tests/components/Commons/CommonsTable.test.js`
by combining the two command arguments: 

```
npm test -- src/tests/components/Commons/CommonsTable.test.js -t "Has the expected column headers"
```

Now we get only the single test run:

<img width="1171" alt="output from npm test -- src/tests/components/Commons/CommonsTable.test.js -t 'Has the expected column headers'" src="https://user-images.githubusercontent.com/1119017/201546327-4322820c-5a13-4464-a10f-27cf88ca28a2.png">


