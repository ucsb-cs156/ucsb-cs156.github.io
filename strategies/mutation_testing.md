---
parent: Strategies
layout: default
title: Mutation Testing 
description:  "Hints for dealing with surviving mutants"
---

# Mutation Testing 


## Focus on one file at a time

If you have a large number of surviving mutations, it's best to focus on one at a time.

In the frontend, you can run stryker on one file at a time like this:

```
npx stryker run -m /full/path/to/the/file/being/mutated.jsx
```

You can copy this full path by right clicking on the top of the tab in VSCode.  Remember that you want:
* the path of the implementation of the component (e.g. `FooTable.js`) ✅  
* *not* the path for the test of the component (e.g. `FooTable.test.js`) ❌ 

For the backend instructions for running pitest on only a portion of the code
can typically be found in the README.md, for example

* [ucsb-cs156-f25/STARTER-team02](https://github.com/ucsb-cs156-f25/STARTER-team02?tab=readme-ov-file#partial-pitest-runs)
* [proj-courses](https://github.com/ucsb-cs156/proj-courses?tab=readme-ov-file#partial-pitest-runs)
* [proj-dining](https://github.com/ucsb-cs156/proj-dining?tab=readme-ov-file#partial-pitest-runs)
* [proj-frontiers](https://github.com/ucsb-cs156/proj-frontiers?tab=readme-ov-file#partial-pitest-runs)
* [proj-rec](https://github.com/ucsb-cs156/proj-rec?tab=readme-ov-file#partial-pitest-runs)



## Ask: is the code really needed?

*Typically*, when there's a mutation that survives, the code is essential code for which you need to write a test.

But *sometimes*, the fact that the test suite passsed without that line of code is a sign that you *might not need that code*.

This is often the case in the frontend with `data-testid` values.  

Suppose all other tests are passing, you have 100% test coverage, and the last surviving mutation is something like this:

<img width="921" height="311" alt="image" src="https://github.com/user-attachments/assets/6a209f3f-ace1-4605-bd0a-0f4b3cb259e5" />

* You *could* write a test to detect that this `data-testid` value shows up in the code.
* But it woudl be better to *just eliminate this `data-testid` value*!

Here's why: the *sole purpose* of `data-testid`  values is to help you locate specific elements on the page when writing tests.  It's always *better* to find those elements by text, or label text, or something visible to the user; but occasionally, that's not feasible (e.g. when there could be multiple elements with the same text.

If you've already written all the tests you need, and you never had a need for this particular `data-testid` value, you can just eliminate it.

**This is not the only case where just eliminating the code may be the best choice to eliminate a surviving mutation**.

A few other examples:
* Default values in components that are never actually used or needed in the application.
  * Sometimes we add default values when first setting up a component, and they may be helpful for storybook or testing, but are *never used* in the application code.
  * Rather than writing tests to cover the defaults, just fill in the default value in the tests and storybook, and then eliminate the default value.
* The `{" "}` constructor in React Components
  * *Sometimes* this is needed to preserve space between words
    (in which case you can write a test to ensure that the space between words is there.)
  * But *often*, you can just eliminate these spaces (which are inserted by `prettier` when you do `npm run format`) and
    there is no impact on the displayed text.
* Sorting/Filtering in the frontend (if it can be moved to the backend)

  Here's some code that sorts data in a table:
  <img width="737" height="143" alt="image" src="https://github.com/user-attachments/assets/037d3901-6abd-4704-97c7-f6c0ab2051a9" />

  By moving the sort to the backend [as explained here](https://ucsb-cs156.github.io/strategies/design.html#when-possible-sortfilter-in-the-backend-rather-than-the-frontend), we were able to eliminate this code, and there the need to write a frontend test for it.


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

