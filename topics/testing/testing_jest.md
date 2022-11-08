---
parent: "Testing"
grand_parent: Topics
layout: default
title: "Testing: Jest Testing"
description:  "Testing and Test Coverage for JavaScript code"
category_prefix: "Testing: "
indent: true
---


# Local Conventions

To run jest on repos set up using the Spring/React conventions used in CS156, use these commands:

Note: All of these are run from the `javascript` subdirectory of the project.

| Command | Description |
|-|-|
|`npm test`| runs the test suite |
|`npm run coverage`| generates a coverage report |


The detailed coverage report (with line-by-line reports for each source file) can be found by opening this file in a web browser:
* `javascript/coverage/lcov-report/index.html`


# Hiding the "Wall Of Red"

When testing with Jest, especially when mocking 404 errors, you can get a wall of red error messages, even on a passing test, like this:

<img width="1124" alt="image" src="https://user-images.githubusercontent.com/1119017/166522677-98da7cf9-f386-4691-b888-f14d6b7aa8c7.png">

To avoid it, you can temporarily redirect the output of console.error.  Note that this can hide error messages that you might sometimes *need* to see,
so use this sparingly.

* <https://dev.to/martinemmert/hide-red-console-error-log-wall-while-testing-errors-with-jest-2bfn>


