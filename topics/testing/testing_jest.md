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

# Mocking "today's date" or the "current time"

Suppose you have frontend functionality that depends on "today's date" or the "current time", for example:

* HappyCows: Something that displays how many days have passed since the start of a game in Happy Cows
* Courses: Something that shows how many hours there are until the next class on your schedule
* Gauchoride: Something a driver shows how many minutes until the next scheduled drive

These often use code like this to get the current date and time:
```js
    const now = new Date();
```

The problem comes with testing.   Given that this will return a different value each time you run the test, how
can you ever test this code?

The solution is to mock the `Date()` constructor so that instead of returning the current date/time when no parameters are passed, it 
return a predictable value set by the programmer.

Here are two possible approaches:

1. Use this feature that is available in Jest since version 26 (which I'm pretty sure our code bases are on) as explained in this [Stack Overflow post](https://stackoverflow.com/a/63377110/6454116):

   ```js
   jest.useFakeTimers().setSystemTime(new Date('2020-01-01'));
   ```
2. If that doesnt' work, here's an older approach as explained in this [Stack Overflow article](https://stackoverflow.com/a/57599680).   

   Note that while the example code uses `new Date(1466424490000)`, you could also use something like
   `new Date("2023-06-04T13:19:11-07:00")` which is a lot more readable.  The `-07:00` marks the date as "Pacific Daylight Time"; use `-08:00` for Pacific Standard Time.

   ```js
    test('mocks a constructor like new Date()', () => {
      console.log('Normal:   ', new Date().getTime())

      const mockDate = new Date(1466424490000)
      const spy = jest
        .spyOn(global, 'Date')
        .mockImplementation(() => mockDate)

      console.log('Mocked:   ', new Date().getTime())
      spy.mockRestore()

      console.log('Restored: ', new Date().getTime())
    })
   ```
