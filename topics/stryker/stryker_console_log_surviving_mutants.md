---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: console.log surviving mutants"
description:  "Hints on resolving these"
---

Here is an example of a mutation report showing that a mutation eliminating a console.log message survived:

<img width="453" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/a65b6eec-7c02-487f-b972-37f6d61d009e">

This is showing that the code:
```
console.log(`editCallback: ${showCell(cell)}`);
``` 

Was mutated to the following, without any tests failing (i.e. "the mutant survived").
```
console.log(``);
``` 

Since this occurred in the file `src/main/components/Hotel/HotelTable.js`, we want to edit the test  `src/tests/components/Hotel/HotelTable.tests.js`.

To cover this with a test, we can use `mockConsole`.  This creates a mock for the console object, so that we can track calls to `console.log` and make assertions about them:

Add this import:

```
import mockConsole from "jest-mock-console";
```

Then, since this `console.log` occurs inside the callback function that is invoked when we click the edit button, we find a test that clicks the edit button, 
and put this near the top of it:

```
    const restoreConsole = mockConsole();
```

Here's what that looks like in context.  Note that the blue line at left in VSCode shows the new lines of code added (the call to mockConsole, and an extra blank line afterwards):

<img width="710" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/2be14356-e895-4f12-bec6-88f9c4488919">

