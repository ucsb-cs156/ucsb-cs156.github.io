---
parent: Stryker
grand_parent: Topics
layout: default
title: "Stryker: Excluding Code"
description:  "Excluding lines of code where mutation testing doesn't work"
category_prefix: "Stryker: "
indent: true
---

# {{page.title}}

## {{page.description}}

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

# `GET` as default

Here is an example where `"GET"` is the default.   Replacing it with empty string `""` results in an equivalent mutation.  As a result, we exclude the line with a `// Stryker disable next-line all` directive in a comment.

<img width="821" alt="image" src="https://user-images.githubusercontent.com/1119017/166524771-f61a52b7-66a6-4fa0-a7ea-e17c5d629642.png">


# Optional Chaining

Sometimes you write a line of code that uses optional chaining to avoid null pointer references as in this line of code:

```js
 const isUserInCommon = currentUser?.root?.user?.commons?.some(common => common.id === parseInt(commonsId));
```

Stryker will mutate this by trying to remove each `?` one at a time. You can see that on the Stryker report (in HTML format) by clicking
on each of the red circles in turn to see the mutation.

![Stryker Optional Chaining mutations](https://github.com/ucsb-cs156/ucsb-cs156.github.io/assets/1119017/6bcb0ab8-f93c-4554-8fc1-be39955ccd9f)


          
          


          
