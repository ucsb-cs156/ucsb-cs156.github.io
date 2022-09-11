---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: Excluding Code"
description:  "Excluding lines of code where mutation testing doesn't work"
category_prefix: "Stryker: "
indent: true
---

Sometimes there is code that, when a mutation is applied, the resulting code will still pass the tests.

Here is an example (taken from the [Strkyer documentationfor disabling mutations](https://stryker-mutator.io/docs/stryker-js/disable-mutants)):

```js
function max(a, b) {
  return a < b ? b : a;
}
```

One mutation that is applied here, the `EqualityOperator` mutation,  
turns this into:

```
function max(a, b) {
  return a <= b ? b : a;
}
```

The thing is, that is still a correct solution, so this mutation will not be killed by any correct test.

We can fix this by using a comment to disable mutations.  This comment disable all mutations on the next line of code:

```js
function max(a, b) {
  // Stryker disable next-line all
  return a <= b ? b : a;
}
```

But a better approach is to just disable the single mutation that is causing the trouble, since other mutations of this line
still result in mutations that can and should be killed by tests:

```js
function max(a, b) {
  // Stryker disable next-line EqualityOperator
  return a <= b ? b : a;
}
```

It is possible to add an explanation to comments like this by putting a colon at the end, like this:

```js
function max(a, b) {
  // Stryker disable next-line EqualityOperator: The <= mutant results in an equivalent mutant
  return a <= b ? b : a;
}
```

For more information, and a more detailed explanation, see:
* <https://stryker-mutator.io/docs/stryker-js/disable-mutants>

# More examples

Here is an example where `"GET"` is the default.   Replacing it with empty string `""` results in an equivalent mutation:

<img width="821" alt="image" src="https://user-images.githubusercontent.com/1119017/166524771-f61a52b7-66a6-4fa0-a7ea-e17c5d629642.png">

The best option here is to exclude this mutation, like this:

![Uploading image.png…]()

  return a <= b ? b : a;
