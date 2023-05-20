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

To cover this with a test, we can use `mockConsole` from the library [jest-mock-console](https://www.npmjs.com/package/jest-mock-console).  This creates a mock for the console object, so that we can track calls to `console.log` and make assertions about them:

Add this import:

```
import mockConsole from "jest-mock-console";
```

Then, since this `console.log` occurs inside the callback function that is invoked when we click the edit button, we find a test that clicks the edit button, 
and put this near the top of it, in the `// arrange` section of the test (this is a reference to the three-part "arrange/act/assert" outline for tests.)

```
    const restoreConsole = mockConsole();
```

Here's what that looks like in context.  Note that the blue line at left in VSCode shows the new lines of code added (the call to mockConsole, and an extra blank line afterwards):

<img width="710" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/2be14356-e895-4f12-bec6-88f9c4488919">

Then, near the bottom of the test, in the last part of the `// assert` section, add code like this that checks whether `console.log` was invoked, and if so, with what message:

```js
    // assert - check that the console.log was called with the expected message
    expect(console.log).toHaveBeenCalled();
    const message = console.log.mock.calls[0][0];
    const expectedMessage =
      `editCallback: {"id":2,"name":"The Beverly Hills Hotel","description":"A legendary hotel known for its iconic pink façade and Hollywood glamour, this luxury hotel offers spacious rooms, a full-service spa, and a stunning outdoor pool."})`;
    expect(message).toBe(expectedMessage);
    restoreConsole();
``` 

Here is what that looks like in context:

TODO New screenshot

Explaining each of the lines of code:

| Line of code | Explanation |
|--------------|-------------|
| `import mockConsole from "jest-mock-console";` | imports the [jest-mock-console](https://www.npmjs.com/package/jest-mock-console) library |
| `const restoreConsole = mockConsole();` | sets up the mock, and returns a handle to a function that can be invoked to restore `console` to it's normal function (instead of the mock) |
| `expect(console.log).toHaveBeenCalled();` | self explanatory; uses the `expect` and `toHaveBeenCalled` functions from jest [documented here](https://jestjs.io/docs/expect) |
| `const message = console.log.mock.calls[0][0];` | the object `console.log.mock` has information about calls to the mock.  The first `[0]` returns an array of the parameters to the first call to `console.log`, and the second `[0]` indexes into that array to return the first parameter to that call to `console.log` |
| `const expectedMessage = "...";` | This sets up the message we expect to see.  You want to look at the original `console.log` call, as well as the test and test fixtures to determine what this will look like, or use the hacky shortcut described below. |
| `expect(message).toBe(expectedMessage);` | Uses the jest `expect` and `toBe` syntax [documented here](https://jestjs.io/docs/expect) to determine if the message is the expected one.  You may see `match` instead of `toBe` in some example code; `match` works a bit differently (see the documentation). |

# The hacky shortcut

In the table above, I referred to a hacky shortcut for determining what the expected message should be.  

The *better* more *rigorous* way is to think through the code, trace it out, and determine what the parameter to `console.log` will be by hand.  This helps you think through the flow of the code and understand it better, and possibly find additional bugs you weren't even looking for.

But, in a pinch, if you are short on time, there's a hacky shortcut to determine what the expected output is.

* Set the expected output to "empty string".  
* Be sure that the test uses `expect` with `toBe` (if you use `match`, use `"foo"` for the expected value instead of empty string, since empty string will pass for `match` on anything.) 
* Run the test once.  It will fail, and show you what the actual value is.
* As long as the value makes sense, you can then populate the test with that value.  

Example: 

Setting expected output to empty string:
<img width="752" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/48f19946-f4ec-4389-92bf-8c1e96cbff75">

You can run the full test suite with `npm test`, but as a shortcut, you can just run the single test file with: `npm test -- HotelTable` where `HotelTable` is the component you are testing.  This will run only test files that have `HotelTable` as a substring of the filename (e.g. `HotelTable.tests.js`)

That results in this output (in part):

<img width="659" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/c9e8e64e-ae9c-4507-a84d-9ceb9dcc9c20">

You can then copy/paste the value that's expected into the test, like this:

<img width="854" alt="image" src="https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/964af1ef-b853-46e9-ac4f-481e84cffc10">

Note that this syntax is a bit harder to read then the one where we use backticks (``) to avoid having to escape all of the quotations marks (`""`) with backslashes.  Compare:

```
// backticks:
const expectedMessage =
   `editCallback: {"id":2,"name":"The Beverly Hills Hotel","description":"A legendary hotel known for its iconic pink façade and Hollywood glamour, this luxury hotel offers spacious rooms, a full-service spa, and a stunning outdoor pool."})`;
```

vs. 

```
// quotations marks with escaped quotation marks:
const expectedMessage =
  "editCallback: {\"id\":2,\"name\":\"The Beverly Hills Hotel\",\"description\":\"A legendary hotel known for its iconic pink façade and Hollywood glamour, this luxury hotel offers spacious rooms, a full-service spa, and a stunning outdoor pool.\",\"address\":\"9641 Sunset Blvd, Beverly Hills, CA 90210\"}"
```

However, either one will work.
